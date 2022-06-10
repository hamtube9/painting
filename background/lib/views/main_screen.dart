import 'package:background/services/pick_image_services.dart';
import 'package:background/utils/navigation/navigation_page.dart';
import 'package:background/utils/styles/color_style.dart';
import 'package:background/utils/styles/text_style.dart';
import 'package:background/views/gallery_screen.dart';
import 'package:background/views/templates/template_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
                templateOnClick: ()  => _navigationGallery(),
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
                templateOnClick: () {},
                titleTemplate: 'Black Friday',
              ),
              _space(),
              TemplatesFashionView(titleTemplate: "Fashion", templateOnClick: (){})
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Row(
          children: [
            Expanded(
                child: Center(
              child: GestureDetector(
                child: Container(
                  height: 56,
                  width: 56,
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: SvgPicture.asset('assets/svg/ic_group.svg'),
                ),
              ),
            )),
            Expanded(
                child: Center(
              child: GestureDetector(
                onTap: () => PickImageService.pickImage(context),
                child: Container(
                  height: 56,
                  width: 56,
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 1),
                            color: Colors.grey,
                            blurRadius: 1,
                            spreadRadius: 1)
                      ]),
                  child: const Icon(
                    Icons.add_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
            )),
            Expanded(
                child: Center(
              child: GestureDetector(
                child: Container(
                  height: 56,
                  width: 56,
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: SvgPicture.asset('assets/svg/ic_settings.svg'),
                ),
              ),
            )),
          ],
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
        pageBuilder: (context, animation, secondaryAnimation) => GalleryScreen()),);
  }
}

