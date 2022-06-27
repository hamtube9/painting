import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemesUtils {
  static void configStatusbar() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent));
  }
}
