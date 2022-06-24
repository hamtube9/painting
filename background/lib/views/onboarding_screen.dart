import 'package:background/utils/controller/button_primary.dart';
import 'package:background/utils/styles/color_style.dart';
import 'package:background/utils/styles/text_style.dart';
import 'package:background/views/question_screen.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  double currentPage = 0.0;
  bool isAnimate = false;
  List<String> images = [
    "assets/images/img-onborading-01.png",
    "assets/images/img-onborading-02.png",
    "assets/images/img-onborading-03.png",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
    _pageController.addListener(_onPageChange);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    images.clear();
    _pageController.removeListener(_onPageChange);
    _pageController.dispose();

  }


  void _onPageChange() {
    setState(() {
      currentPage = _pageController.page!.toDouble();
    });
  }

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
          bottom: 16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
                child: Column(
                  children: [
                    Expanded(
                        flex: 5,
                        child: PageView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Transform(
                              transform: Matrix4.identity()..rotateX(currentPage - index),
                              child: _image(images[index]),
                            );
                          },
                          itemCount: images.length,
                          controller: _pageController,
                          onPageChanged: (i) {},
                        )),
                    Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _titleIndex(),
                              Text(
                                _indexTextContent(),
                                style: AppTextStyle.styleCallout(),
                              )
                            ],
                          ),
                        )),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
              child: ButtonPrimary(
                text: 'NEXT',
                onClick: () => _changePage(),
              ),
            )
          ],
        ),
      ),
      ])
    );
  }

  _image(String image) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        final width = constraints.maxWidth;
        return  Image.asset(
          image,
          fit: BoxFit.cover,
          height: height,
          width: width,
        );
      },
    );
  }

  _indexTextContent() {
    if (currentPage == 1) {
      return 'Who has time to edit individual images and listings. Get things done FAST with Bulk';
    } else if (currentPage == 2) {
      return 'Once tap to add directly to Instagram, Facebook, Tiktok, Shopify & more';
    } else {
      return 'Who has time to edit individual images and listings. Get things done FAST with Bulk';
    }
  }

  _changePage() async {
    if(isAnimate){
      return;
    }
    if (currentPage < 2) {
      setState(() {
        isAnimate = true;
      });
      Future.delayed(const Duration(milliseconds: 700)).then((value){
        setState(() {
          isAnimate = false;
        });
      });
      await _pageController.animateToPage((currentPage + 1).toInt(),
          duration: const Duration(milliseconds: 600), curve: Curves.easeIn);
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const QuestionScreen(),
      ));
    }
  }

  _titleIndex() {
    switch (currentPage.toInt()) {
      case 0:
        return RichText(
          text: TextSpan(children: [
            TextSpan(text: "Remove\n", style: AppTextStyle.styleOnboardingTitle()),
            TextSpan(text: "Backgrounds in ", style: AppTextStyle.styleOnboardingTitle()),
            TextSpan(
                text: "Bluk",
                style: AppTextStyle.styleOnboardingTitle(textColor: AppColor.secondary)),
          ]),
        );
      case 1:
        return RichText(
          text: TextSpan(children: [
            TextSpan(
                text: "Push ",
                style: AppTextStyle.styleOnboardingTitle(textColor: AppColor.secondary)),
            TextSpan(text: "to Social\n", style: AppTextStyle.styleOnboardingTitle()),
            TextSpan(text: "Media, eCommerce", style: AppTextStyle.styleOnboardingTitle()),
          ]),
        );
      default:
        return RichText(
          text: TextSpan(children: [
            TextSpan(text: "Add Logo,\n", style: AppTextStyle.styleOnboardingTitle()),
            TextSpan(text: "Effect & ", style: AppTextStyle.styleOnboardingTitle()),
            TextSpan(
                text: "Sticker",
                style: AppTextStyle.styleOnboardingTitle(textColor: AppColor.secondary)),
          ]),
        );
    }
  }

}
