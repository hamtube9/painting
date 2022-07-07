import 'package:flutter/material.dart';

class ResizebleWidget extends StatefulWidget {

  ResizebleWidget({Key? key, this.child, required this.position, this.height = 0, this.width = 0, this.onChangeAllSize, this.onChangeHeightSize, this
      .onChangeWidthSize, this
      .changePosition}) : super
      (key: key);
  Offset position;
  final Function(double, double)? onChangeAllSize;
  final Function(double)? onChangeHeightSize;
  final Function(double)? onChangeWidthSize;
  final Function(double, double)? changePosition;
  double height;

  double width;

  final Widget? child;

  @override
  _ResizebleWidgetState createState() => _ResizebleWidgetState();
}

const ballDiameter = 10.0;

class _ResizebleWidgetState extends State<ResizebleWidget> {
  bool isCorner = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: widget.position.dy,
          left: widget.position.dx,
          child: Container(
              height: widget.height,
              width: widget.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0.0),
              ),
              // need tp check if draggable is done from corner or sides
              child:FittedBox(
                child: widget.child,
              )
          ),
        ),
        // top left
        Positioned(
          top: widget.position.dy - ballDiameter / 2,
          left: widget.position.dx - ballDiameter / 2,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              var mid = (dx + dy) / 2;
              var newHeight = widget.height - 2 * mid;
              var newWidth = widget.width - 2 * mid;

              setState(() {
                isCorner = true;
                widget.height = newHeight > 0 ? newHeight : 0;
                widget.width = newWidth > 0 ? newWidth : 0;
                var top = widget.position.dy + mid;
                var left = widget.position.dx + mid;
                widget.position = Offset(left, top);
              });
              widget.onChangeAllSize!(newHeight > 0 ? newHeight : 0, newWidth > 0 ? newWidth : 0);
            },
            handlerWidget: HandlerWidget.VERTICAL,
          ),
        ),
        // top right
        Positioned(
          top: widget.position.dy - ballDiameter / 2,
          left: widget.position.dx + widget.width - ballDiameter / 2,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              var mid = (dx + (dy * -1)) / 2;

              var newHeight = widget.height + 2 * mid;
              var newWidth = widget.width + 2 * mid;

              setState(() {
                isCorner = true;
                widget.height = newHeight > 0 ? newHeight : 0;
                widget.width = newWidth > 0 ? newWidth : 0;
                var top = widget.position.dy - mid;
                var left = widget.position.dy - mid;
                widget.position = Offset(left, top);
              });
              widget.onChangeAllSize!(newHeight > 0 ? newHeight : 0, newWidth > 0 ? newWidth : 0);
            },
            handlerWidget: HandlerWidget.VERTICAL,
          ),
        ),

        // bottom right
        Positioned(
          top: widget.position.dy + widget.height - ballDiameter / 2,
          left: widget.position.dx + widget.width - ballDiameter / 2,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              var mid = (dx + dy) / 2;

              var newHeight = widget.height + 2 * mid;
              var newWidth = widget.width + 2 * mid;

              setState(() {
                isCorner = true;

                widget.height = newHeight > 0 ? newHeight : 0;
                widget.width = newWidth > 0 ? newWidth : 0;
                var top = widget.position.dy - mid;
                var left = widget.position.dx - mid;
                widget.position = Offset(left, top);
              });
              widget.onChangeAllSize!(newHeight > 0 ? newHeight : 0, newWidth > 0 ? newWidth : 0);
            },
            handlerWidget: HandlerWidget.VERTICAL,
          ),
        ),
        // bottom left
        Positioned(
          top: widget.position.dy + widget.height - ballDiameter / 2,
          left: widget.position.dx - ballDiameter / 2,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              var mid = ((dx * -1) + dy) / 2;

              var newHeight = widget.height + 2 * mid;
              var newWidth = widget.width + 2 * mid;

              setState(() {
                isCorner = true;

                widget.height = newHeight > 0 ? newHeight : 0;
                widget.width = newWidth > 0 ? newWidth : 0;
                var top = widget.position.dy - mid;
                var left = widget.position.dx - mid;
                widget.position = Offset(left, top);
              });
              widget.onChangeAllSize!(newHeight > 0 ? newHeight : 0, newWidth > 0 ? newWidth : 0);
            },
            handlerWidget: HandlerWidget.VERTICAL,
          ),
        ),

        // center center
        Positioned(
          top: widget.position.dy + widget.height / 2 - ballDiameter / 2,
          left: widget.position.dx + widget.width / 2 - ballDiameter / 2,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              setState(() {
                isCorner = false;

                var top = widget.position.dy + dy;
                var left = widget.position.dx + dx;
                widget.position = Offset(left, top);
                widget.changePosition!(left, top);
              });
            },
            handlerWidget: HandlerWidget.VERTICAL,
          ),
        ),
      ],
    );
  }
}

class ManipulatingBall extends StatefulWidget {
  ManipulatingBall({Key? key, this.onDrag, this.handlerWidget});

  final Function? onDrag;
  final HandlerWidget? handlerWidget;

  @override
  _ManipulatingBallState createState() => _ManipulatingBallState();
}

enum HandlerWidget { HORIZONTAL, VERTICAL }

class _ManipulatingBallState extends State<ManipulatingBall> {
  late double initX;
  late double initY;

  _handleDrag(details) {
    setState(() {
      initX = details.globalPosition.dx;
      initY = details.globalPosition.dy;
    });
  }

  _handleUpdate(details) {
    var dx = details.globalPosition.dx - initX;
    var dy = details.globalPosition.dy - initY;
    initX = details.globalPosition.dx;
    initY = details.globalPosition.dy;
    widget.onDrag!(dx, dy);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _handleDrag,
      onPanUpdate: _handleUpdate,
      child: Container(
        width: ballDiameter,
        height: ballDiameter,
        decoration: BoxDecoration(
          color: Colors.red,
          shape: widget.handlerWidget == HandlerWidget.VERTICAL
              ? BoxShape.circle
              : BoxShape.rectangle,
        ),
      ),
    );
  }
}