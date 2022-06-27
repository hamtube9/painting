import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

enum TypeItem { text, localImage, itemImage,paint }

class ItemWidget {
   TypeItem? type;
   String? image;
   Uint8List? uint8list;
   double? dx;
   double? dy;
   double? width;
   double? height;
   double? fontSize;
   Color? color;
   bool? isFocus;

  ItemWidget( {this.type, this.image, this.dx, this.dy, this.width, this.height,this.uint8list,this.fontSize,this.color,this.isFocus});

  ItemWidget.coppyWith({
    TypeItem? type,
    String? image,
    double? dx,
    double? dy,
    double? width,
    double? height,
    Uint8List? uint8list,
    double? fontSize,
    Color? color,
    bool? isFocus
  }) : this(width: width, height: height, image: image, type: type, dx: dx, dy: dy,uint8list: uint8list,color: color,fontSize: fontSize,isFocus: isFocus);
}
