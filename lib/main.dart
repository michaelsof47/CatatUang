import 'package:catat_uang/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'import_url_file.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    materialApp() => MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            debugShowCheckedModeBanner: false,
            routes: {
              '/': (context) => SplashScreenPage(),
              '/login': (context) => LoginPage(),
              '/register': (context) => RegisterUserPage(),
              '/verify_otp': (context) => VerifyOTPPage(),
              '/home_navigation': (context) => HomeNavigationPage(),
              '/owner_register': (context) => OwnerRegisterPage(),
            });

    return ScreenUtilInit(
      designSize: Size(360, 640),
      builder: (context, Widget) => materialApp(),
      minTextAdapt: true,
    );
  }
}
