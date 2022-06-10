import 'package:background/main.dart';
import 'package:background/services/pick_image_services.dart';
import 'package:background/utils/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditImageScreen extends StatefulWidget {
  const EditImageScreen({Key? key}) : super(key: key);

  @override
  State<EditImageScreen> createState() => _EditImageScreenState();
}

class _EditImageScreenState extends State<EditImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => onBackPress(context),
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
        ),
        actions: [
          TextButton.icon(
              onPressed: () {},
              icon: SvgPicture.asset(
                "assets/svg/ic_turn_left.svg",
                color: Colors.black,
              ),
              label: Container()),
          TextButton.icon(
              onPressed: () {},
              icon: SvgPicture.asset(
                "assets/svg/ic_turn_right.svg",
                color: Colors.black,
              ),
              label: Container()),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 8, 16, 8),
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 0.5), color: Colors.black),
            alignment: Alignment.center,
            child: Text(
              "SHARE",
              style:
                  AppTextStyle.styleCaption1(fontWeight: FontWeight.w600, textColor: Colors.white),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 80,
        child: Row(
          children: [
            Expanded(child: _itemEdit("assets/svg/edit1.svg", () {
            })),
            Expanded(child: _itemEdit("assets/svg/edit2.svg", () {})),
            Expanded(child: _itemEdit("assets/svg/edit3.svg", () => _openLocalImage())),
            Expanded(child: _itemEdit("assets/svg/edit4.svg", () {})),
            Expanded(child: _itemEdit("assets/svg/edit5.svg", () {})),
          ],
        ),
      ),
    );
  }

  _itemEdit(String img, Function itemClick){
    return Center(
      child: InkWell(
        onTap: () => itemClick(),
        child: Container(
          height: 48,
          width: 48,
          decoration: const BoxDecoration(color: Colors.black),
          alignment: Alignment.center,
          child: SvgPicture.asset(img),
        ),
      ),
    );
  }

  _openLocalImage() {
    PickImageService.pickImage(context);
  }
}
