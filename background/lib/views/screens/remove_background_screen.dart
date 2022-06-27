import 'dart:io';

import 'package:background/blocs/edit/edit_bloc.dart';
import 'package:background/blocs/edit/edit_provider.dart';
import 'package:background/model/local_image.dart';
import 'package:background/utils/controller/background.dart';
import 'package:background/utils/controller/button_primary.dart';
import 'package:background/utils/controller/text_gradient.dart';
import 'package:background/utils/navigation/navigation_page.dart';
import 'package:background/utils/styles/color_style.dart';
import 'package:background/views/screens/edit_image_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RemoveBackgroundScreen extends StatefulWidget {
  final LocalImage image;

  const RemoveBackgroundScreen({Key? key, required this.image}) : super(key: key);

  @override
  State<RemoveBackgroundScreen> createState() => _RemoveBackgroundState();
}

class _RemoveBackgroundState extends State<RemoveBackgroundScreen> {
  double x = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Background(child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _header(),
              Expanded(child: LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    children: [
                      Positioned(
                        top: 16,
                        right: 0,
                        bottom: 16,
                        left: 0,
                        child: Image.file(
                          File(widget.image.filePath!),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      Positioned(
                          top: 16,
                          left: 16,
                          bottom: 16,
                          child: Container(
                            width: x,
                            decoration: BoxDecoration(
                                color: AppColor.active.withOpacity(0.5),
                                border: const Border(
                                    right: BorderSide(color: AppColor.active, width: 2))),
                          )),
                      Positioned(
                        top: 0,
                        left: 8 + x - 8 < 8 ? 8 : x+8,
                        child: RawGestureDetector(
                          gestures: {
                            AllowMultipleHorizontalDragGestureRecognizer:
                            GestureRecognizerFactoryWithHandlers<
                                AllowMultipleHorizontalDragGestureRecognizer>(
                                  () => AllowMultipleHorizontalDragGestureRecognizer(),
                                  (AllowMultipleHorizontalDragGestureRecognizer instance) {
                                instance.onUpdate = (details) {
                                  x += details.delta.dx;
                                  if (x < 0.0) {
                                    x = 0.0;
                                  }
                                  if(x >= constraints.maxWidth){
                                    x = constraints.maxWidth;
                                  }
                                  setState(() {});
                                };
                              },
                            )
                          },
                          child: Container(
                            height: 16,
                            width: 16,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppColor.active)),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left:8+ x - 8 < 8 ? 8 : x+8,
                        child: RawGestureDetector(
                          gestures: {
                            AllowMultipleHorizontalDragGestureRecognizer:
                            GestureRecognizerFactoryWithHandlers<
                                AllowMultipleHorizontalDragGestureRecognizer>(
                                  () => AllowMultipleHorizontalDragGestureRecognizer(),
                                  (AllowMultipleHorizontalDragGestureRecognizer instance) {
                                instance.onUpdate = (details) {
                                  x += details.delta.dx;
                                  if (x < 0.0) {
                                    x = 0.0;
                                  }
                                  if(x >= constraints.maxWidth){
                                    x = constraints.maxWidth;
                                  }
                                  setState(() {});
                                };
                              },
                            )
                          },
                          child: Container(
                            height: 16,
                            width: 16,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppColor.active)),
                          ),
                        ),
                      )
                    ],
                  );
                },
              )),
              _slide()
            ],
          ),
        ),));
  }

  _header() {
    return SizedBox(
      height: 48,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.close,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {},
            child: SvgPicture.asset("assets/svg/icon_share.svg"),
          ),
          const SizedBox(
            width: 16,
          ),
          ButtonPrimary(text: "Next", onClick: () => _navigationEdit())
        ],
      ),
    );
  }

  _slide() {
    return SlideRemoveBackground(
      onWidthChange: (w) {},
    );
  }

  _navigationEdit() {
    Navigator.of(context).pushReplacement(
      CustomPageNavigationBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => EditProvider(
            bloc: EditBloc(),
            child: EditImageScreen(
              image:widget.image,
            ),
          )),
    );
  }
}

class SlideRemoveBackground extends StatefulWidget {
  final Function(double) onWidthChange;
  const SlideRemoveBackground({Key? key, required this.onWidthChange}) : super(key: key);

  @override
  State<SlideRemoveBackground> createState() => _SlideRemoveBackgroundState();
}

class _SlideRemoveBackgroundState extends State<SlideRemoveBackground> {
  double x = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: 60,
          padding: const EdgeInsets.all(4),
          decoration:
              BoxDecoration(color: AppColor.neutral5, borderRadius: BorderRadius.circular(12)),
          child: Stack(
            children: [
              const Positioned(
                top: 0,
                right: 0,
                left: 0,
                bottom: 0,
                child: Center(
                  child: GradientText(
                      text: "Slide to remove background", gradient: AppColor.gradient1),
                ),
              ),
              Positioned(
                  top: 0,
                  left: 0,
                  width: x,
                  height: 48,
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColor.neutral5, borderRadius: BorderRadius.circular(12)),
                  )),
              Positioned(
                top: 0,
                left: x,
                child: RawGestureDetector(
                  gestures: {
                    AllowMultipleHorizontalDragGestureRecognizer:
                        GestureRecognizerFactoryWithHandlers<
                            AllowMultipleHorizontalDragGestureRecognizer>(
                      () => AllowMultipleHorizontalDragGestureRecognizer(),
                      (AllowMultipleHorizontalDragGestureRecognizer instance) {
                        instance.onUpdate = (details) {
                          x += details.delta.dx;
                          if (x < 0.0) {
                            x = 0.0;
                          }
                          if(x >= constraints.maxWidth - 64){
                            x = constraints.maxWidth - 60;
                          }

                          widget.onWidthChange(x);
                          setState(() {});
                        };
                      },
                    )
                  },
                  child: Container(
                    height: 48,
                    width: 48,
                    decoration:
                        BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(12)),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      "assets/svg/icon_slide.svg",
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class AllowMultipleHorizontalDragGestureRecognizer extends HorizontalDragGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
  }
}
