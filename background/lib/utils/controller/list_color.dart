import 'package:background/utils/controller/circle_color.dart';
import 'package:flutter/material.dart';

class ListColorView extends StatefulWidget {
  const ListColorView({Key? key}) : super(key: key);

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
            child: const MultiColorView(),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => _itemColor(
                    selectedColor: (color) {
                      setState(() {
                        colorPicker = color;
                      });
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
      {Key? key,
      required this.isColorPicker,
      required this.colorItem,
      required this.selectedColor})
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
        decoration: BoxDecoration(color: widget.colorItem,shape: BoxShape.circle),
        alignment: Alignment.center,
        child: widget.isColorPicker ? const Icon(Icons.check,color: Colors.white,) : null,
      ),
    );
  }
}
