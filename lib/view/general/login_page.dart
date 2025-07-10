part of 'package:catat_uang/import_url_file.dart';

class LoginPage extends StatefulWidget {
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  //Global Variable
  TextEditingController? emailphoneInputCtrl;
  TextEditingController? passwordInputCtrl;

  LoginController? loginCtrl;

  var alertStatus;
  var isPasswordVisible;

  //Global Props
  showAlertSnackbar(String? label, bool? isSuccessful) =>
      ScaffoldMessenger.of(context).showSnackBar(
          GeneralUtils.alertSnackbar(label: label, color: isSuccessful! ? ColorsTheme.green : ColorsTheme.redSoft));

  customLogin() async {
    await loginCtrl!.storeLoginStatusController(true);
    //await loginCtrl!.storeDevelopmentRoleStatusController(roleStatusConfig);
    Navigator.pushReplacementNamed(context, '/home_navigation');
  }

  Text? singleLabel({String? label, int? size, bool? isBold, bool? isSocMed}) {
    Color? labelColor = isSocMed! ? ColorsTheme.white : ColorsTheme.black;

    TextStyle? fontTheme = FontTheme.labelStyle1(
        isBold: isBold, fontSize: size!, color: labelColor);

    return Text(label!, style: fontTheme);
  }

  viewLabel({String? type, bool? isRegisterAction, String? label}) =>
      Text(label!,
          style: FontTheme.registerAction(isRegisterAction!));

  @override
  initState() {
    super.initState();

    initConstructor();
  }

  initConstructor() {
    emailphoneInputCtrl = TextEditingController();
    passwordInputCtrl = TextEditingController();

    loginCtrl = Get.put(LoginController());
    isPasswordVisible = false.obs;
    alertStatus = "".obs;
  }

  moveIntoVerifyPage(verificationId) =>
      Navigator.pushNamed(context, '/verify_otp');

  /*registerBottomSheet() {
    contentText(isBold, desc) => TextSpan(
        text: desc,
        style: FontTheme.labelStyle1(
            isBold: isBold, fontSize: 18, color: ColorsTheme.black));

    itemRow1() => RichText(
            text: TextSpan(children: [
          contentText(false, "Pilih Akun Sesuai "),
          contentText(true, "Kebutuhan"),
        ]));

    itemOnClick(label) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              shape: LayoutTheme.allRoundedRect(radius: 10),
              color: ColorsTheme.facebookColor,
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    label == "WIRAUSAHA"
                        ? Navigator.pushNamed(context, "/owner_register")
                        : Navigator.pushNamed(context, "/register");
                  },
                  child: SizedBox(width: 71.w, height: 51.h)),
            ),
            SizedBox(height: 10.h),
            Text(
              label,
              style: FontTheme.labelStyle1(
                  isBold: false, fontSize: 14, color: ColorsTheme.black),
            )
          ],
        );

    itemRow2() => Padding(
          padding:
              EdgeInsets.only(left: 28.w, right: 28.w, top: 22.h, bottom: 20.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              itemOnClick("WIRAUSAHA"),
              itemOnClick("PERSONAL"),
            ],
          ),
        );

    contentBottomSheet() => Container(
          height: 215.h,
          padding:
              EdgeInsets.only(left: 10.w, right: 10.w, top: 15.h, bottom: 5.h),
          child: Column(
            children: [
              itemRow1(),
              itemRow2(),
              InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Text("Kembali ke Halaman Login",
                      style: FontTheme.labelStyle1(
                          isBold: true,
                          fontSize: 12,
                          color: ColorsTheme.black)))
            ],
          ),
        );

    return showModalBottomSheet(
      context: context,
      shape: LayoutTheme.allRoundedRect(radius: 10),
      builder: (context) => contentBottomSheet(),
      isDismissible: true,
      backgroundColor: ColorsTheme.yellowSoft,
    );
  }*/

  validateForm() {
    FocusScope.of(context).unfocus();
    if(emailphoneInputCtrl!.text.isEmpty) {
      showAlertSnackbar("Masukkan Email / No.HP terlebih dahulu", false);
    } else if (passwordInputCtrl!.text.isEmpty) {
      showAlertSnackbar("Masukkan Password terlebih dahulu", false);
    } else {
      GeneralUtils.customProgressLoading(context);
      loginCtrl!.requestEmailPhoneSignIn(email: emailphoneInputCtrl!.text, password: passwordInputCtrl!.text);
    }
  }

  Widget? handlingError() {
    alertStatus.value = loginCtrl!.resultStatus.value;
    var alertMessage = loginCtrl!.resultMsg.value;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      switch (alertStatus.value) {
        case "success":
          Navigator.pop(context);
          showAlertSnackbar(alertMessage, true);
          //Navigator.pushReplacementNamed(context, '/home_navigation');
          break;
        case "failure":
          Navigator.pop(context);
          showAlertSnackbar(alertMessage, false);
          break;
      }

      loginCtrl!.resetResponse();
    });

    return Container();
  }

  @override
  Widget build(BuildContext context) {

    //kalkulasi untuk mengukur resolusi image background
    final double imageWidth = MediaQuery.of(context).size.width;
    final double aspectRatioValue = 8.0.w / 8.4.h; // Nilai rasio numerik (lebar / tinggi)
    final double imageHeightCalculated = imageWidth / aspectRatioValue;


    inputFormField(hint, controller, isPassword) => GeneralUtils.generalTextFormField(
          controller: controller,
          label: hint,
          isFinalInput: true,
          isEnabled: true,
          isNumber: false,
          isPassword: isPassword,
          decoType: "underline",
          onPasswordVisible:() {
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
                    isBold: true,
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
          inputFormField("Email / No. Telp", emailphoneInputCtrl,false),
          GeneralUtils.verticalSpacer(10),
          inputFormField("Password", passwordInputCtrl,true),
          GeneralUtils.verticalSpacer(5),
          forgotPasswordLabelAction(),
          GeneralUtils.verticalSpacer(10),
          CustomLoginFormButtonWidget(
              status: "general", actionCallback: (status) => validateForm(), label: "Login"),
          GeneralUtils.verticalSpacer(10),
          registerView(),
        ])),
    );


    customBody() => Stack(
      children: [
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
      ]
    );

    return SafeArea(child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorsTheme.white,
      body: Obx(() => Stack(
        children: [
          customBody(),
          handlingError()!,
        ]
      ))));
  }
}
