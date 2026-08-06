part of 'package:catat_uang/import_url_file.dart';

class SplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocalManager>(() => LocalManager());
    Get.lazyPut<LoginServiceInterfaces>(() => LoginService());

    Get.lazyPut<LoginController>(() => LoginController(
          firebaseAuth: FirebaseAuth.instance,
          localManager: Get.find<LocalManager>(),
          loginService: Get.find<LoginServiceInterfaces>(),
        ));
  }
}

class SplashScreenPage extends StatefulWidget {
  SplashScreenPageState createState() => SplashScreenPageState();
}

class SplashScreenPageState extends State<SplashScreenPage> {
  LoginController? loginController;

  @override
  initState() {
    super.initState();

    loginController = Get.find<LoginController>();

    initData();
  }

  initData() async {
    var condition = await loginController!.retrieveLoginStatusController();

    Timer(
      const Duration(seconds: 4),
      () async => await !condition
          ? Navigator.pushReplacementNamed(context, '/onboarding')
          : Get.offAllNamed('/home_navigation'),
    );
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
