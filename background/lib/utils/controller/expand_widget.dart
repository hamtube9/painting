import 'package:flutter/material.dart';

class ExpandableWidget extends StatefulWidget {
  final double height;
  final double maxHeight;
  final double dividerHeight;
  final double dividerSpace;
  final Widget child;
  final Function click;

  const ExpandableWidget({
    Key? key,
    required this.child,
    this.height = 80,
    required this.maxHeight ,
    this.dividerHeight = 6,
    this.dividerSpace = 2, required this.click,
  }) : super(key: key);

  @override
  _ExpandableWidgetState createState() => _ExpandableWidgetState();
}

class _ExpandableWidgetState extends State<ExpandableWidget> {
  late double _height, _maxHeight, _dividerHeight, _dividerSpace;

  @override
  void initState() {
    super.initState();
    _height = widget.height;
    _maxHeight = widget.maxHeight;
    _dividerHeight = widget.dividerHeight;
    _dividerSpace = widget.dividerSpace;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: _maxHeight,
      child:Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(child: GestureDetector(child: Container(color: Colors.transparent,),onTap: () => widget.click() ,)),
          SizedBox(height: _dividerSpace),
          Container(
            height: _dividerHeight,
            width: 60,
            child: GestureDetector(
              child: Container( decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(4)
              ),),
              onPanUpdate: (details) {
                setState(() {
                  _height -= details.delta.dy;

                  // prevent overflow if height is more/less than available space
                  var maxLimit = _maxHeight - _dividerHeight - _dividerSpace;
                  var minLimit = 44.0;

                  if (_height > maxLimit)
                    _height = maxLimit;
                  else if (_height < minLimit){
                    // _height = minLimit;
                    Navigator.pop(context);
                  }
                });
              },
            ),
          ),
          SizedBox(
            height: _height,
            child: Container(child:   widget.child,
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(8),topLeft: Radius.circular(8))
              ),
            ),
          ),
        ],
      ),
    );
  }

}