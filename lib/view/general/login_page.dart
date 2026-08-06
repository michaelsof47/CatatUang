part of 'package:catat_uang/import_url_file.dart';

class LoginBinding implements Bindings {
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

class LoginPage extends StatefulWidget {
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  //Global Variable
  TextEditingController? emailphoneInputCtrl;
  TextEditingController? passwordInputCtrl;

  LoginController? controller;

  var isPasswordVisible;

  //Global Props
  showAlertSnackbar(String? label, bool? isSuccessful) =>
      ScaffoldMessenger.of(context).showSnackBar(GeneralUtils().alertSnackbar(
          label: label,
          color: isSuccessful! ? ColorsTheme.green : ColorsTheme.redSoft));

  Text? singleLabel(
      {String? label, int? size, String? isBold, bool? isSocMed}) {
    Color? labelColor = isSocMed! ? ColorsTheme.white : ColorsTheme.black;

    TextStyle? fontTheme = FontTheme.labelStyle1(
        status: isBold!, fontSize: size!, color: labelColor);

    return Text(label!, style: fontTheme);
  }

  viewLabel({String? type, bool? isRegisterAction, String? label}) =>
      Text(label!, style: FontTheme.registerAction(isRegisterAction!));

  moveIntoVerifyPage(verificationId) =>
      Navigator.pushNamed(context, '/verify_otp');

  validateForm() {
    FocusScope.of(context).unfocus();
    if (emailphoneInputCtrl!.text.isEmpty) {
      showAlertSnackbar("Masukkan Email / No.HP terlebih dahulu", false);
    } else if (passwordInputCtrl!.text.isEmpty) {
      showAlertSnackbar("Masukkan Password terlebih dahulu", false);
    } else {
      GeneralUtils().customProgressLoading(context);
      controller!.loginWithEmailPhoneCtrl(
          email: emailphoneInputCtrl!.text, password: passwordInputCtrl!.text);
    }
  }

  @override
  initState() {
    super.initState();

    initConstructor();
  }

  initConstructor() {
    emailphoneInputCtrl = TextEditingController();
    passwordInputCtrl = TextEditingController();

    controller = Get.find<LoginController>();

    isPasswordVisible = false.obs;
  }

  Widget? handlingError() {
    var alertStatus = "".obs;
    alertStatus.value = controller!.resultStatus.value;
    var alertMessage = controller!.resultMsg.value;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      switch (alertStatus.value) {
        case "success":
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, '/home_navigation');
          break;
        case "failure":
          Navigator.pop(context);
          showAlertSnackbar(alertMessage, false);
          break;
      }

      controller!.resetResponse();
    });

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    //kalkulasi untuk mengukur resolusi image background
    final double imageWidth = MediaQuery.of(context).size.width;
    final double aspectRatioValue =
        8.0.w / 8.4.h; // Nilai rasio numerik (lebar / tinggi)
    final double imageHeightCalculated = imageWidth / aspectRatioValue;

    inputFormField(hint, controller, isPassword) =>
        GeneralUtils().generalTextFormField(
          controller: controller,
          label: hint,
          isFinalInput: true,
          isEnabled: true,
          isNumber: false,
          isPassword: isPassword,
          decoType: "underline",
          onPasswordVisible: () {
            isPasswordVisible.value = !isPasswordVisible.value;
            print(isPasswordVisible.value);
          },
          isPasswordVisible: isPasswordVisible.value,
        );

    forgotPasswordLabelAction() => Padding(
          padding: EdgeInsets.only(right: 3.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {},
                child: singleLabel(
                    label: "Lupa Password",
                    size: 10,
                    isBold: "bold",
                    isSocMed: false),
              )
            ],
          ),
        );

    registerView() =>
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          viewLabel(
              type: "", isRegisterAction: false, label: "Tidak Punya Akun? "),
          InkWell(
            onTap: () => Navigator.pushNamed(context, "/register"),
            child: viewLabel(
                type: "", isRegisterAction: true, label: "Buat Akun Baru"),
          )
        ]);

    contentForm() => Container(
          color: ColorsTheme.white,
          child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 15.h, 20.w, 10.h),
              child: Column(children: [
                inputFormField("Email / No. Telp", emailphoneInputCtrl, false),
                GeneralUtils().verticalSpacer(10),
                inputFormField("Password", passwordInputCtrl, true),
                GeneralUtils().verticalSpacer(5),
                forgotPasswordLabelAction(),
                GeneralUtils().verticalSpacer(10),
                CustomLoginFormButtonWidget(
                    status: "general",
                    actionCallback: (status) => validateForm(),
                    label: "Login"),
                GeneralUtils().verticalSpacer(10),
                registerView(),
              ])),
        );

    customBody() => Stack(children: [
          Positioned(
            top: 0.h,
            right: 0.w,
            left: 0.w,
            height: imageHeightCalculated,
            child: Image.asset('assets/image/image_cover_2.png',
                fit: BoxFit.cover),
          ),
          Positioned(
            left: 0.w,
            right: 0.w,
            bottom: MediaQuery.of(context).viewInsets.bottom,
            child: AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left: 0.w,
              right: 0.w,
              bottom: MediaQuery.of(context).viewInsets.bottom,
              child: contentForm(),
            ),
          )
        ]);

    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: ColorsTheme.white,
            body: Obx(() => Stack(children: [
                  customBody(),
                  handlingError()!,
                ]))));
  }
}
