
import 'package:background/utils/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TemplatesView extends StatefulWidget {
  final String titleTemplate;
  final Function templateOnClick;
  final List<String>? items;

  const TemplatesView(
      {Key? key, required this.titleTemplate, required this.templateOnClick, this.items})
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
        Row(
          children: [
            Expanded(
                child: Text(
                  widget.titleTemplate,
                  style: AppTextStyle.styleHeadline(),
                )),
            TextButton.icon(
              onPressed: () => widget.templateOnClick(),
              icon: Text(
                "All",
                style: AppTextStyle.styleHeadline(),
              ),
              label: const Icon(
                Icons.chevron_right,
                color: Color(0xff212121),
              ),
            )
          ],
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
      color: Colors.grey,
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
              child: SvgPicture.asset(
                widget.items![index],
                fit: BoxFit.cover,
              ),
            )
                : Container(),
          ),
          Positioned(
            top: 4,
            left: 8,
            child: index > 1
                ? Container(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24), color: const Color(0xff6F90B4)),
              child: Text(
                'Pro',
                style: AppTextStyle.styleCaption2(textColor: Colors.white),
              ),
            )
                : Container(),
          )
        ],
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
        Row(
          children: [
            Expanded(
                child: Text(
                  widget.titleTemplate,
                  style: AppTextStyle.styleHeadline(),
                )),
            TextButton.icon(
              onPressed: () => widget.templateOnClick(),
              icon: Text(
                "All",
                style: AppTextStyle.styleHeadline(),
              ),
              label: const Icon(
                Icons.chevron_right,
                color: Color(0xff212121),
              ),
            )
          ],
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
        children: [
          Expanded(
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    bottom: 0,
                    left: 0,
                    child: Image.asset(
                      img[index],
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                  index > 1
                      ? Positioned(
                    top: 4,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: const Color(0xff6F90B4)),
                      child: Text(
                        'Pro',
                        style: AppTextStyle.styleCaption2(textColor: Colors.white),
                      ),
                    ),
                  )
                      : Container()
                ],
              )),
          Text(
            "Instagram Stories",
            style: AppTextStyle.styleCaption2(),
          )
        ],
      ),
    );
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
        Row(
          children: [
            Expanded(
                child: Text(
                  widget.titleTemplate,
                  style: AppTextStyle.styleHeadline(),
                )),
            TextButton.icon(
              onPressed: () => widget.templateOnClick(),
              icon: Text(
                "All",
                style: AppTextStyle.styleHeadline(),
              ),
              label: const Icon(
                Icons.chevron_right,
                color: Color(0xff212121),
              ),
            )
          ],
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
      child:Stack(
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
              ? Positioned(
            top: 4,
            left: 8,
            child: Container(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: const Color(0xff6F90B4)),
              child: Text(
                'Pro',
                style: AppTextStyle.styleCaption2(textColor: Colors.white),
              ),
            ),
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
        Row(
          children: [
            Expanded(
                child: Text(
                  widget.titleTemplate,
                  style: AppTextStyle.styleHeadline(),
                )),
            TextButton.icon(
              onPressed: () => widget.templateOnClick(),
              icon: Text(
                "All",
                style: AppTextStyle.styleHeadline(),
              ),
              label: const Icon(
                Icons.chevron_right,
                color: Color(0xff212121),
              ),
            )
          ],
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
      child:Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            left: 0,
            child: Container(),
          ),
          index > 1
              ? Positioned(
            top: 4,
            left: 8,
            child: Container(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: const Color(0xff6F90B4)),
              child: Text(
                'Pro',
                style: AppTextStyle.styleCaption2(textColor: Colors.white),
              ),
            ),
          )
              : Container()
        ],
      ),
    );
  }
}