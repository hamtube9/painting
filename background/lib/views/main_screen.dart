import 'package:background/blocs/edit/edit_bloc.dart';
import 'package:background/blocs/edit/edit_provider.dart';
import 'package:background/blocs/remove_background/remove_background_bloc.dart';
import 'package:background/blocs/remove_background/remove_background_provider.dart';
import 'package:background/model/local_image.dart';
import 'package:background/services/pick_image_services.dart';
import 'package:background/utils/navigation/navigation_page.dart';
import 'package:background/utils/styles/color_style.dart';
import 'package:background/views/edit_image_screen.dart';
import 'package:background/views/remove_background_screen.dart';
import 'package:background/views/settings_view.dart';
import 'package:background/views/template_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.neutral5.withOpacity(0.4),
      body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: const [TemplateScreen(), SettingsScreen()]),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: Row(
          children: [
            Expanded(
                child: GestureDetector(
              onTap: () => animatePage(0),
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/svg/ic_group.svg',
                  height: 24,
                  width: 24,
                ),
              ),
            )),
            Expanded(
                child: Center(
              child: GestureDetector(
                onTap: () => _pickImage(),
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
                child: GestureDetector(
                    onTap: () => animatePage(1),
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        'assets/svg/ic_settings.svg',
                        height: 24,
                        width: 24,
                      ),
                    ))),
          ],
        ),
      ),
    );
  }

  animatePage(int page) {
    if (_pageController.page == page) {
      return;
    } else {
      _pageController.animateToPage(page,
          duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    }
  }

  void navigateToEdit(LocalImage image) async {
    Navigator.of(context).push(
      CustomPageNavigationBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => RemoveBackgroundProvider(
                bloc: RemoveBackgroundBloc(),
                child: RemoveBackgroundScreen(
                  image: image,
                ),
              )),
    );
  }

  _pickImage() async {
    var image = await PickImageService.pickImage(context);
    if (image == null) {
      return;
    }
    navigateToEdit(image);
  }
}
