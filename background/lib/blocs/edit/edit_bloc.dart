import 'dart:io';
import 'dart:ui';

import 'package:background/model/local_image.dart';
import 'package:background/services/pick_image_services.dart';
import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';

enum EditType { normal, color, pickImage, crop, text, beauty }

class EditBloc extends ChangeNotifier {
  List<Widget> listW = [];
  ValueNotifier<bool?> notifierShowColor = ValueNotifier<bool?>(null);
  ValueNotifier<bool?> notifierShowImage = ValueNotifier<bool?>(null);
  ValueNotifier<bool?> notifierAddText = ValueNotifier<bool?>(null);
  ValueNotifier<bool?> notifierShowLogo = ValueNotifier<bool?>(null);
  ValueNotifier<LocalImage?> notifierImage = ValueNotifier<LocalImage?>(null);
  ValueNotifier<EditType?> notifierEditType = ValueNotifier<EditType?>(null);
  ValueNotifier<List<Widget>?> notifierWidget = ValueNotifier<List<Widget>?>(null);


  void init( ) {

    notifierAddText.value = false;
    notifierShowColor.value = false;
    notifierShowImage.value = false;
    notifierShowLogo.value = true;
    notifierEditType.value = EditType.normal;
  }

  void updateShowPickImage(context) {
    if (notifierShowLogo.value == true) {
      notifierShowLogo.value = false;
    }
    if (notifierShowImage.value == false) {
      notifierShowImage.value = true;
      notifierShowColor.value = false;
      notifierEditType.value = EditType.pickImage;
      openLocalImage(context);
    } else {
      toNormal();
    }
  }

  openLocalImage(context) async {
    notifierShowImage.value = true;
    var image = await PickImageService.pickImage(context);
    if (image != null) {
      notifierImage.value = image;
    } else {
      toNormal();
    }
  }

  void toNormal() {
    notifierShowColor.value = false;
    notifierShowImage.value = false;
    notifierAddText.value = false;
    notifierEditType.value = EditType.normal;
  }

  void updateEditColor() {
    if (notifierShowImage.value == false) {
      notifierShowImage.value = true;
      notifierShowColor.value = false;
      notifierAddText.value = false;
      notifierEditType.value = EditType.color;
    } else {
      toNormal();
    }
  }

  void updateShowAddText() {
    if (notifierAddText.value == false) {
      notifierAddText.value = true;
      notifierShowImage.value = false;
      notifierShowColor.value = false;
      notifierEditType.value = EditType.text;
    } else {
      toNormal();
    }
  }

  void updateListWidget(List<Widget> list) {
    listW.addAll(list.toList());
    notifierWidget.value!.addAll(list.toList());
    notifyListeners();
  }
}
