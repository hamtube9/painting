import 'dart:ffi';

import 'package:background/utils/controller/circle_color.dart';
import 'package:background/views/dialog/dialog_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ListColorView extends StatefulWidget {
  final Function? choiceColor;
  final Function(Color) onChangeColor;
  const ListColorView({Key? key, required this.onChangeColor, this.choiceColor}) : super(key: key);

  @override
  State<ListColorView> createState() => _ListColorViewState();
}

class _ListColorViewState extends State<ListColorView> {
  Color? colorPicker;
  final colors = colorList;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            height: 56,
            width: 56,
            margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: GestureDetector(
                onTap: () async {
                  widget.choiceColor!();
                  Color? color =
                      await showDialog(context: context, builder: (context) => const DialogColor());
                  if(color != null){
                    setState(() {
                      colorPicker = color;
                    });
                    widget.onChangeColor(colorPicker!);
                  }
                },
                child: const MultiColorView()),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => _itemColor(
                    selectedColor: (color) {
                      setState(() {
                        colorPicker = color;
                      });
                      widget.onChangeColor(colorPicker!);
                    },
                    colorItem: colors[index],
                    isColorPicker: colorPicker != null && colorPicker == colors[index]),
                childCount: colors.length))
      ],
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
    );
  }
}

class _itemColor extends StatefulWidget {
  final bool isColorPicker;
  final Color colorItem;
  final Function selectedColor;

  const _itemColor(
      {Key? key, required this.isColorPicker, required this.colorItem, required this.selectedColor})
      : super(key: key);

  @override
  State<_itemColor> createState() => _itemColorState();
}

class _itemColorState extends State<_itemColor> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.selectedColor(widget.colorItem),
      child: Container(
        height: 56,
        width: 56,
        margin: const EdgeInsets.fromLTRB(0, 8, 8, 8),
        decoration: BoxDecoration(color: widget.colorItem, shape: BoxShape.circle),
        alignment: Alignment.center,
        child: widget.isColorPicker
            ? const Icon(
                Icons.check,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}
