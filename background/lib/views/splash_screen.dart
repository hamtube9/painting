import 'package:background/utils/controller/button_primary.dart';
import 'package:background/utils/styles/color_style.dart';
import 'package:background/utils/styles/text_style.dart';
import 'package:background/views/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.all(16),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      'assets/svg/logo.svg',
                      fit: BoxFit.cover,
                    )),
                Text(
                  'www.Zhoot.io/list',
                  style: AppTextStyle.styleCaption1(),
                ),
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.fromLTRB(48,0,48,0),
                  child: Text('Easiest to make Awesome Listing ',
                      style: AppTextStyle.styleTitle2().copyWith(color:  AppColor.neutralLight1,height: 1.5),
                      textAlign: TextAlign.center,
                  ),
                )
              ],
            )),
            ButtonPrimary(
              width: MediaQuery.of(context).size.width,
              onClick: () => _navigateOnboarding(),
              text: 'START RIGHT HERE',
            )
          ],
        ),
      ),
    );
  }

  _navigateToTutorial() {}

  _navigateOnboarding() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const OnboardingScreen(),));
  }
}
