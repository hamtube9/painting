import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    private var flutterResult: FlutterResult? = nil
    private var fetchLimit: Int = 0
    private var fetchResult: PHFetchResult<PHAsset>? = nil


  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
        guard let controller = window?.rootViewController as? FlutterViewController else {
             fatalError("rootViewController is not type FlutterViewController")
           }
        let methodChannel =
            FlutterMethodChannel(name: "com.ngaoschos.photo", binaryMessenger: controller.binaryMessenger)
        methodChannel
            .setMethodCallHandler({ [weak self](call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            switch call.method {
            case "getPhotos":
                self?.fetchLimit = call.arguments as! Int
                self?.flutterResult = result
                 PHPhotoLibrary.requestAuthorization { (status) in
                            if (status == .authorized) {
                               result(self.getGalleryImageCount())

                            } else {
                                let error =
                                    FlutterError
                                    .init(code: "0", message: "Not authorized", details: status)
                                self.flutterResult?(error)
                            }
                        }
            case "fetchImage":
                   let index = call.arguments as? Int ?? 0
                     self.dataForGalleryItem(index: index, completion: { (data, id, created, location) in
                         result([
                             "data": data ?? Data(),
                             "id": id,
                             "created": created,
                             "location": location
                         ])
                     })
             default: result(FlutterError(code: "0", message: nil, details: nil))
            }
        })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }



  func getGalleryImageCount() -> Int {
      let fetchOptions = PHFetchOptions()
      fetchOptions.includeHiddenAssets = true

      let collection: PHFetchResult = PHAsset.fetchAssets(with: fetchOptions)
      return collection.count
    }

 func dataForGalleryItem(index: Int, completion: @escaping (Data?, String, Int, String) -> Void) {
    let fetchOptions = PHFetchOptions()

    let collection: PHFetchResult = PHAsset.fetchAssets(with: fetchOptions)
    if (index >= collection.count) {
      return
    }

    let asset = collection.object(at: index)

    let options = PHImageRequestOptions()
    options.deliveryMode = .fastFormat
    options.isSynchronous = true

    let imageSize = CGSize(width: 250,
                           height: 250)

    let imageManager = PHCachingImageManager()
    imageManager.requestImage(for: asset, targetSize: imageSize, contentMode: .aspectFit, options: options) { (image, info) in
      if let image = image {
        let data = UIImageJPEGRepresentation(image, 0.9)
        completion(data,
                   asset.localIdentifier,
                   Int(asset.creationDate?.timeIntervalSince1970 ?? 0),
                   "\(asset.location ?? CLLocation())")
      } else {
        completion(nil, "", 0, "")
      }
    }
  }


}
