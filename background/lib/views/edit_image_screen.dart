import 'dart:io';
import 'dart:ui';

import 'package:background/main.dart';
import 'package:background/model/local_image.dart';
import 'package:background/services/pick_image_services.dart';
import 'package:background/utils/controller/resize_widget.dart';
import 'package:background/utils/styles/color_style.dart';
import 'package:background/utils/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';

class EditImageScreen extends StatefulWidget {
  final LocalImage? image;

  const EditImageScreen({Key? key, this.image}) : super(key: key);

  @override
  State<EditImageScreen> createState() => _EditImageScreenState();
}

class _EditImageScreenState extends State<EditImageScreen> {
  LocalImage? image;
  Matrix4? matrix = Matrix4.identity();
  final keyImage = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.image != null){
      setState(() {
        image = widget.image;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => onBackPress(context),
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
        ),
        actions: [
          TextButton.icon(
              onPressed: () {},
              icon: SvgPicture.asset(
                "assets/svg/ic_turn_left.svg",
                color: Colors.black,
              ),
              label: Container()),
          TextButton.icon(
              onPressed: () {},
              icon: SvgPicture.asset(
                "assets/svg/ic_turn_right.svg",
                color: Colors.black,
              ),
              label: Container()),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 8, 16, 8),
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 0.5), color: Colors.black),
            alignment: Alignment.center,
            child: Text(
              "SHARE",
              style:
                  AppTextStyle.styleCaption1(fontWeight: FontWeight.w600, textColor: Colors.white),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 80,
        child: Row(
          children: [
            Expanded(child: _itemEdit("assets/svg/edit1.svg", () {})),
            Expanded(child: _itemEdit("assets/svg/edit2.svg", () {})),
            Expanded(child: _itemEdit("assets/svg/edit3.svg", () => _openLocalImage())),
            Expanded(child: _itemEdit("assets/svg/edit4.svg", () {})),
            Expanded(
                child: _itemEdit("assets/svg/edit5.svg", () {
              reboundImage();
            })),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              left: 0,
              child: Center(
                child: image != null
                    ? MatrixGestureDetector(
                        onMatrixUpdate: (matrix, translationDeltaMatrix, scaleDeltaMatrix,
                            rotationDeltaMatrix) {
                          setState(() {
                            this.matrix = matrix;
                          });
                        },
                        child: RepaintBoundary(
                          key: keyImage,
                          child: Container(
                              color: const Color(0xffE1E9F3),
                              margin: const EdgeInsets.all(16),
                              width: size.width,
                              height: size.width,
                              alignment: Alignment.center,
                              child: Transform(
                                  transform: matrix!,
                                  child: Image.file(File(image!.filePath!), fit: BoxFit.fitWidth))),
                        ),
                      )
                    : Container(
                        color: const Color(0xffE1E9F3),
                        margin: const EdgeInsets.all(16),
                        width: size.width,
                        height: size.width,
                      ),
              ))
        ],
      ),
    );
  }

  _itemEdit(String img, Function itemClick) {
    return Center(
      child: InkWell(
        onTap: () => itemClick(),
        child: Container(
          height: 48,
          width: 48,
          decoration: const BoxDecoration(color: Colors.black),
          alignment: Alignment.center,
          child: SvgPicture.asset(img),
        ),
      ),
    );
  }

  _openLocalImage() async {
    var image = await PickImageService.pickImage(context);
    setState(() {
      this.image = image;
    });
  }

  reboundImage() {
    RenderRepaintBoundary boundary =
        keyImage.currentContext?.findRenderObject() as RenderRepaintBoundary;
    transformToImage(boundary);
  }

  void transformToImage(RenderRepaintBoundary boundary) async {
    final position = boundary.localToGlobal(Offset.zero);
    final size = boundary.size;
    final image = await boundary.toImage(pixelRatio: 10.0);
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
    var a = LocalImage(
      bytes: byteData!.buffer.asUint8List(),
      height: size.height.toInt(),
      width: size.width.toInt(),
    );
  }
}
