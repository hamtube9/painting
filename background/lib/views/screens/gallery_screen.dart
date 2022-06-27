import 'package:background/blocs/edit/edit_bloc.dart';
import 'package:background/blocs/edit/edit_provider.dart';
import 'package:background/main.dart';
import 'package:background/utils/controller/background.dart';
import 'package:background/utils/navigation/navigation_page.dart';
import 'package:background/utils/styles/color_style.dart';
import 'package:background/utils/styles/text_style.dart';
import 'package:background/views/screens/edit_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GalleryScreen extends StatefulWidget {
  final bool isBlackFriday;

  const GalleryScreen({Key? key, this.isBlackFriday = false}) : super(key: key);

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text("Minimalist Store", style: AppTextStyle.styleSubhead()),
        leading: IconButton(
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.black,
              size: 24,
            ),
            onPressed: () => onBackPress(context)),
      ),
      body: Background(child: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
            childAspectRatio: widget.isBlackFriday ? 0.5 : 1,
            crossAxisCount: 2,
            shrinkWrap: true,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            children: List.generate(10, (index) => _itemImage(index))),
      ),),
    );
  }

  _itemImage(int index) {
    return Container(
      color: const Color(0xffE1E9F3),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 0,
            child: Center(
              child: SvgPicture.asset(
                'assets/svg/hand_bag.svg',
              ),
            ),
          ),
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24), color: const Color(0xff6F90B4)),
              child: Text(
                'Pro',
                style: AppTextStyle.styleCaption2(textColor: Colors.white),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 0,
            child: InkWell(
              onTap: () => _navigationItem(),
            ),
          )
        ],
      ),
    );
  }

  _navigationItem() {
    Navigator.of(context).push(
      CustomPageNavigationBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => EditProvider(bloc: EditBloc(),child: EditImageScreen(isBlackFriday: widget.isBlackFriday,),)),
    );
  }
}
