package com.ngaoschos.background

import android.Manifest
import android.content.ContentResolver
import android.content.ContentUris
import android.content.pm.PackageManager
import android.database.Cursor
import android.graphics.Bitmap
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.provider.MediaStore
import android.window.SplashScreenView
import androidx.activity.ComponentActivity
import androidx.activity.result.contract.ActivityResultContracts
import androidx.core.content.ContextCompat
import androidx.core.view.WindowCompat
import androidx.lifecycle.lifecycleScope
import com.bumptech.glide.Glide
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import java.io.ByteArrayOutputStream
import java.io.File
import android.graphics.BitmapFactory





class MainActivity: FlutterFragmentActivity() {

    private  val channelName = "com.ngaoschos.photo";
    private  val channelPhoto = "getPhotos";
    private  val channelFetchImage = "fetchImage";
    private var methodResult: MethodChannel.Result? = null
    private var queryLimit: Int = 0

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val messenger = flutterEngine.dartExecutor.binaryMessenger
        MethodChannel(messenger, channelName)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    channelPhoto -> {
                        methodResult = result
                        queryLimit = call.arguments()!!
                        getPhotos()
                    }
                    channelFetchImage -> {
                        val index = (call.arguments as? Int) ?: 0
                        dataForGalleryItem(index) { data, id, created, location , width, height, filePath ->
                            result.success(mapOf<String, Any>(
                                    "data" to data,
                                    "id" to id,
                                    "created" to created,
                                    "location" to location,
                                    "width" to width,
                                    "height" to height,
                                    "filePath" to filePath
                            ))
                        }
                    }
                }
            }
    }

    private fun getPhotos() {
        if (!hasStoragePermission()) return

        methodResult?.success(getGalleryImageCount())

    }



    private fun hasStoragePermission(): Boolean {
        val permission = Manifest.permission.READ_EXTERNAL_STORAGE
        val state = ContextCompat.checkSelfPermission(this, permission)
        if (state == PackageManager.PERMISSION_GRANTED) return true
        permissionLauncher.launch(permission)
        return false
    }


    private val permissionLauncher =
            registerForActivityResult(ActivityResultContracts.RequestPermission()) { granted ->
                if (granted) {
                    getPhotos()
                } else {
                    methodResult?.error("0", "Permission denied", "")
                }
            }


    private fun dataForGalleryItem(index: Int, completion: (ByteArray, String, Int, String,Int,Int,String ) -> Unit) {
        val uri = MediaStore.Images.Media.EXTERNAL_CONTENT_URI
        val orderBy = MediaStore.Images.Media.DATE_TAKEN

        val cursor = contentResolver.query(uri, columns, null, null, "$orderBy DESC")
        cursor?.apply {
            moveToPosition(index)

            val idIndex = getColumnIndexOrThrow(MediaStore.Images.Media._ID)
            val dataIndex = getColumnIndexOrThrow(MediaStore.Images.Media.DATA)
            val createdIndex = getColumnIndexOrThrow(MediaStore.Images.Media.DATE_ADDED)
            val latitudeIndex = getColumnIndexOrThrow(MediaStore.Images.Media.LATITUDE)
            val longitudeIndex = getColumnIndexOrThrow(MediaStore.Images.Media.LONGITUDE)

            val id = getString(idIndex)
            val filePath = getString(dataIndex)
            val file = File(filePath)
            val options = BitmapFactory.Options()
            options.inJustDecodeBounds = true
            BitmapFactory.decodeFile(file.absolutePath, options)
            val imageHeight = options.outHeight
            val imageWidth = options.outWidth
            val bmp = MediaStore.Images.Thumbnails.getThumbnail(contentResolver, id.toLong(), MediaStore.Images.Thumbnails.MINI_KIND, null)
            val stream = ByteArrayOutputStream()
            bmp.compress(Bitmap.CompressFormat.PNG, 100, stream)
            val data = stream.toByteArray()

            val created = getInt(createdIndex)
            val latitude = getDouble(latitudeIndex)
            val longitude = getDouble(longitudeIndex)

            completion(data, id, created, "$latitude, $longitude",imageWidth,imageHeight,filePath)
        }
    }

    private val columns = arrayOf(
            MediaStore.Images.Media.DATA,
            MediaStore.Images.Media._ID,
            MediaStore.Images.Media.DATE_ADDED,
            MediaStore.Images.Media.LATITUDE,
            MediaStore.Images.Media.LONGITUDE,)


    private fun getGalleryImageCount(): Int {
        val uri = MediaStore.Images.Media.EXTERNAL_CONTENT_URI

        val cursor = contentResolver.query(uri, columns, null, null, null);

        return cursor?.count ?: 0
    }

}
