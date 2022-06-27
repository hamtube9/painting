import 'package:background/utils/controller/background.dart';
import 'package:background/utils/controller/button_primary.dart';
import 'package:background/utils/navigation/navigation_page.dart';
import 'package:background/utils/styles/color_style.dart';
import 'package:background/utils/styles/text_style.dart';
import 'package:background/views/screens/main_screen.dart';
import 'package:flutter/material.dart';

class SubcriptionScreen extends StatefulWidget {
  const SubcriptionScreen({Key? key}) : super(key: key);

  @override
  State<SubcriptionScreen> createState() => _SubcriptionScreenState();
}

class _SubcriptionScreenState extends State<SubcriptionScreen> {
  late ScrollController controller;
  double _opacity = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = ScrollController();
    controller.addListener(onScroll);
  }

  onScroll() {
    var stt = MediaQuery.of(context).padding.top;
    var offset = controller.offset <= 0 ? 0 : controller.offset;
    var th = 100 - stt - 14;
    setState(() {
      _opacity = offset >= th ? 0 : (th - offset) / th;
    });
  }

  onScrollEnd() {
    if (_opacity < 1 && _opacity > 0) {
      if (controller.offset == 0) {
        return;
      }
      // Future.delayed(
      //     const Duration(milliseconds: 100),
      //     () => controller.animateTo(0.0,
      //         duration: Duration(milliseconds: 100), curve: Curves.easeIn));
      // controller.animateTo(0.0,
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(child: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollEndNotification) {
            onScrollEnd();
          }
          return true;
        },
        child: CustomScrollView(
          slivers: [_sliverAppBar(), _sliverContent()],
        ),
      ),),
    );
  }

  _sliverAppBar() {
    return SliverAppBar(
      shadowColor: Colors.transparent,
      backgroundColor: _opacity == 0 ? Colors.white70 : Colors.transparent,
      pinned: true,
      toolbarHeight: 48,
      expandedHeight: 300.0,
      flexibleSpace: Stack(
        children: [
          FlexibleSpaceBar(
            background: Image.network(
              'https://static.lag.vn/upload/news/22/04/07/spy-x-family-anya-forger-la-ai-1_UMOI.jpg?w=800&encoder=wic&subsampling=444',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
      leading: _textButton('Skip', () => _navigationMainScreen()),
      actions: [
        _textButton('Restore', () {}),
        _textButton('Terms', () {}),
        _textButton('Policy', () {}),
      ],
    );
  }

  _sliverContent() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              child: Center(
                child: Text(
                  "Pro Version - Unlimited",
                  style: AppTextStyle.styleTitle2(),
                ),
              ),
            ),
            const _ConditionItem(
                textCondition: "Unlimited – no limit on how many backgrounds removed per day"),
            const _ConditionItem(
              textCondition: "Bulk Background Removal feature ",
            ),
            const _ConditionItem(
              textCondition: "Add your own logo & watermark",
            ),
            const _ConditionItem(
              textCondition: "Add more backgrounds & effects",
            ),
            const _ConditionItem(
              textCondition: "Add directly to Socials & E-commerce",
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonPrimary(
                text: '3 DAY FREE TRIAD', onClick: () {}, width: MediaQuery.of(context).size.width),
            Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Then \$9.9 per week',
                  style: AppTextStyle.styleFoodnote(
                      textColor: Colors.black, fontWeight: FontWeight.w500),
                )),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
              child: Text(
                "Payment will be charged to iTunes Account at confirmation of purchase. Subscription automatically renewed unless auto-renew is turned off at least 24 - hours before the end of the current period. An account will be charged for renewal within 24 - hours prior to the end of the current period, and identify the cost of the renewal subscriptions may be managed by the user and auto-renewal may be turned off by going to the user's Account Setting after purchase.",
                style: AppTextStyle.styleCaption2(textColor: const Color(0xff788CA1)),
              ),
            )
          ],
        ),
      ),
    );
  }

  _textButton(String text, Function callback) {
    return TextButton(
        onPressed: () => callback(),
        child: Text(
          text,
          style: AppTextStyle.styleFoodnote(
              fontWeight: FontWeight.w500,
              textColor: _opacity <= 0.5 ? const Color(0xff788CA1) : AppColor.neutral1),
        ));
  }

  _navigationMainScreen(){
    Navigator.of(context).push(CustomPageNavigationBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => MainScreen()),
    );

  }
}

class _ConditionItem extends StatefulWidget {
  final String textCondition;

  const _ConditionItem({Key? key, required this.textCondition}) : super(key: key);

  @override
  State<_ConditionItem> createState() => _ConditionItemState();
}

class _ConditionItemState extends State<_ConditionItem> {
  bool isSelected = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
              activeColor: Colors.black,
              splashRadius: 1,
              value: isSelected,
              onChanged: (v) {
                setState(() {
                  isSelected = !isSelected;
                });
              }),
          Expanded(
              child: Container(
            margin: const EdgeInsets.fromLTRB(4, 16, 8, 4),
            child: Text(
              widget.textCondition,
              style: AppTextStyle.styleSubhead(),
            ),
          ))
        ],
      ),
    );
  }
}
