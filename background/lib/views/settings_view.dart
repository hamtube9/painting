import 'package:background/utils/styles/text_style.dart';
import 'package:background/views/templates/template_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buttonLogin("FACEBOOK"),
              _buttonLogin("GOOGLE"),
              _buttonLogin("APPLE"),
              _buttonLogin("TIKTOK"),
              Padding(
                padding: const EdgeInsets.all(16),
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                          text: 'By signing in, i agree to the\n',
                          style: AppTextStyle.styleFoodnote(textColor: Colors.black)),
                      TextSpan(
                          text: 'Terms of Use ',
                          style: AppTextStyle.styleFoodnote(
                              textColor: Colors.black, fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: ' and ',
                          style: AppTextStyle.styleFoodnote(textColor: Colors.black)),
                      TextSpan(
                          text: 'Privacy Policy',
                          style: AppTextStyle.styleFoodnote(
                              textColor: Colors.black, fontWeight: FontWeight.bold)),
                    ])),
              ),
              Container(
                height: 84,
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(12)),
                child: Text(
                  'Pro Version - Unlimited',
                  style: AppTextStyle.styleTitle2(textColor: Colors.white),
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: Center(
                    child: Text(
                      'Rate the App',
                      style: AppTextStyle.styleSubhead(fontWeight: FontWeight.w500),
                    ),
                  )),
                  Expanded(
                      child: Center(
                    child: Text(
                      'Term of Use',
                      style: AppTextStyle.styleSubhead(fontWeight: FontWeight.w500),
                    ),
                  )),
                  Expanded(
                      child: Center(
                    child: Text(
                      'Privary Policy',
                      style: AppTextStyle.styleSubhead(fontWeight: FontWeight.w500),
                    ),
                  )),
                ],
              ),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(7, (index) => _itemUserMade(index)),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buttonLogin(String social) {
    return ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(primary: Colors.black),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.details,
              color: Colors.white,
            ),
            Text(
              "SIGNIN WITH $social",
              style:
                  AppTextStyle.styleSubhead(fontWeight: FontWeight.w600, textColor: Colors.white),
            )
          ],
        ));
  }

  _itemUserMade(int index) {
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
              child: Container(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/svg/hand_bag.svg',
                  fit: BoxFit.cover,
                ),
              )),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
                child: const Icon(Icons.more_vert),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          content: Text(
                            'The image can’t restore.\nDelete it?',
                            style: AppTextStyle.styleCallout(
                                fontWeight: FontWeight.w600, textColor: Colors.black),
                          ),
                          actions: [
                            CupertinoDialogAction(
                              child: Text(
                                'Cancel',
                                style: AppTextStyle.styleBody(
                                  textColor: const Color(0xff007AFF),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                            ),
                            CupertinoDialogAction(
                              child: Text(
                                'Ok',
                                style: AppTextStyle.styleBody(
                                    textColor: const Color(0xff007AFF),
                                    fontWeight: FontWeight.w600),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                            ),
                          ],
                        );
                      });
                }),
          )
        ],
      ),
    );
  }
}
