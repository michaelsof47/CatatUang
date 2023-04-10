part of '../import_url_file.dart';

class SplashScreenPage extends StatefulWidget {
  SplashScreenPageState createState() => SplashScreenPageState();
}

class SplashScreenPageState extends State<SplashScreenPage> {
  @override
  initState() {
    super.initState();

    Timer(const Duration(seconds: 4),
        () => Navigator.pushReplacementNamed(context, '/login'));
  }

  @override
  Widget build(BuildContext context) {
    contentBody() => SafeArea(
          child: Scaffold(
            body: Center(child: Image.asset('assets/image/menu_title.png')),
          ),
        );

    return Container(
      color: ColorsTheme.barStatusColor,
      child: contentBody(),
    );
  }
}
