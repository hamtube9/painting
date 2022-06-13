import 'package:background/model/local_image.dart';
import 'package:background/utils/Constant.dart';
import 'package:background/views/dialog/dialog_image.dart';
import 'package:flutter/material.dart';

class PickImageService {
  static Future<LocalImage?> pickImage(context) async {
    final results = await methodChannel.invokeMethod<int>('getPhotos', 1000);
    if (results != null) {
      // print("$results data");

      LocalImage image = await showDialog(
        context: context,
        builder: (c) => ImageScreen(totalImage: results),
      );
      return image;
    }
    return null;
  }
}
