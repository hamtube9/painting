import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:background/model/draw/draw_controller.dart';
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

  void InitImage(Uint8List image){
    notifierImage.value = image;
  }

  void showColor(){
    var value = notifierShowColor.value;
    notifierShowColor.value = !value;
  }

  void InitGlobalKeyEvent(GlobalKey globalKey){
    drawController = drawController?.copyWith(globalKey: globalKey);
    UpdateCanvasState(draw:  drawController);
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

  void UpdateSymmetryLines(double? symmetryLines){
    drawController =
        drawController?.copyWith(symmetryLines: symmetryLines);
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
}
