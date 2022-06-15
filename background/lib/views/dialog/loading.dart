import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingView extends StatefulWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  State<LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> with SingleTickerProviderStateMixin {
  late SpinKitCubeGrid spinkit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    spinkit = SpinKitCubeGrid(
      color: Colors.white,
      size: 50.0,
      controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    spinkit.controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(child:spinkit);
  }
}
