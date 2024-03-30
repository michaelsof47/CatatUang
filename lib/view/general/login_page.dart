part of 'package:catat_uang/import_url_file.dart';

LoginController? loginCtrl = Get.put(LoginController());

class LoginPage extends StatefulWidget {
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  //GENERAL UTILS
  TextEditingController? inputEditingController;
  MainConfig? config;

  //GENERAL VARIABLE
  var versionName;
  var roleStatusConfig;

  var alertStatus;

  Color? palleteButtonColor({String? type}) {
    switch (type) {
      case "facebook":
        return ColorsTheme.facebookColor;
      case "google":
        return ColorsTheme.googleColor;
      case "phonenumber":
        return ColorsTheme.yellow;
    }
    ;
  }

  //////////////////
  ///CUSTOM UTILS///
  //////////////////
  TextSpan? subtitleLabel({required String? label, required bool? isBold}) =>
      TextSpan(
        text: label,
        style: FontTheme.labelStyle1(
            isBold: isBold, fontSize: 15, color: ColorsTheme.barStatusColor),
      );

  Text? singleLabel({String? label, int? size, bool? isBold, bool? isSocMed}) {
    Color? labelColor = isSocMed! ? ColorsTheme.white : ColorsTheme.black;

    TextStyle? fontTheme = FontTheme.labelStyle1(
        isBold: isBold, fontSize: size!, color: labelColor);

    return Text(label!, style: fontTheme);
  }

  showAlertSnackbar({required String? label}) =>
      ScaffoldMessenger.of(context).showSnackBar(
          GeneralUtils.alertSnackbar(label: label, color: ColorsTheme.redSoft));

  ///////////////////
  ///CUSTOM WIDGET///
  ///////////////////

  customLogin() async {
    await loginCtrl!.storeLoginStatusController(true);
    await loginCtrl!.storeDevelopmentRoleStatusController(roleStatusConfig);
    Navigator.pushReplacementNamed(context, '/home_navigation');
  }

