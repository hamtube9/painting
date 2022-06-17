import 'dart:isolate';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:background/main.dart';
import 'package:background/model/draw/draw_controller.dart';
import 'package:background/model/item_widget/item_widget.dart';
import 'package:background/model/local_image.dart';
import 'package:background/model/position/pos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PaintBloc extends ChangeNotifier {
  var index = 0;
  DrawController? drawController = DrawController(
      isPanActive: true,
      penTool: PenTool.glowPen,
      points: [],
      currentColor: Colors.green,
      symmetryLines: 1);

  ValueNotifier<DrawController?> notifierDrawController = ValueNotifier<DrawController?>(null);
  ValueNotifier<Uint8List?> notifierImage = ValueNotifier<Uint8List?>(null);
  ValueNotifier<bool> notifierShowColor = ValueNotifier<bool>(false);
  ValueNotifier<List<Offset>> notifierOffset = ValueNotifier<List<Offset>>([]);
  ValueNotifier<List<Widget>> notifierWidget = ValueNotifier<List<Widget>>([]);

  initListWidget(List<Widget> w) {
    notifierWidget.value = w;
  }

  void InitImage(Uint8List image) {
    notifierImage.value = image;
  }

  void showColor() {
    var value = notifierShowColor.value;
    notifierShowColor.value = !value;
  }

  void addOffset(Offset offset) {
    var list = notifierOffset.value;
    list.add(offset);
    notifierOffset.value = List.from(list);
  }

  void InitGlobalKeyEvent(GlobalKey globalKey) {
    drawController = drawController?.copyWith(globalKey: globalKey);
    UpdateCanvasState(draw: drawController);
  }

  void ClearPointEvent() {
    drawController!.points!.clear();
    UpdateCanvasState(draw: drawController);
  }

  UpdateCanvasState({DrawController? draw}) {
    notifierDrawController.value = draw;
  }

  void ClearStampsEvent() {
    drawController!.stamp!.clear();
    UpdateCanvasState(draw: drawController);
  }

  void AddPointEvent({Point? point, bool end = false}) {
    drawController!.points!.add(point);
    if (end) {
      TakePageStampEvent(drawController!.globalKey!);
      // add(AddASceneEvent());
    }
    UpdateCanvasState(draw: drawController);
  }

  void TakePageStampEvent(GlobalKey key) async {
    try {
      ui.Image image = await canvasToImage(key);
      List<Stamp?>? stamps = List.from(drawController!.stamp!);
      stamps.add(Stamp(image: image));
      drawController = drawController!.copyWith(stamp: stamps);

      ClearPointEvent();
    } catch (e) {}

    UpdateCanvasState(draw: drawController);
  }

  void UpdateSymmetryLines(double? symmetryLines) {
    drawController = drawController?.copyWith(symmetryLines: symmetryLines);
    UpdateCanvasState(draw: drawController);
  }

  Future<ui.Image> canvasToImage(GlobalKey globalKey) async {
    final boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    final image = await boundary.toImage();
    return image;
  }

  void UndoStampsEvent() {
    if (drawController!.stamp!.isNotEmpty) {
      List<Stamp?>? stamps = List.from(drawController!.stamp!);
      final undoS = stamps.removeLast();

      List<Stamp?>? undoStamps = List.from(drawController!.stampUndo!);
      undoStamps.add(undoS);
      drawController = drawController!.copyWith(stamp: stamps, stampUndo: undoStamps);

      UpdateCanvasState(draw: drawController);
    }
  }

  void RedoStampsEvent() {
    if (drawController!.stampUndo!.isNotEmpty) {
      List<Stamp?>? stampUndo = List.from(drawController!.stampUndo!);
      final toRedo = stampUndo.removeLast();

      List<Stamp?>? stamps = List.from(drawController!.stamp!);
      stamps.add(toRedo);

      drawController = drawController!.copyWith(
        stamp: stamps,
        stampUndo: stampUndo,
      );

      UpdateCanvasState(draw: drawController);
    }
  }

  void ChangeCurrentColorEvent(Color? color, bool isRandomColor) {
    drawController = drawController?.copyWith(
      currentColor: color,
      isRandomColor: isRandomColor,
    );
    UpdateCanvasState(draw: drawController);
  }

  void ChangePenToolEvent(PenTool? penTool) {
    drawController = drawController?.copyWith(penTool: penTool);
    UpdateCanvasState(draw: drawController);
  }

  Future<Uint8List> reboundImage(GlobalKey globalKey, context) async {
    final boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    showLoading(context);
    final image = await boundary.toImage(pixelRatio: 10);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    hideLoading();
    final pngBytes = byteData!.buffer.asUint8List();
    return pngBytes;
  }

  Future<ItemWidget> getView(GlobalKey key) async {
    ReceivePort port = ReceivePort();
    List<Offset> offsets = List.from(notifierOffset.value);

    var isolate = await Isolate.spawn<List<dynamic>>(parseOffset, [port.sendPort, offsets]);
    Pos? data = await port.first;
    if (data != null) {
      print("${data.width} ${data.height} ${data.dx} ${data.dy}");
      isolate.kill(priority: Isolate.immediate);
      var listW = List.from(notifierWidget.value);
      listW.add(Positioned(
        top: data.dy,
        left: data.dx,
        child: RepaintBoundary(
          key:key,
          child: Container(
            color: Colors.transparent,
            width: data.width,
            height: data.height,
          ),
        ),
      ));
      notifierWidget.value = List.from(listW);
    }
    ItemWidget item = ItemWidget(
        width: data!.width,
        height: data.height,
        dx: data.dx,
        dy: data.dy,
        type: TypeItem.paint, );
    return item;
  }

  static void parseOffset(List<dynamic> data) {
    var sendPort = data[0];
    if ((data[1] as List<Offset>?) != null && (data[1] as List<Offset>?)!.isNotEmpty) {
      var listDx = data[1] as List<Offset>;
      var listDy = data[1] as List<Offset>;
      listDx.sort((a, b) => a.dx.compareTo(b.dx));
      var firstX = listDx.first;
      var lastX = listDx.last;
      var width = (lastX.dx + 20) - firstX.dx;
      var dx = (firstX.dx - 5);
      listDy.sort((a, b) => a.dy.compareTo(b.dy));
      var firstY = listDy.first;
      var lastY = listDy.last;
      var height = (lastY.dy + 50) - firstY.dy;
      var dy = firstY.dy - 50;
      Pos pos = Pos(dy: dy, dx: dx, height: height, width: width);
      sendPort.send(pos);
    }
  }
}
