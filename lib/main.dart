import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'import_url_file.dart';

void main() {
  runApp(const MyApp());
}

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
            });

    return ScreenUtilInit(
      designSize: Size(360, 640),
      builder: (context, Widget) => materialApp(),
      minTextAdapt: true,
    );
  }
}
