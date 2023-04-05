import 'package:flutter/material.dart';

class SplashScreenPage extends StatefulWidget {
  SplashScreenPageState createState() => SplashScreenPageState();
}

class SplashScreenPageState extends State<SplashScreenPage> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    contentBody() => const SafeArea(
          child: Scaffold(
            body: Text("Tester"),
          ),
        );

    return Container(
      color: Colors.amber,
      child: contentBody(),
    );
  }
}
