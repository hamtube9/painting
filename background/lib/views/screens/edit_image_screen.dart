import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:background/blocs/edit/edit_bloc.dart';
import 'package:background/blocs/edit/edit_provider.dart';
import 'package:background/blocs/edit/pain_provider.dart';
import 'package:background/blocs/edit/paint_bloc.dart';
import 'package:background/main.dart';
import 'package:background/model/item_widget/item_widget.dart';
import 'package:background/model/local_image.dart';
import 'package:background/services/pick_image_services.dart';
import 'package:background/utils/controller/background.dart';
import 'package:background/utils/controller/list_color.dart';
import 'package:background/utils/controller/matrix.dart';
import 'package:background/utils/navigation/navigation_page.dart';
import 'package:background/utils/styles/color_style.dart';
import 'package:background/utils/styles/text_style.dart';
import 'package:background/views/painting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_utils/keyboard_listener.dart' as kb;
import 'package:keyboard_utils/keyboard_utils.dart';

class EditImageScreen extends StatefulWidget {
  final LocalImage? image;
  bool isBlackFriday;

  EditImageScreen({Key? key, this.image, this.isBlackFriday = false}) : super(key: key);

  @override
  State<EditImageScreen> createState() => _EditImageScreenState();
}

class _EditImageScreenState extends State<EditImageScreen> {
  Matrix4? matrix = Matrix4.identity();

  final keyImage = GlobalKey();

  // final keyResizeImage = GlobalKey();
  EditBloc? bloc;
  List<ItemWidget> listW = [];
  List<List<ItemWidget>> stamps = [];
  int indexSelected = 0;
  int? indexStamp;
  bool isKeyboardOpen = false;
  double heightKeyboard = 0;
  final KeyboardUtils _keyboardUtils = KeyboardUtils();
  int? keyboardId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = EditProvider.of(context);
    listW = [];
    stamps = [];
    keyboardId = _keyboardUtils.add(
        listener: kb.KeyboardListener(willHideKeyboard: () {
      if (mounted) {
        setState(() {
          heightKeyboard = 0;
          isKeyboardOpen = false;
        });
      }
    }, willShowKeyboard: (d) {
      if (mounted) {
        setState(() {
          heightKeyboard = d;
          isKeyboardOpen = true;
        });
      }
    }));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _keyboardUtils.unsubscribeListener(subscribingId: keyboardId);
    if (_keyboardUtils.canCallDispose()) {
      _keyboardUtils.dispose();
    }
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

      setState(() {
        listW.add(ItemWidget(
            type: TypeItem.localImage,
            image: widget.image!.filePath,
            dx: dx,
            dy: dy,
            width: size.width,
            height: size.height - 140));
        updateStamps(List.from(List.from(listW)));
      });

