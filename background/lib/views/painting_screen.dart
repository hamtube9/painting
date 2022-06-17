import 'dart:convert';
import 'dart:isolate';
import 'dart:math';
import 'dart:typed_data';

import 'package:background/blocs/edit/pain_provider.dart';
import 'package:background/blocs/edit/paint_bloc.dart';
import 'package:background/main.dart';
import 'package:background/model/draw/draw_controller.dart';
import 'package:background/model/item_widget/item_widget.dart';
import 'package:background/utils/controller/list_color.dart';
import 'package:background/utils/gesture_recognizer.dart';
import 'package:background/utils/last_image_as_background.dart';
import 'package:background/utils/sketcher.dart';
import 'package:background/utils/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaintingScreen extends StatefulWidget {
  final Uint8List image;
  static GlobalKey? globalKey = GlobalKey();

  const PaintingScreen({Key? key, required this.image}) : super(key: key);

  @override
  State<PaintingScreen> createState() => _PaintingViewState();
}

class _PaintingViewState extends State<PaintingScreen> {
  static Size kCanvasSize = Size.zero;
  double symmetryLines = 0;
  DrawController drawController = DrawController(
      isPanActive: true,
      penTool: PenTool.glowPen,
      points: [],
      currentColor: Colors.green,
      symmetryLines: 1);
  late bool ignorePointer;
  late int pointerCount;
  PaintBloc? bloc;
  List<Widget> widgets = [];
  GlobalKey keyPath = GlobalKey();

  @override
  initState() {
    bloc = PaintProvider.of(context);
    ignorePointer = false;
    pointerCount = 1;
    if (drawController.globalKey == null) {
      widgets = [_localImage(), _paint()];
      bloc!.InitGlobalKeyEvent(PaintingScreen.globalKey!);
      bloc!.InitImage(widget.image);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    drawController = PaintProvider.of(context)!.drawController!;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: Row(
              children: [
                IconButton(
                  onPressed: () => onBackPress(context),
                  icon: const Icon(
                    Icons.chevron_left,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                    onPressed: () {
                      bloc!.UndoStampsEvent();
                    },
                    icon: SvgPicture.asset(
                      "assets/svg/ic_turn_left.svg",
                      color: Colors.black,
                    ),
                    label: Container()),
                TextButton.icon(
                    onPressed: () {
                      bloc!.RedoStampsEvent();
                    },
                    icon: SvgPicture.asset(
                      "assets/svg/ic_turn_right.svg",
                      color: Colors.black,
                    ),
                    label: Container()),
                GestureDetector(
                  onTap: () {
                    if(item == null){
                      createView();
                    }else{
                      rebound();
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 8, 16, 8),
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 0.5), color: Colors.black),
                    alignment: Alignment.center,
                    child: Text(
                      "Save",
                      style: AppTextStyle.styleCaption1(
                          fontWeight: FontWeight.w600, textColor: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    bottom: 0,
                    left: 0,
                    child: _localImage(),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    bottom: 0,
                    left: 0,
                    child: _paint(),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    bottom: 0,
                    child: ValueListenableBuilder<List<Widget>>(
                      builder: (context, value, child) {
                        return Stack(
                          children: List.generate(value.length, (index) => value[index]),
                        );
                      },
                      valueListenable: bloc!.notifierWidget,
                    ),
                  ),
                  AnimatedPositioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    duration: const Duration(milliseconds: 500),
                    child: _colorPicker(),
                  )
                ],
              );
            },
          ))
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: Row(
          children: [
            Expanded(
                child: _itemEdit("assets/svg/edit1.svg", () async {
              bloc!.showColor();
            })),
            Expanded(child: _itemEdit("assets/svg/edit2.svg", () => _editText())),
            Expanded(child: _itemEdit("assets/svg/edit4.svg", () {})),
            Expanded(
                child: _itemEdit("assets/svg/edit5.svg", () {
              bloc!.showColor();
            })),
          ],
        ),
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

  _editText() {}

