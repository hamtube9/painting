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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page!.toDouble();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
                child: Column(
              children: [
                Expanded(
                    child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Transform(
                      transform: Matrix4.identity()..rotateX(currentPage - index),
                      child: _image(),
                    );
                  },
                  itemCount: 3,
                  controller: _pageController,
                  onPageChanged: (i) {
                    setState(() {});
                  },
                )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        _indexTextTitle(),
                        style: AppTextStyle.styleOnboardingTitle(textColor: AppColor.neutralLight1),
                      ),
                      Text(
                        _indexTextContent(),
                        style: AppTextStyle.styleCallout(),
                      )
                    ],
                  ),
                )),
              ],
            )),
            ButtonPrimary(
              text: 'NEXT',
              onClick: () => _changePage(),
            )
          ],
        ),
      ),
    );
  }

  _image() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        final width = constraints.maxWidth;
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Image.network(
            'https://static.lag.vn/upload/news/22/04/07/spy-x-family-anya-forger-la-ai-1_UMOI.jpg?w=800&encoder=wic&subsampling=444',
            fit: BoxFit.cover,
            height: height,
            width: width,
          ),
        );
      },
    );
  }

  _indexTextTitle() {
    if (currentPage == 1) {
      return 'Remove Backgrounds in Bulk';
    } else if (currentPage == 2) {
      return 'Upload to Social Media or eCommerce';
    } else {
      return 'Add Logos, Effects and Templates';
    }
  }

  _indexTextContent() {
    if (currentPage == 1) {
      return 'Who has time to edit individual images and listings. Get things done FAST with Bulk';
    } else if (currentPage == 2) {
      return 'We have made our';
    } else {
      return 'Once tap to add directly to Instagram, Facebook, Tiktok, Shopify & more';
    }
  }

  _changePage() {
    if(currentPage <2){
      _pageController.animateToPage((currentPage+1).toInt(), duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    }else{
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const QuestionScreen(),));
    }
  }
}
