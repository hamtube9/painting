import 'package:background/utils/navigation/navigation_page.dart';
import 'package:background/utils/styles/color_style.dart';
import 'package:background/utils/styles/text_style.dart';
import 'package:background/views/gallery_screen.dart';
import 'package:background/views/templates/template_view.dart';
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
      appBar: AppBar(
        backgroundColor: AppColor.white94,
        elevation: 0.0,
        leading: Container(),
        title: Transform(
          // you can forcefully translate values left side using Transform
          transform: Matrix4.translationValues(-48.0, 0.0, 0.0),
          child: Text(
            "Templates",
            style: AppTextStyle.styleTitle2(textColor: Colors.black),
          ),
        ),
        centerTitle: false,
        actions: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 8, 16, 8),
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 0.5)),
            alignment: Alignment.center,
            child: Text(
              "UPGRADE PRO",
              style: AppTextStyle.styleCaption1(fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                titleTemplate: 'Ecommerce Chanels',
              ),
              _space(),
              TemplatesView(
                templateOnClick: () {},
                titleTemplate: 'Discount',
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 16, 16, 16),
                padding: const EdgeInsets.all(16),
                decoration:
                    BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        "Unlimited access template",
                        style: AppTextStyle.styleTitle2(textColor: Colors.white),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(0, 4, 16, 4),
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                          decoration:
                              BoxDecoration(border: Border.all(color: Colors.white, width: 0.5)),
                          alignment: Alignment.center,
                          child: Text(
                            "UPGRADE PRO",
                            style: AppTextStyle.styleCaption1(
                                fontWeight: FontWeight.w600, textColor: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
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
    );
  }


  _space({double height = 16}) {
    return SizedBox(
      height: height,
    );
  }


  _navigationGallery() {
    Navigator.of(context).push(CustomPageNavigationBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>   const GalleryScreen(isBlackFriday: false,)),);
  }

  _editBlackFridayTemplate() async {
    Navigator.of(context).push(CustomPageNavigationBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>   const GalleryScreen(isBlackFriday: true,)),);
  }

}