  _colorPicker() {
    return ValueListenableBuilder<bool>(
        valueListenable: bloc!.notifierShowColor,
        builder: (c, v, _) {
          return v
              ? Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8), topRight: Radius.circular(8))),
                  height: 72,
                  child: ListColorView(onChangeColor: (color) => _onChangeColor(color)),
                )
              : Container();
        });
  }

  _onChangeColor(Color color) {
    bloc!.ChangeCurrentColorEvent(color, false);
  }
  ItemWidget? item;

  createView() async {
    var itemW = await bloc!.getView(keyPath);
    setState(() {
      item = itemW;
    });

  }

  rebound() async {
    Uint8List? unint8list = await bloc!.reboundImage(keyPath, context);
    if(mounted){
      item!.uint8list = unint8list;
      Navigator.of(context).pop(item);
    }
  }

  Widget _localImage() {
    return ValueListenableBuilder<Uint8List?>(
      valueListenable: bloc!.notifierImage,
      builder: (BuildContext context, value, Widget? child) {
        return Center(
          child: Image.memory(value!),
        );
      },
    );
  }

  Widget _paint() {
    return ValueListenableBuilder<DrawController?>(
        valueListenable: bloc!.notifierDrawController,
        builder: (c, drawControll, _) {
          return InteractiveViewer(
            panEnabled: false,
            scaleEnabled: true,
            minScale: 0.1,
            maxScale: 5,
            boundaryMargin: const EdgeInsets.all(80),
            onInteractionEnd: (details) {
              // print(details.velocity);
              setState(() {
                ignorePointer = details.pointerCount > 1;
                pointerCount = 1;
                bloc!.AddPointEvent(
                    point: Point(
                        offset: null,
                        paint: Paint()
                          ..color = Color.fromRGBO(Random().nextInt(255), Random().nextInt(255),
                              Random().nextInt(255), 1)
                          ..strokeCap = StrokeCap.square
                          ..strokeJoin = StrokeJoin.bevel
                          ..strokeWidth = (Random().nextInt(10)) * 1.0),
                    end: false);
                // print(
                //     "onInteractionEnd = ignorePointer = $ignorePointer  fingers = ${details.pointerCount}");
              });
            },
            onInteractionUpdate: (details) {
              print(details.localFocalPoint);
              setState(() {
                ignorePointer = details.pointerCount > 1;
                pointerCount = details.pointerCount;
                // print(
                //     "onInteractionUpdate = ignorePointer = $ignorePointer  fingers = ${details.pointerCount}");
              });
              bloc!.addOffset(details.localFocalPoint);
            },
            onInteractionStart: (details) {
              print(details.localFocalPoint);
              setState(() {
                ignorePointer = details.pointerCount > 1;
                pointerCount = details.pointerCount;
                // print(
                //     "onInteractionStart = ignorePointer = $ignorePointer  fingers = ${details.pointerCount}");
              });
              bloc!.addOffset(details.localFocalPoint);
            },
            child: Container(
              color: Colors.transparent,
              child: IgnorePointer(
                ignoring: false,
                child: RawGestureDetector(
                  behavior: HitTestBehavior.opaque,
                  gestures: <Type, GestureRecognizerFactory>{
                    SingleGestureRecognizer:
                        GestureRecognizerFactoryWithHandlers<SingleGestureRecognizer>(
                            () => SingleGestureRecognizer(debugOwner: this), (instance) {
                      instance.onStart = (pointerEvent) {
                        if (ignorePointer == false && pointerCount == 1) {
                          if (drawControll != null && drawControll.isRandomColor) {
                            bloc!.ChangeCurrentColorEvent(
                              Color.fromRGBO(Random().nextInt(255), Random().nextInt(255),
                                  Random().nextInt(255), 1),
                              true,
                            );
                          }
                          // if (drawController!.penTool == PenTool.customPen) {
                          //   BlocProvider.of<DoddlerBloc>(context)
                          //       .add(AddRandomPoints([
                          //     List.generate(
                          //         10,
                          //         (index) => randomOffsets.add(Offset(
                          //             points[j]!.offset!.dx +
                          //                 Random().nextInt(a) * 1.0,
                          //             points[j]!.offset!.dy -
                          //                 Random().nextInt(a) * 1.0)))
                          //   ]));
                          // }
                        }
                      };
                      instance.onUpdate = (pointerEvent) {
                        if (ignorePointer == false && pointerCount == 1) {
                          // print(pointerEvent.pointer);
                          setState(() {
                            kCanvasSize = Size(
                                MediaQuery.of(context).size.width,
                                MediaQuery.of(context).size.height -
                                    (AppBar().preferredSize.height));
                            var pinSpaceX = 0;
                            var pinSpaceY = -50;

                            Offset point = pointerEvent.localPosition;

                            point = point.translate(-((kCanvasSize.width / 2) + pinSpaceX),
                                -((kCanvasSize.height / 2) + pinSpaceY));

                            // print("x = ${point.dx} , y = ${point.dy}");
                            bloc!.AddPointEvent(
                                point: Point(
                                    offset: point,
                                    paint: Paint()
                                      ..color = drawControll == null
                                          ? Colors.white
                                          : drawControll.currentColor
                                      ..strokeCap = StrokeCap.round
                                      ..strokeJoin = StrokeJoin.miter
                                      ..strokeWidth = (Random().nextInt(10)) * 1.0));
                          });
                        }
                      };
                      instance.onEnd = (pointerEvent) {
                        if (ignorePointer == false && pointerCount == 1) {
                          bloc!.AddPointEvent(
                              point: Point(
                                  offset: null,
                                  paint: Paint()
                                    ..color = Color.fromRGBO(Random().nextInt(255),
                                        Random().nextInt(255), Random().nextInt(255), 1)
                                    ..strokeCap = StrokeCap.square
                                    ..strokeJoin = StrokeJoin.bevel
                                    ..strokeWidth = (Random().nextInt(10)) * 1.0),
                              end: true);
                        }
                      };
                    }),
                  },
                  child: ClipRect(
                    child: CustomPaint(
                      foregroundPainter: Sketcher(
                        drawControll!.points ?? [],
                        kCanvasSize,
                        drawControll != null ? drawControll.symmetryLines! : 5,
                        drawControll != null ? drawControll.currentColor : Colors.red,
                        drawController.penTool!,
                      ),
                      painter: LastImageAsBackground(
                        image: drawControll == null
                            ? null
                            : drawControll.stamp!.isEmpty
                                ? null
                                : drawControll.stamp!.last!.image,
                      ),
                      size: Size(
                        kCanvasSize.width / 2,
                        kCanvasSize.height / 2,
                      ),
                      willChange: true,
                      isComplex: true,
                      child: const SizedBox.expand(),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