  navigationButtonComponent(status, status1, {String? verificationId}) {
    double? paddingWidth = status != "custom" ? 11 : 5;
    String? socialmedLabel = status1 == "facebook" ? 'Facebook' : 'Google';
    String? socialMedIcon = status1 == "facebook"
        ? 'assets/image/facebook_logo.png'
        : 'assets/image/google_logo.png';

    childLabelContent({String? label, bool? isSocMed}) =>
        singleLabel(label: label, size: 14, isBold: true, isSocMed: true);

    brandingLogo() => Image.asset(socialMedIcon,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
        width: 38.w,
        height: 35.h);

    socialmedContent() => Row(children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(5.r), child: brandingLogo()),
          GeneralUtils.horizontalSpacer(5),
          childLabelContent(
              label: "Masuk Dengan $socialmedLabel", isSocMed: true)!
        ]);

    generalContent() =>
        Center(child: childLabelContent(label: "Login", isSocMed: true));

    buttonContent() => Container(
          width: ScreenUtil().screenWidth,
          height: 39.h,
          padding: GeneralUtils.allAroundPadding(paddingWidth, 0),
          child: status == "custom" ? socialmedContent() : generalContent(),
        );

    return Card(
        color: palleteButtonColor(type: status1),
        child: InkWell(
            onTap: () => navigationMenu(loginType: status1),
            borderRadius: BorderRadius.circular(5.r),
            child: buttonContent()));
  }

  @override
  initState() {
    super.initState();

    initConstructor();
    initData();
  }

  initConstructor() async {
    inputEditingController = TextEditingController();
    //config = MainConfig.of(context);

    versionName = "";
    roleStatusConfig = "Personal";

    alertStatus = "".obs;
  }

  retrieveVersion() =>
      PackageInfo.fromPlatform().then((PackageInfo packageInfo) =>
          setState(() => versionName = packageInfo.version));

  initData() {
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => retrieveVersion());
  }

  ///////////////////////////////////
  ///SOCIAL MEDIA ACCOUNT FUNCTION///
  ///////////////////////////////////

  moveIntoVerifyPage(verificationId) =>
      Navigator.pushNamed(context, '/verify_otp');

  registerBottomSheet() {
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
  }

  Widget? handlingError() {
    alertStatus.value = loginCtrl!.resultStatus.value;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      switch (alertStatus.value) {
        case "success":
          Navigator.pushReplacementNamed(context, '/home_navigation');
          break;
        case "failure":
          showAlertSnackbar(label: loginCtrl!.resultMsg.value);
          break;
      }

      loginCtrl!.resetResponse();
    });

    return Container();
  }

  void navigationMenu({String? loginType}) async {
    switch (loginType) {
      case "facebook":
        await loginCtrl!.requestFacebookSignIn();
        break;
      case "google":
        await loginCtrl!.requestGoogleSignIn();
        break;
      case "phone_number":
        var phonenumber = inputEditingController!.text.replaceRange(0, 1, '');
        await loginCtrl!.requestEmailPhoneSignIn(phonenumber: phonenumber);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    ///////////////////////////
    ///CUSTOM VIEW COMPONENT///
    ///////////////////////////

    viewLabel({String? type, bool? isRegisterAction, String? label}) => Text(
        label!,
        style: type == "version"
            ? FontTheme.versionLabel()
            : FontTheme.registerAction(isRegisterAction!));

    versionApps() => Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [viewLabel(type: "version", label: "Version $versionName")],
        );

    registerView() =>
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          viewLabel(
              type: "", isRegisterAction: false, label: "Tidak Punya Akun? "),
          InkWell(
            onTap: () => registerBottomSheet(),
            child: viewLabel(
                type: "", isRegisterAction: true, label: "Buat Akun Baru"),
          )
        ]);

    headerLabel() => Column(
          children: [
            Center(child: Image.asset('assets/image/menu_title.png')),
            GeneralUtils.verticalSpacer(10),
            RichText(
              text: TextSpan(
                children: [
                  subtitleLabel(label: "Simpan Catatan", isBold: false)!,
                  subtitleLabel(label: " Keuanganmu disini", isBold: true)!,
                ],
              ),
            )
          ],
        );

    //////////////////////////////
    ///INPUT & ACTION COMPONENT///
    //////////////////////////////

    inputFormField() => GeneralUtils.generalTextFormField(
          controller: inputEditingController,
          label: "Email / No. Telp",
          isFinalInput: true,
          isEnabled: true,
          isNumber: false,
          decoType: "underline",
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

    ///////////////////////////////////////////
    ///SOCIAL MEDIA ACCOUNT ACTION COMPONENT///
    ///////////////////////////////////////////

    ////////////////////
    ///BASE COMPONENT///
    ////////////////////

    contentForm() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerLabel(),
            GeneralUtils.verticalSpacer(35),
            inputFormField(),
            GeneralUtils.verticalSpacer(8),
            forgotPasswordLabelAction(),
            GeneralUtils.verticalSpacer(55),
            navigationButtonComponent("basic", "phonenumber"),
            GeneralUtils.verticalSpacer(14),
            Center(
                child: singleLabel(
                    label: "Atau", size: 12, isBold: false, isSocMed: false)!),
            GeneralUtils.verticalSpacer(14),
            navigationButtonComponent("custom", "facebook"),
            GeneralUtils.verticalSpacer(5),
            navigationButtonComponent("custom", "google"),
          ],
        );

    itemContent() =>
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          versionApps(),
          MainConfig.of(context).flavorIndicator == "cu_development"
              ? InkWell(
                  onTap: () => setState(
                    () => roleStatusConfig == "Personal"
                        ? roleStatusConfig = "Owner"
                        : roleStatusConfig = "Personal",
                  ),
                  child: Text(
                    "Role : $roleStatusConfig",
                    style: FontTheme.labelStyle1(
                        isBold: true, fontSize: 10, color: ColorsTheme.green),
                  ),
                )
              : Container(),
        ]);

    baseContent() => Column(children: [
          itemContent(),
          GeneralUtils.verticalSpacer(60),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: contentForm()),
          GeneralUtils.verticalSpacer(40),
          registerView()
        ]);

    contentWrapBody() => Obx(() => Stack(children: [
          Padding(
            padding: GeneralUtils.allAroundPadding(15, 18),
            child: Wrap(children: [baseContent()]),
          ),
          handlingError()!
        ]));

    return SafeArea(child: Scaffold(body: contentWrapBody()));
  }
}