      bloc!.init();
    }
  }

  updateStamps(List<ItemWidget> l) {
    if (indexStamp != null && indexStamp! < stamps.length - 1) {
      setState(() {
        stamps.removeRange(indexStamp!, stamps.length);
      });
    }
    setState(() {
      stamps.add(l);
      indexStamp = stamps.length - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: SizedBox(
        height: 80,
        child: Row(
          children: [
            Expanded(child: _itemEdit("assets/svg/edit1.svg", () => addPaint())),
            Expanded(child: _itemEdit("assets/svg/edit2.svg", () => _editText())),
            Expanded(child: _itemEdit("assets/svg/edit3.svg", () => _openLocalImage())),
            Expanded(child: _itemEdit("assets/svg/edit4.svg", () {})),
            Expanded(child: _itemEdit("assets/svg/edit5.svg", () {})),
          ],
        ),
      ),
      body: Background(
        child: Column(
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
                            TextButton.icon(
                                onPressed: () {
                                  if (indexStamp! <= 0) {
                                    return;
                                  }
                                  if (indexStamp == null) {
                                    indexStamp = stamps.length - 1;
                                  } else {
                                    indexStamp = indexStamp! - 1;
                                  }
                                  setState(() {
                                    listW.clear();
                                    listW = List.from(stamps[indexStamp!]);
                                  });
                                },
                                icon: SvgPicture.asset(
                                  "assets/svg/ic_turn_left.svg",
                                  color: Colors.black,
                                ),
                                label: Container()),
                            TextButton.icon(
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                  "assets/svg/ic_turn_right.svg",
                                  color: Colors.black,
                                ),
                                label: Container()),
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
            Expanded(child: LayoutBuilder(
              builder: (context, constraints) {
                final size = constraints.biggest;
                return Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: RepaintBoundary(
                        key: keyImage,
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
                                  height: size.height,
                                  child: Stack(
                                      children: List<Widget>.generate(
                                              listW.length, (index) => _itemStack(index, size))
                                          .toList()),
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
                              height: size.height,
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
                        duration: const Duration(milliseconds: 1000),
                        child: isKeyboardOpen
                            ? _TabbarTextView(
                                changeColor: (color) {
                                  setState(() {
                                    listW[indexSelected].color = color;
                                    listW[indexSelected].isFocus = false;
                                  });
                                  updateStamps(List.from(listW));
                                },
                                changeFontSize: (size) {
                                  setState(() {
                                    listW[indexSelected].fontSize = size;
                                    listW[indexSelected].isFocus = false;
                                  });
                                  updateStamps(List.from(listW));
                                },
                                choiceColor: () {
                                  setState(() {
                                    listW[indexSelected].isFocus = true;
                                  });
                                  updateStamps(List.from(listW));
                                },
                              )
                            : Container()),
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

    if (image != null) {
      setState(() {
        listW.add(ItemWidget(
            width: 200,
            height: 200,
            dy: (MediaQuery.of(context).size.height / 2) - 150,
            dx: (MediaQuery.of(context).size.width / 2) - 50,
            image: image.filePath,
            type: TypeItem.itemImage));
      });
      updateStamps(List.from(listW));
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
                  child: ListColorView(onChangeColor: (c) {}),
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
                    onScaling: (b) {},
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
      listW.add(ItemWidget(
          type: TypeItem.text,
          image: null,
          dx: localPosition.dx,
          dy: localPosition.dy,
          height: 40,
          width: 60));
    });
    updateStamps(List.from(listW));
    bloc!.updateShowAddText();

    // EditProvider.of(context)!.updateListWidget(listW);
  }

  _itemStack(int index, Size maxSize) {
    var item = listW[index];
    if (item.type == TypeItem.text) {
      return _ItemTextField(
        isOpenKeyboard: isKeyboardOpen,
        color: item.color,
        fontSize: item.fontSize,
        dy: item.dy,
        dx: item.dx,
        key: Key("$index"),
        index: index,
        onTap: (i) {
          setState(() {
            indexSelected = i;
          });
        },
        isSelected: indexSelected == index,
        maxSize: maxSize,
        isUnfocus: item.isFocus,
      );
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
    } else if (item.type == TypeItem.itemImage) {
      return _ItemImageWidget(
        dy: item.dy,
        dx: item.dx,
        key: Key("$index"),
        index: index,
        isSelected: indexSelected == index,
        maxSize: maxSize,
        path: item.image!,
      );
    } else {
      return _ItemPaintWidget(
        height: item.height,
        width: item.width,
        dy: item.dy,
        dx: item.dx,
        key: Key("$index"),
        index: index,
        maxSize: maxSize,
        image: item.uint8list,
      );
    }
  }

  addPaint() async {
    final boundary = keyImage.currentContext!.findRenderObject() as RenderRepaintBoundary;
    showLoading(context);
    final image = await boundary.toImage(pixelRatio: 10);
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    hideLoading();
    final pngBytes = byteData!.buffer.asUint8List();
    if (mounted) {
      ItemWidget? res = await Navigator.of(context).push(
        CustomPageNavigationBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => PaintProvider(
                  bloc: PaintBloc(),
                  child: PaintingScreen(image: pngBytes),
                )),
      );
      if (res != null) {
        setState(() {
          listW.add(res);
        });
        updateStamps(List.from(listW));
      }
    }
  }
}

class _TabbarTextView extends StatefulWidget {
  final Function(double) changeFontSize;
  final Function(Color) changeColor;
  final Function choiceColor;

  const _TabbarTextView(
      {Key? key,
      required this.changeFontSize,
      required this.changeColor,
      required this.choiceColor})
      : super(key: key);

  @override
  State<_TabbarTextView> createState() => _TabbarTextViewState();
}

class _TabbarTextViewState extends State<_TabbarTextView> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int fontSize = 16;
  int index = 0;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();

    _tabController!.addListener(() {
      if (_tabController!.indexIsChanging) {
        setState(() {
          index = _tabController!.index;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(color: AppColor.white94),
      height: 120,
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Container(
          margin: const EdgeInsets.all(4),
          height: 40,
          decoration: BoxDecoration(
            color: AppColor.neutral5,
            borderRadius: BorderRadius.circular(
              24.0,
            ),
          ),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(
                24.0,
              ),
              color: Colors.black,
            ),
            padding: EdgeInsets.zero,
            indicatorPadding: EdgeInsets.zero,
            labelPadding: EdgeInsets.zero,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            tabs: [
              const Tab(
                text: 'Aa',
              ),
              Tab(
                text: "${fontSize}pt",
              ),
              Tab(
                child: Center(
                  child: SvgPicture.asset(
                    "assets/svg/icon_fill_color.svg",
                    color: index == 2 ? Colors.white : Colors.black,
                  ),
                ),
              ),
              const Tab(
                text: 'Buy Now',
              ),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _listFont(),
              _SlideFontSize(onChangeSize: (d) {
                widget.changeFontSize(d);
                setState(() {
                  fontSize = d.toInt();
                });
              }),
              _colorPicker(),
              const Text("data"),
            ],
          ),
        )
      ]),
    );
  }

  _listFont() {
    return const _ListFont();
  }

  _colorPicker() {
    return ListColorView(
      onChangeColor: (c) {
        widget.changeColor(c);
      },
      choiceColor: () {
        widget.choiceColor();
      },
    );
  }
}

class _SlideFontSize extends StatefulWidget {
  final Function(double) onChangeSize;

  const _SlideFontSize({Key? key, required this.onChangeSize}) : super(key: key);

  @override
  State<_SlideFontSize> createState() => _SlideFontSizeState();
}

class _SlideFontSizeState extends State<_SlideFontSize> {
  double _value = 16;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Slider(
        min: 4,
        max: 56,
        value: _value,
        activeColor: Colors.black,
        thumbColor: Colors.white,
        label: "${_value.toInt()}pt",
        onChangeEnd: (v) {
          widget.onChangeSize(v);
        },
        onChanged: (value) {
          setState(() {
            _value = value;
          });
        },
      ),
    );
  }
}

