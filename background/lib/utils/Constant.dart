import 'package:flutter/services.dart';

class MyStrings {
  static const title = 'Photos Keyboard';
  static const channel = 'com.ngaoschos.photo';
  static const channelMethodPhoto = 'getPhotos';
  static const channelMethodFetchImage = 'fetchImage';
  static const channelMethodRequestPermission = 'request';
  static const fontFamily = "DMSans";
}

const methodChannel = MethodChannel(MyStrings.channel);
