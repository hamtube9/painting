import 'package:background/injection.dart';
import 'package:background/utils/styles/theme.dart';
import 'package:background/views/dialog/loading.dart';
import 'package:background/views/screens/splash_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  configureDependencies();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(
    DevicePreview(
      enabled: kDebugMode,
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemesUtils.configStatusbar();
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      builder: (context, myWidget) {
        // myWidget = EasyLoading.init()(context, myWidget);
        myWidget = DevicePreview.appBuilder(context, myWidget);
        return myWidget;
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}


void onBackPress(context,{dynamic result}){
  Navigator.of(context).pop(result);
}

BuildContext? dialogContext;
showLoading(context){
  showDialog(
    context: context,
    barrierDismissible: false,
    useSafeArea: false,
    builder: (BuildContext context) {
      dialogContext = context;
      return const LoadingView();
    },
  );
}

hideLoading(){
  if(dialogContext != null){
    Navigator.pop(dialogContext!);
  }
}