class _ListFont extends StatefulWidget {
  const _ListFont({Key? key}) : super(key: key);

  @override
  State<_ListFont> createState() => _ListFontState();
}

class _ListFontState extends State<_ListFont> {
  int indexSelected = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              indexSelected = index;
            });
          },
          child: Container(
            constraints: const BoxConstraints(minWidth: 60),
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.fromLTRB(0, 4, 8, 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: indexSelected == index ? Colors.black : Colors.white),
            alignment: Alignment.center,
            child: Text(
              "Classic $index",
              style: AppTextStyle.styleFoodnote(
                  textColor: indexSelected == index ? Colors.white : Colors.black),
            ),
          ),
        );
      },
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: 6,
    );
  }
}

class _ItemTextField extends StatefulWidget {
  final int index;
  final bool isSelected;
  final Function(int) onTap;
  final double? dx;
  final double? dy;
  final Size maxSize;
  final bool isOpenKeyboard;
  bool? isUnfocus;
  Color? color;
  double? fontSize;

  _ItemTextField({
    Key? key,
    required this.isSelected,
    required this.onTap,
    required this.index,
    required this.dx,
    required this.dy,
    required this.maxSize,
    required this.isOpenKeyboard,
    this.color,
    this.fontSize = 16,
    this.isUnfocus,
  }) : super(key: key);

  @override
  State<_ItemTextField> createState() => _ItemTextFieldState();
}

class _ItemTextFieldState extends State<_ItemTextField> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  String text = "";
  int line = 1;
  Matrix4? matrix = Matrix4.identity();
  final GlobalKey key = GlobalKey();
  Offset? offset;

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
    if (widget.isUnfocus != null && widget.isUnfocus!) {
      _focusNode.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap(widget.index),
      child: SizedBox(
          height: widget.maxSize.height,
          width: widget.maxSize.width,
          child: Stack(
            children: [
              widget.isSelected
                  ? AnimatedPositioned(
                      top: widget.isOpenKeyboard ? 40.0 : widget.dy!,
                      left: widget.dx!,
                      duration: const Duration(milliseconds: 300),
                      child: Container(
                          key: key,
                          decoration: BoxDecoration(
                            color:
                                text.isEmpty ? Colors.black.withOpacity(0.6) : Colors.transparent,
                          ),
                          height: line > 1 ? (widget.fontSize! + 2) * line : 40,
                          width: text.isEmpty || text.length * 8 < 60
                              ? 72.0
                              : (text.length * 8 > widget.maxSize.width
                                  ? widget.maxSize.width
                                  : text.length * 8),
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            maxLength: null,
                            maxLines: line,
                            controller: _controller,
                            focusNode: _focusNode,
                            onChanged: (s) {
                              setState(() {
                                text = s;
                              });
                              if (text.length * 7 >= widget.maxSize.width / 2) {
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
                                  line = t.length * 7 ~/ widget.maxSize.width <= 1
                                      ? 1
                                      : t.length * 7 ~/ widget.maxSize.width;
                                });
                              }
                            },
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                              ),
                            ),
                            style: TextStyle(
                                fontFamily: 'SFProDisplay',
                                color: widget.color ?? Colors.black,
                                fontSize: widget.fontSize ?? 16),
                          )),
                    )
                  : Positioned(
                      top: widget.dy!,
                      left: widget.dx!,
                      child: Transform(
                        transform: matrix!,
                        child: MatrixGestureDetector(
                          onMatrixUpdate: (matrix, translationDeltaMatrix, scaleDeltaMatrix,
                              rotationDeltaMatrix) {
                            var s = MatrixUtils.transformRect(
                                matrix, key.currentContext!.findRenderObject()!.paintBounds);

                            RenderBox box = key.currentContext!.findRenderObject() as RenderBox;
                            Offset position = box.localToGlobal(Offset.zero);
                            setState(() {
                              this.matrix = matrix;
                              offset = position;
                            });
                          },
                          onScaling: (b) {
                            if (!b) {
                              // widget.updatePosition(offset!.dx, offset!.dy, !b);
                            }
                          },
                          child: Container(
                            key: key,
                            decoration: BoxDecoration(
                              color:
                                  text.isEmpty ? Colors.black.withOpacity(0.6) : Colors.transparent,
                            ),
                            height: line > 1 ? (widget.fontSize! + 2) * line : 40,
                            width: text.isEmpty || text.length * 8 < 60
                                ? 72.0
                                : (text.length * 8 > widget.maxSize.width
                                    ? widget.maxSize.width
                                    : text.length * 8),
                            child: Text(
                              text,
                              style: TextStyle(
                                  fontFamily: 'SFProDisplay',
                                  color: widget.color ?? Colors.black,
                                  fontSize: widget.fontSize ?? 16),
                            ),
                          ),
                        ),
                      ))
            ],
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

