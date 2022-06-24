import 'package:background/utils/controller/button_primary.dart';
import 'package:background/utils/styles/color_style.dart';
import 'package:background/utils/styles/text_style.dart';
import 'package:flutter/material.dart';

import 'subcribtion_screen.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
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
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Do you need for?",
                            style: AppTextStyle.styleTitle2(),
                          ),
                          Text(
                            "Optimize your experience",
                            style: AppTextStyle.styleCallout(textColor: AppColor.neutralLight1),
                          )
                        ],
                      )),
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Expanded(
                                child: _ItemQuestionView(
                              onClick: () {},
                              text: 'Media',
                              content: "Instagram, Facebook, Tiktok, Youtube & More",
                            )),
                            Expanded(
                                child: _ItemQuestionView(
                              onClick: () {},
                              text: 'e-Commerce',
                              content: "Amazon, Ebay, Shopify & More",
                            )),
                            Expanded(
                                child: _ItemQuestionView(
                              onClick: () {},
                              text: 'Small Store',
                              content: "The personal store ( websites, fanpages, chanels ...)",
                            )),
                            Expanded(
                                child: _ItemQuestionView(
                              onClick: () {},
                              text: "Let's me try",
                              content: "Discovery features of the app",
                            )),
                            Expanded(child: Container()),
                            Expanded(child: Container()),
                          ],
                        ),
                      ),
                    ],
                  )),
                  ButtonPrimary(
                    text: "LET'S GO",
                    onClick: () => _navigateToSubcription(),
                    width: MediaQuery.of(context).size.width,
                  )
                ],
              ),
            ),
          )
        ]));
  }

  _navigateToSubcription() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const SubcriptionScreen(),
    ));
  }
}

class _ItemQuestionView extends StatefulWidget {
  final String text;
  final String content;
  final Function onClick;

  const _ItemQuestionView(
      {Key? key, required this.text, required this.onClick, required this.content})
      : super(key: key);

  @override
  State<_ItemQuestionView> createState() => _ItemQuestionViewState();
}

class _ItemQuestionViewState extends State<_ItemQuestionView> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? Colors.black : const Color(0xffC4D0DF),width:  isSelected ? 2 : 1),
          color: isSelected ? const Color(0xffE9E9E9) : Colors.transparent),
      child: Stack(
        children: [
          Positioned(
            top: 8,
            right: 8,
            left: 8,
            bottom: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  widget.text,
                  style: AppTextStyle.styleHeadline(textColor: AppColor.neutralLight1),
                ),
                Text(
                  widget.content,
                  style: AppTextStyle.styleCaption2(textColor: const Color(0xffC4D0DF)),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 0,
            child: InkWell(
              onTap: () {
                setState(() {
                  isSelected = !isSelected;
                });
                widget.onClick();
              },
            ),
          ),
        ],
      ),
    );
  }
}
