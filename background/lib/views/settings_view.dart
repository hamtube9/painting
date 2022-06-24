import 'package:background/utils/styles/color_style.dart';
import 'package:background/utils/styles/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'templates/upgrade_view.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _UserInfo(
                      nameUser: "Ngaos chos",
                      email: "hamtube9@gmail.com",
                      image: "",
                      logOut: (){},
                    ),
                    UpgradeView(onClick: () {}),
                    const SizedBox(
                      height: 16,
                    ),
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
                                    textColor: AppColor.active, fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: ' and ',
                                style: AppTextStyle.styleFoodnote(textColor: Colors.black)),
                            TextSpan(
                                text: 'Privacy Policy',
                                style: AppTextStyle.styleFoodnote(
                                    textColor: AppColor.active, fontWeight: FontWeight.bold)),
                          ])),
                    ),
                    _itemSetting("Share your friends", icon: "assets/svg/icon_share.svg",onClick: () => _shareApp()),
                    _itemSetting("Tell us about the app", icon: "assets/svg/icon_star.svg"),
                    _itemSetting(
                      "Terms of Use ",
                    ),
                    _itemSetting(
                      "Privacy Policy",
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 8, 0, 16),
                      child: Text(
                        "You Made",
                        style: AppTextStyle.styleCallout(fontWeight: FontWeight.bold),
                      ),
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
          )
        ]));
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
      decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(12)),
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
                child: Container(
                  height: 32,
                  width: 32,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white),
                  alignment: Alignment.center,
                  child: SvgPicture.asset("assets/svg/icon_trash.svg"),
                ),
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

  _itemSetting(String text, {String? icon, Function? onClick}) {
    return Container(
      height: 48,
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
      decoration: BoxDecoration(
          color: AppColor.white94.withOpacity(0.94),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColor.neutral5)),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    text,
                    style: AppTextStyle.styleSubhead(textColor: AppColor.neutral1),
                  )),
                  icon != null ? SvgPicture.asset(icon) : const Icon(Icons.chevron_right)
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 0,
            child: InkWell(
              onTap: () => onClick!(),
            ),
          ),
        ],
      ),
    );
  }

  _shareApp() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: 'https://play.google.com/store/apps/details?id=ngaoschos.videodownloader',
        chooserTitle: 'Example Chooser Title'
    );
  }
}

class _UserInfo extends StatelessWidget {
  final String nameUser;
  final String email;
  final String image;
  final Function logOut;
  const _UserInfo({Key? key, required this.nameUser, required this.email, required this.image, required this.logOut}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      height: 80,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSmdD5MOPqlKV88ZFveMGxaa4WZWgZ2gn7Uer6YKOkPjM4R79vXISE0Agw9LXNIfom2o40&usqp=CAU",
              fit: BoxFit.cover,
              height: 56,
              width: 56,
            ),
          ),
          Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Text(
                  nameUser,
                  style: AppTextStyle.styleHeadline(textColor: AppColor.neutral1),
                ),
                Text(
                  email,
                  style: AppTextStyle.styleCaption1(textColor: AppColor.neutral2),
                ),
            ],
          ),
              )),
          GestureDetector(
            onTap: ()=> logOut(),
            child: SvgPicture.asset(
              "assets/svg/icon_log_out.svg",
            ),
          )
        ],
      ),
    );
  }
}
