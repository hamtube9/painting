import 'package:background/utils/Constant.dart';
import 'package:background/utils/controller/button_outline_gradient.dart';
import 'package:background/utils/controller/text_gradient.dart';
import 'package:background/utils/navigation/navigation_page.dart';
import 'package:background/utils/styles/color_style.dart';
import 'package:background/utils/styles/size_style.dart';
import 'package:background/utils/styles/text_style.dart';
import 'package:background/views/gallery_screen.dart';
import 'package:background/views/templates/template_view.dart';
import 'package:background/views/templates/upgrade_view.dart';
import 'package:flutter/material.dart';

class TemplateScreen extends StatefulWidget {
  const TemplateScreen({Key? key}) : super(key: key);

  @override
  State<TemplateScreen> createState() => _TemplateScreenState();
}

class _TemplateScreenState extends State<TemplateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.neutral5.withOpacity(0.4),
      body: Stack(children: [
        Positioned(
          top: 0,
          right: 0,
          left: 0,
          bottom: 0,
          child: Image.asset(
            'assets/images/background.png',
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          left: 0,
          bottom: 0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                    child: Row(
                      children: [
                        Text(
                          "Templates",
                          style: AppTextStyle.styleTitle2(textColor: Colors.black),
                        ),
                        const Spacer(),
                        SizedBox(
                          height: 40,
                          width: 120,
                          child: ButtonOutlineGradient(
                              margin: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                              radius: 12,
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
                  TemplatesView(
                    templateOnClick: () => _navigationGallery(),
                    titleTemplate: 'Recent',
                  ),
                  _space(),
                  TemplatesFlexibleView(
                    templateOnClick: () {},
                    titleTemplate: 'Socials',
                  ),
                  _space(),
                  TemplatesView(
                    items: List.generate(10, (index) => "assets/svg/hand_bag.svg").toList(),
                    templateOnClick: () => _navigationGallery(),
                    titleTemplate: 'Minimalist Store',
                  ),
                  _space(),
                  TemplatesView(
                    templateOnClick: () {},
                    titleTemplate: 'Ecommerce Channels',
                  ),
                  _space(),
                  TemplatesView(
                    templateOnClick: () {},
                    titleTemplate: 'Discount',
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                    child: UpgradeView(onClick: () {}),
                  ),
                  TemplatesBlackFridayView(
                    templateOnClick: () => _editBlackFridayTemplate(),
                    titleTemplate: 'Black Friday',
                  ),
                  _space(),
                  TemplatesFashionView(titleTemplate: "Fashion", templateOnClick: () {})
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }

  _space({double height = 16}) {
    return SizedBox(
      height: height,
    );
  }

  _navigationGallery() {
    Navigator.of(context).push(
      CustomPageNavigationBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const GalleryScreen(
                isBlackFriday: false,
              )),
    );
  }

  _editBlackFridayTemplate() async {
    Navigator.of(context).push(
      CustomPageNavigationBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const GalleryScreen(
                isBlackFriday: true,
              )),
    );
  }
}
