import 'dart:io';
import 'dart:ui';

import 'package:background/blocs/edit/edit_bloc.dart';
import 'package:background/blocs/edit/edit_provider.dart';
import 'package:background/main.dart';
import 'package:background/model/item_widget/item_widget.dart';
import 'package:background/model/local_image.dart';
import 'package:background/services/pick_image_services.dart';
import 'package:background/utils/controller/list_color.dart';
import 'package:background/utils/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';

class EditImageScreen extends StatefulWidget {
  final LocalImage? image;
  bool isBlackFriday;

  EditImageScreen({Key? key, this.image, this.isBlackFriday = false}) : super(key: key);

  @override
  State<EditImageScreen> createState() => _EditImageScreenState();
}

class _EditImageScreenState extends State<EditImageScreen> {
  Matrix4? matrix = Matrix4.identity();

  // final keyImage = GlobalKey();
  // final keyResizeImage = GlobalKey();
  EditBloc? bloc;
  List<ItemWidget> listW = [];
  int indexSelected = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = EditProvider.of(context);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (listW.isEmpty) {
      var size = MediaQuery.of(context).size;
      double dx = widget.image!.width! < size.width
          ? (size.width - widget.image!.width!.toDouble()) / 2
          : 0;
      double dy = widget.image!.height! < size.height
          ? (size.height - widget.image!.height!.toDouble()) / 2
          : 0;
      // listW.add(

      // );
      listW.add(ItemWidget(
          type: TypeItem.localImage,
          image: widget.image!.filePath,
          dx: dx,
          dy: dy,
          width: size.width,
          height: size.height - 140));
      bloc!.init();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: SizedBox(
        height: 80,
        child: Row(
          children: [
            Expanded(
                child: _itemEdit("assets/svg/edit1.svg", () {
              bloc!.updateEditColor();
            })),
            Expanded(child: _itemEdit("assets/svg/edit2.svg", () => _editText())),
            Expanded(child: _itemEdit("assets/svg/edit3.svg", () => _openLocalImage())),
            Expanded(child: _itemEdit("assets/svg/edit4.svg", () {})),
            Expanded(child: _itemEdit("assets/svg/edit5.svg", () {})),
          ],
        ),
      ),
      body: Column(
        children: [
          ValueListenableBuilder<EditType?>(
            valueListenable: bloc!.notifierEditType,
            builder: (context, value, child) {
              return value != null
                  ? SizedBox(
                      height: 60,
                      child: Row(
                        children: [
                          value == EditType.normal
                              ? IconButton(
                                  onPressed: () => onBackPress(context),
                                  icon: const Icon(
                                    Icons.chevron_left,
                                    color: Colors.black,
                                  ),
                                )
                              : Container(),
                          const Spacer(),
                          value == EditType.color
                              ? TextButton.icon(
                                  onPressed: () {},
                                  icon: SvgPicture.asset(
                                    "assets/svg/ic_turn_left.svg",
                                    color: Colors.black,
                                  ),
                                  label: Container())
                              : Container(),
                          value == EditType.color
                              ? TextButton.icon(
                                  onPressed: () {},
                                  icon: SvgPicture.asset(
                                    "assets/svg/ic_turn_right.svg",
                                    color: Colors.black,
                                  ),
                                  label: Container())
                              : Container(),
                          value == EditType.normal
                              ? Container(
                                  margin: const EdgeInsets.fromLTRB(0, 8, 16, 8),
                                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white, width: 0.5),
                                      color: Colors.black),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "SHARE",
                                    style: AppTextStyle.styleCaption1(
                                        fontWeight: FontWeight.w600, textColor: Colors.white),
                                  ),
                                )
                              : TextButton.icon(
                                  onPressed: () async {
                                    if (value == EditType.pickImage) {}
                                  },
                                  icon: const Icon(
                                    Icons.check,
                                    color: Colors.black,
                                  ),
                                  label: Container())
                        ],
                      ),
                    )
                  : Container(
                      alignment: Alignment.centerLeft,
                      height: 60,
                      child: IconButton(
                        onPressed: () => onBackPress(context),
                        icon: const Icon(
                          Icons.chevron_left,
                          color: Colors.black,
                        ),
                      ),
                    );
            },
          ),
          Expanded(
              child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: RepaintBoundary(
                  // key: keyImage,
                  child: Stack(
                    children: [
                      Positioned(
                          top: 0,
                          right: 0,
                          bottom: 0,
                          left: 0,
                          child: Container(
                            color: const Color(0xffE1E9F3),
                            width: size.width,
                            height: widget.isBlackFriday ? size.height : size.width,
                            child: Stack(
                                children: List<Widget>.generate(
                                    listW.length, (index) => _itemStack(index)).toList()),
                          )

                          // ValueListenableBuilder<List<Widget>?>(builder: (context, value, child) {
                          //   return Stack(
                          //       children: List<Widget>.generate(value!.length, (index) => value[index]).toList());
                          // },valueListenable:bloc!.notifierWidget),
                          // ),
                          ),
                      Container(
                        margin: const EdgeInsets.all(16),
                        width: size.width,
                        height: widget.isBlackFriday ? size.height : size.width,
                        child: ValueListenableBuilder<EditType?>(
                          valueListenable: bloc!.notifierEditType,
                          builder: (c, v, _) {
                            if (v != null) {
                              return _content(v);
                            } else {
                              return Container(
                                color: Colors.transparent,
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
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
    var size = MediaQuery.of(context).size;
    if (image != null) {
      listW.add(ItemWidget(
          width: 200,
          height: 200,
          dy: (size.height / 2) - 100,
          dx: (size.width / 2) - 100,
          image: image.filePath,
          type: TypeItem.itemImage));
    }
    // bloc!.updateShowPickImage(context);
  }

  _colorPicker() {
    return ValueListenableBuilder<bool?>(
        valueListenable: bloc!.notifierShowColor,
        builder: (c, v, _) {
          return v != null && v
              ? Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8), topRight: Radius.circular(8))),
                  height: 72,
                  child: const ListColorView(),
                )
              : Container();
        });
  }

  _imagePicker(Size size) {
    return ValueListenableBuilder<bool?>(
        valueListenable: bloc!.notifierShowImage,
        builder: (c, v, _) {
          return Center(
            child: v != null && v
                ? MatrixGestureDetector(
                    onMatrixUpdate:
                        (matrix, translationDeltaMatrix, scaleDeltaMatrix, rotationDeltaMatrix) {
                      setState(() {
                        this.matrix = matrix;
                      });
                    },
                    child: Container(
                        width: size.width,
                        height: widget.isBlackFriday ? size.height : size.width,
                        alignment: Alignment.center,
                        child: Transform(
                            transform: matrix!,
                            child: ValueListenableBuilder<LocalImage?>(
                              valueListenable: bloc!.notifierImage,
                              builder: (c, image, _) {
                                return image != null
                                    ? Image.file(File(image.filePath!), fit: BoxFit.fitWidth)
                                    // RepaintBoundary(
                                    //         key: keyResizeImage,
                                    //         child:
                                    //             Image.file(File(image.filePath!), fit: BoxFit.fitWidth))
                                    : Container();
                              },
                            ))),
                  )
                : Container(),
          );
        });
  }

  _content(EditType v) {
    switch (v) {
      case EditType.normal:
        return const SizedBox(
          height: 0,
          width: 0,
        );
      case EditType.color:
        return Visibility(
            visible: false,
            child: Container(
              color: Colors.transparent,
            ));
      case EditType.pickImage:
        return _imagePicker(MediaQuery.of(context).size);
      case EditType.crop:
        return Visibility(
            visible: false,
            child: Container(
              color: Colors.transparent,
            ));
      case EditType.text:
        return GestureDetector(
          key: const Key("ges"),
          onTapDown: (TapDownDetails details) => _onTapDown(details),
          child: Container(
            color: Colors.transparent,
          ),
        );
      case EditType.beauty:
        return Container();
    }
  }

  _editText() {
    bloc!.updateShowAddText();
  }

  _onTapDown(TapDownDetails details) {
    var localPosition = details.localPosition;
    setState(() {
      // listW.add(

      //     )));
      listW.add(ItemWidget(
          type: TypeItem.text,
          image: null,
          dx: localPosition.dx,
          dy: localPosition.dy,
          height: 40,
          width: 60));
      print(listW);
    });
    bloc!.updateShowAddText();

    // EditProvider.of(context)!.updateListWidget(listW);
  }

  _itemStack(int index) {
    var item = listW[index];
    if (item.type == TypeItem.text) {
      return _ItemTextField(
        key: Key("$index"),
        index: index,
        onTap: (i) {
          setState(() {
            indexSelected = i;
          });
        },
        isSelected: indexSelected == index,
      );
      // return ResizebleWidget(
      //     onChangeAllSize: (h, w) {
      //       setState(() {
      //         item = ItemWidget.coppyWith(
      //             dy: item.dy,
      //             dx: item.dx,
      //             type: item.type,
      //             image: item.image,
      //             height: h,
      //             width: w);
      //         listW[index] = item;
      //       });
      //     },
      //     selected: indexSelected == index,
      //     key: Key("$index"),
      //     position: Offset(item.dx!, item.dy!),
      //     height: item.height!,
      //     width: item.width!,
      //     changePosition: (dx, dy) {
      //       setState(() {
      //         item = ItemWidget.coppyWith(
      //             dy: dy,
      //             dx: dx,
      //             type: item.type,
      //             image: item.image,
      //             height: item.height,
      //             width: item.width);
      //         listW[index] = item;
      //       });
      //     },
      //     index: index,
      //     selectIndex: (i) {
      //       setState(() {
      //         indexSelected = i;
      //       });
      //     },
      //     child: _ItemTextField(
      //       index: index,
      //       onTap: (i) {
      //         setState(() {
      //           indexSelected = i;
      //         });
      //       },
      //       isSelected: indexSelected == index,
      //     ));
    } else if (item.type == TypeItem.localImage) {
      return Positioned(
        key: Key("$index"),
        top: item.dy,
        left: item.dx,
        width: item.width,
        height: item.height,
        child: _ItemLocalImage(
            index: index,
            image: item.image!,
            onClick: (i) {
              setState(() {
                indexSelected = i;
              });
            }),
      );
    } else {
      return Positioned(
        key: Key("$index"),
        width: item.width,
        height: item.height,
        top: item.dy,
        left: item.dx,
        child: Image.file(
          File(
            item.image!,
          ),
          fit: BoxFit.cover,
        ),
      );
    }
  }
}

class _ItemTextField extends StatefulWidget {
  final int index;
  final bool isSelected;
  final Function(int) onTap;
  final double? height;
  final double? width;

  const _ItemTextField({
    Key? key,
    required this.isSelected,
    required this.onTap,
    required this.index,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  State<_ItemTextField> createState() => _ItemTextFieldState();
}

class _ItemTextFieldState extends State<_ItemTextField> {
  FocusNode _focusNode = FocusNode();
  TextEditingController _controller = TextEditingController();
  String text = "";
  int line = 1;
  Matrix4? matrix = Matrix4.identity();
  final GlobalKey key = GlobalKey();
  Size? _size;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (widget.isSelected) {
      _focusNode.requestFocus();
    } else {
      _focusNode.unfocus();
    }
  }

  @override
  void didUpdateWidget(covariant _ItemTextField oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected) {
      _focusNode.requestFocus();
    } else {
      _focusNode.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => widget.onTap(widget.index),
      child: SizedBox(
          height: size.height,
          width: size.width,
          child: Center(
            child: Transform(
              transform: matrix!,
              child: MatrixGestureDetector(
                onMatrixUpdate:
                    (matrix, translationDeltaMatrix, scaleDeltaMatrix, rotationDeltaMatrix) {
                      var s =  MatrixUtils
                          .transformRect(matrix, key.currentContext!
                          .findRenderObject()!
                          .paintBounds);
                  setState(() {
                    this.matrix = matrix;
                    _size = s.size;
                  });

                  // print(s.size);
                  print(s.size);
                },
                child: Container(
                  key: key,
                  decoration: BoxDecoration(
                    color: text.isEmpty ?  Colors.black.withOpacity(0.6) : Colors.transparent,
                  ),
                  height: line > 1 ? 30.0 * line : 40,
                  width: text.isEmpty
                      ? 60.0
                      : (text.length * 6 > size.width ? size.width : text.length * 6),
                  child:  widget.isSelected ?TextField(
                    keyboardType: TextInputType.multiline,
                    maxLength: null,
                    maxLines: line,
                    controller: _controller,
                    focusNode: _focusNode,
                    onChanged: (s) {
                      setState(() {
                        text = s;
                      });
                      if (text.length * 7 >= size.width/2) {
                        String t = "";
                        var list = text.split(' ').toList();
                        for (var i = 0; i < list.length; i++) {
                          if (i == list.length - 1) {
                            t += "\n${list[i]}";
                          } else {
                            t += '${list[i]} ';
                          }
                        }
                        setState(() {
                          line = t.length * 7 ~/ size.width <= 1
                              ? 1
                              : t.length * 7 ~/ size.width;
                        });
                      }
                    },
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:   BorderSide(color: Colors.transparent),
                      ), ),
                    style: const TextStyle(
                        fontFamily: 'SFProDisplay',
                        color: Colors.black
                    ),
                  ) : Text(
                    text,
                    style: const TextStyle(fontFamily: 'SFProDisplay'),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}

class _ItemLocalImage extends StatefulWidget {
  final String image;
  final Function(int) onClick;
  final int index;

  const _ItemLocalImage({Key? key, required this.image, required this.onClick, required this.index})
      : super(key: key);

  @override
  State<_ItemLocalImage> createState() => _ItemLocalImageState();
}

class _ItemLocalImageState extends State<_ItemLocalImage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onClick(widget.index),
      child: Center(
        child: Image.file(
          File(widget.image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
