import 'package:background/utils/Constant.dart';
import 'package:background/utils/controller/button_outline_gradient.dart';
import 'package:background/utils/controller/text_gradient.dart';
import 'package:background/utils/styles/color_style.dart';
import 'package:background/utils/styles/size_style.dart';
import 'package:background/utils/styles/text_style.dart';
import 'package:flutter/material.dart';

class UpgradeView extends StatelessWidget {
  final Function onClick;
  const UpgradeView({Key? key, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(),
      child: Container(
        height: 160,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              left: 0,
              child: Image.asset("assets/images/img-upgrade.png", fit: BoxFit.fill),
            ),
            Positioned(
              top: 16,
              right: 0,
              bottom: 56,
              left: 16,
              child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "Unlimited access\n",
                        style: AppTextStyle.styleTitle2(textColor: Colors.white)),
                    TextSpan(
                        text: "Templates & Features",
                        style: AppTextStyle.styleHeadline(textColor: Colors.white)),
                  ])),
            ),
            Positioned(
              bottom: 16,
              left: 24,
              height: 40,
              width: 120,
              child: ButtonOutlineGradient(
                  radius: 12,
                  background: Colors.white,
                  gradient: AppColor.gradient1,
                  child: const GradientText(
                    text: "UPGRADE PRO",
                    style: TextStyle(
                      fontSize: SizeText.kSizeTextCaption1,
                      fontFamily: MyStrings.fontFamily,
                      fontWeight: FontWeight.w600,
                    ),
                    gradient: AppColor.gradient1,
                  ),
                  onPressed: () {}),
            ),
          ],
        ),
      ),
    );
  }
}

