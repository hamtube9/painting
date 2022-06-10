import 'package:background/utils/styles/size_style.dart';
import 'package:background/utils/styles/text_style.dart';
import 'package:flutter/material.dart';

class ButtonPrimary extends StatelessWidget {
  final double? height;
  final double? width;
  final String text;
  final Function onClick;

  const ButtonPrimary({Key? key, required this.text, required this.onClick, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ))),
          onPressed: () => onClick(),
          child: Text(
            text,
            style: AppTextStyle.styleCallout(textColor: Colors.white, fontWeight: FontWeight.w600),
          )),
    );
  }
}

class TextButtonPrimary extends StatelessWidget {
  final double? height;
  final double? width;
  final String text;
  final Function onClick;

  const TextButtonPrimary({Key? key, required this.text, required this.onClick, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextButton(
        onPressed: () => onClick(),
        style: ButtonStyle(
            shape:
                MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(StyleSize.kBorderRadius), side: const BorderSide(color: Colors.black)))),
        child: Text(
          text,
          style: AppTextStyle.styleCallout(textColor: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