class _ItemImageWidget extends StatefulWidget {
  final int index;
  final bool isSelected;
  final double? dx;
  final double? dy;
  final Size maxSize;
  final String path;

  const _ItemImageWidget({
    Key? key,
    required this.isSelected,
    required this.index,
    required this.dx,
    required this.dy,
    required this.maxSize,
    required this.path,
  }) : super(key: key);

  @override
  State<_ItemImageWidget> createState() => _ItemImageWidgetState();
}

class _ItemImageWidgetState extends State<_ItemImageWidget> {
  int line = 1;
  Matrix4? matrix = Matrix4.identity();
  final GlobalKey key = GlobalKey();
  Offset? offset;
  bool isCircle = false;
  double size = 80;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: widget.maxSize.height,
        width: widget.maxSize.width,
        child: Stack(
          children: [
            Positioned(
              top: widget.dy!,
              left: widget.dx!,
              child: Transform(
                transform: matrix!,
                child: MatrixGestureDetector(
                  onMatrixUpdate:
                      (matrix, translationDeltaMatrix, scaleDeltaMatrix, rotationDeltaMatrix) {
                    RenderBox box = key.currentContext!.findRenderObject() as RenderBox;
                    Offset position = box.localToGlobal(Offset.zero);
                    setState(() {
                      this.matrix = matrix;
                      offset = position;
                    });
                  },
                  onScaling: (b) {},
                  child: SizedBox(
                    key: key,
                    height: size,
                    width: size,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          right: 0,
                          bottom: 0,
                          left: 0,
                          child: isCircle
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(size / 2),
                                  child: Image.file(
                                    File(widget.path),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Image.file(
                                  File(widget.path),
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          bottom: 0,
                          left: 0,
                          child: InkWell(onTap: () {
                            setState(() {
                              isCircle = !isCircle;
                            });
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

class _ItemPaintWidget extends StatefulWidget {
  final int index;
  final double? dx;
  final double? dy;
  final double? height;
  final double? width;
  final Size maxSize;
  final Uint8List? image;

  const _ItemPaintWidget({
    Key? key,
    required this.index,
    required this.dx,
    required this.dy,
    required this.maxSize,
    required this.image,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  State<_ItemPaintWidget> createState() => _ItemPaintWidgetState();
}

class _ItemPaintWidgetState extends State<_ItemPaintWidget> {
  Matrix4? matrix = Matrix4.identity();
  final GlobalKey key = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: widget.maxSize.height,
        width: widget.maxSize.width,
        child: Stack(
          children: [
            Positioned(
              top: widget.dy!,
              left: widget.dx!,
              child: Transform(
                transform: matrix!,
                child: MatrixGestureDetector(
                  onMatrixUpdate:
                      (matrix, translationDeltaMatrix, scaleDeltaMatrix, rotationDeltaMatrix) {
                    setState(() {
                      this.matrix = matrix;
                    });
                  },
                  onScaling: (b) {},
                  child: SizedBox(
                    key: key,
                    width: widget.width,
                    height: widget.height,
                    child: Image.memory(
                      widget.image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
