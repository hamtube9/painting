import 'dart:async';
import 'dart:ui' as ui;

import 'package:background/utils/styles/color_style.dart';
import 'package:background/utils/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TemplatesView extends StatefulWidget {
  final bool isVisibleTextPro;
  final String titleTemplate;
  final Function templateOnClick;
  final List<String>? items;

  const TemplatesView(
      {Key? key, required this.titleTemplate, required this.templateOnClick, this.items,   this.isVisibleTextPro = true})
      : super(key: key);

  @override
  State<TemplatesView> createState() => TemplatesViewState();
}

class TemplatesViewState extends State<TemplatesView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                    widget.titleTemplate,
                    style: AppTextStyle.styleHeadline(),
                  )),
              TextButton(onPressed: () => widget.templateOnClick(), child: Text(
                "See all",
                style: AppTextStyle.styleHeadline(textColor: AppColor.active),
              ))
            ],
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            itemBuilder: (context, index) => _itemTemplate(index),
            itemCount: widget.items != null ? widget.items!.length : 10,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
          ),
        )
      ],
    );
  }

  _itemTemplate(int index) {
    return Container(
      height: 100,
      width: 100,
      margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
      decoration: BoxDecoration(color: AppColor.neutral5, borderRadius: BorderRadius.circular(12)),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 0,
            child: widget.items != null
                ? Container(
                    alignment: Alignment.center,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SvgPicture.asset(
                          widget.items![index],
                          fit: BoxFit.cover,
                        )),
                  )
                : Container(),
          ),
          widget.isVisibleTextPro ?   Positioned(
            top: 0,
            left: 0,
            child: index > 1 ? const ProTextWidget() : Container(),
          ) : Container()
        ],
      ),
    );
  }
}

class ProTextWidget extends StatelessWidget {
  const ProTextWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
          color: AppColor.secondary),
      child: Text(
        'Pro',
        style: AppTextStyle.styleCaption2(textColor: Colors.white),
      ),
    );
  }
}

class TemplatesFlexibleView extends StatefulWidget {
  final String titleTemplate;
  final Function templateOnClick;
  final List<dynamic>? items;

  const TemplatesFlexibleView(
      {Key? key, required this.titleTemplate, required this.templateOnClick, this.items})
      : super(key: key);

  @override
  State<TemplatesFlexibleView> createState() => TemplatesFlexibleViewState();
}

class TemplatesFlexibleViewState extends State<TemplatesFlexibleView> {
  List<String> img = [
    "assets/images/fake.png",
    "assets/images/logo.png",
    "assets/images/fake.png",
    "assets/images/fake.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                widget.titleTemplate,
                style: AppTextStyle.styleHeadline(),
              )),
              TextButton(onPressed:() => widget.templateOnClick(), child: Text(
                "See all",
                style: AppTextStyle.styleHeadline(textColor: AppColor.active),
              ))
            ],
          ),
        ),
        SizedBox(
          height: 160,
          child: ListView.builder(
            itemBuilder: (context, index) => _itemTemplate(index),
            itemCount: widget.items != null ? widget.items!.length : img.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
          ),
        )
      ],
    );
  }

  _itemTemplate(int index) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
      width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(child: _imageWidget(img[index])),
          Text(
            "Instagram Stories",
            style: AppTextStyle.styleCaption2(),
          )
        ],
      ),
    );
  }

  _imageWidget(String img) {
    var image = Image.asset(img);
    Completer<ui.Image> completer = Completer<ui.Image>();
    image.image
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
      completer.complete(info.image);
    }));
    return LayoutBuilder(builder: (context, constraints) {
      return FutureBuilder<ui.Image>(
        future: completer.future,
        builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
          if (snapshot.hasData) {
            return SizedBox(
              height:  snapshot.data!.height.toDouble() > constraints.maxHeight ?  constraints.maxHeight  :  snapshot.data!.height.toDouble(),
              width: snapshot.data!.width.toDouble() > constraints.maxWidth ?  constraints.maxWidth  :  snapshot.data!.width.toDouble(),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    bottom: 0,
                    left: 0,
                    child: ClipRRect(borderRadius: BorderRadius.circular(12),child: Image.asset(
                      img,
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.bottomCenter,
                    )),
                  ),
                  const Positioned(
                    top: 0,
                    left: 0,
                    child: ProTextWidget(),
                  )
                ],
              ),
            );
          } else {
            return Container(
              height: 100,
              width: 100,
              child: const CircularProgressIndicator(),
            );
          }
        },
      );
    },);
  }
}

class TemplatesBlackFridayView extends StatefulWidget {
  final String titleTemplate;
  final Function templateOnClick;
  final List<dynamic>? items;

  const TemplatesBlackFridayView(
      {Key? key, required this.titleTemplate, required this.templateOnClick, this.items})
      : super(key: key);

  @override
  State<TemplatesBlackFridayView> createState() => TemplatesBlackFridayViewState();
}

class TemplatesBlackFridayViewState extends State<TemplatesBlackFridayView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                    widget.titleTemplate,
                    style: AppTextStyle.styleHeadline(),
                  )),
              TextButton(onPressed:() => widget.templateOnClick(), child: Text(
                "See all",
                style: AppTextStyle.styleHeadline(textColor: AppColor.active),
              ))
            ],
          ),
        ),
        SizedBox(
          height: 160,
          child: ListView.builder(
            itemBuilder: (context, index) => _itemTemplate(index),
            itemCount: widget.items != null ? widget.items!.length : 5,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
          ),
        )
      ],
    );
  }

  _itemTemplate(int index) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
      width: 100,
      color: Colors.grey,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            left: 0,
            child: Container(),
          ),
          Positioned(
            top: 4,
            left: 8,
            width: 50,
            child: Image.asset(
              'assets/images/black_friday.png',
              fit: BoxFit.fitWidth,
            ),
          ),
          index > 1
              ? const Positioned(
                  top: 0,
                  left: 0,
                  child: ProTextWidget(),
                )
              : Container()
        ],
      ),
    );
  }
}

class TemplatesFashionView extends StatefulWidget {
  final String titleTemplate;
  final Function templateOnClick;
  final List<dynamic>? items;

  const TemplatesFashionView(
      {Key? key, required this.titleTemplate, required this.templateOnClick, this.items})
      : super(key: key);

  @override
  State<TemplatesFashionView> createState() => TemplatesFashionViewState();
}

class TemplatesFashionViewState extends State<TemplatesFashionView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                    widget.titleTemplate,
                    style: AppTextStyle.styleHeadline(),
                  )),
              TextButton(onPressed:() => widget.templateOnClick(), child: Text(
                "See all",
                style: AppTextStyle.styleHeadline(textColor: AppColor.active),
              ))
            ],
          ),
        ),
        SizedBox(
          height: 160,
          child: ListView.builder(
            itemBuilder: (context, index) => _itemTemplate(index),
            itemCount: widget.items != null ? widget.items!.length : 5,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
          ),
        )
      ],
    );
  }

  _itemTemplate(int index) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
      width: 100,
      color: AppColor.neutral5,

    );
  }
}
