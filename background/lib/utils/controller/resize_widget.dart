import 'package:flutter/material.dart';

class ResizebleWidget extends StatefulWidget {
  ResizebleWidget(
      {Key? key,
      this.child,
      required this.position,
      this.height = 0,
      this.width = 0,
      this.changePosition,
      required this.index,
      required this.selectIndex,
      required this.selected, this.onChangeAllSize})
      : super(key: key);
  Offset position;
  final Function(double, double)? changePosition;
  final Function(double, double)? onChangeAllSize;
  final int index;
  final Function(int) selectIndex;
  final bool selected;
  double height;

  double width;

  final Widget? child;

  @override
  _ResizebleWidgetState createState() => _ResizebleWidgetState();
}

const ballDiameter = 10.0;

class _ResizebleWidgetState extends State<ResizebleWidget> {
  double finalAngle = 0.0;
  double oldAngle = 0.0;
  double upsetAngle = 0.0;

  Offset centerOfGestureDetector = Offset(5, 5);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: widget.position.dy,
          left: widget.position.dx,
          child: Transform.rotate(
            angle: finalAngle,
            child: Container(
                height: widget.height,
                width: widget.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0.0),
                ),
                // need tp check if draggable is done from corner or sides
                child: Stack(
                  children: [
                    widget.child!,
                    Positioned(
                        top:0,
                        left: 0,
                        bottom: 0,
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onPanStart: (details) {
                            final touchPositionFromCenter = details.localPosition - centerOfGestureDetector;
                            upsetAngle = oldAngle - touchPositionFromCenter.direction;
                          },
                          onPanEnd: (details) {
                            setState(
                                  () {
                                oldAngle = finalAngle;
                              },
                            );
                          },
                          onPanUpdate: (details) {
                            final touchPositionFromCenter = details.localPosition - centerOfGestureDetector;

                            setState(
                                  () {
                                finalAngle = touchPositionFromCenter.direction + upsetAngle;
                              },
                            );
                          },
                          child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {

                            return Container(
                              width:constraints.maxHeight * 0.25,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(ballDiameter),
                                border: Border.all(
                                  width: 2,
                                  color: Colors.transparent,
                                ),
                              ),
                            );
                          },),
                        )),
                    Positioned(
                        top:0,
                        right: 0,
                        bottom: 0,
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onPanStart: (details) {
                            final touchPositionFromCenter = details.localPosition - centerOfGestureDetector;
                            upsetAngle = oldAngle - touchPositionFromCenter.direction;
                          },
                          onPanEnd: (details) {
                            setState(
                                  () {
                                oldAngle = finalAngle;
                              },
                            );
                          },
                          onPanUpdate: (details) {
                            final touchPositionFromCenter = details.localPosition - centerOfGestureDetector;

                            setState(
                                  () {
                                finalAngle = touchPositionFromCenter.direction + upsetAngle;
                              },
                            );
                          },
                          child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {

                            return Container(
                              width:constraints.maxHeight * 0.25,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(ballDiameter),
                                border: Border.all(
                                  width: 2,
                                  color: Colors.transparent,
                                ),
                              ),
                            );
                          },),
                        )),
                  ],
                )),
          ),
        ),
        Positioned(
          top: widget.position.dy + widget.height / 2 - ballDiameter / 2,
          left: widget.position.dx + widget.width / 2 - ballDiameter / 2,
          child: widget.selected == false
              ? GestureDetector(
                  onTap: () => widget.selectIndex(widget.index),
                  child: ManipulatingBall(
                    width: widget.width,
                    height: widget.height,
                    onDrag: (dx, dy) {
                      setState(() {
                        var top = widget.position.dy + dy;
                        var left = widget.position.dx + dx;
                        widget.position = Offset(left, top);
                        widget.changePosition!(left, top);
                      });
                    },
                    handlerWidget: HandlerWidget.VERTICAL,
                  ),
                )
              : Container(),
        ),

      ],
    );
  }
}

class ManipulatingBall extends StatefulWidget {
  ManipulatingBall(
      {Key? key, this.onDrag, this.handlerWidget, required this.width, required this.height});

  final double width;
  final double height;
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
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
      ),
    );
  }
}
