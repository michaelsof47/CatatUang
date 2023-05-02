part of 'package:catat_uang/import_url_file.dart';

class LoginPage extends ConsumerStatefulWidget {
  ConsumerState<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends ConsumerState<LoginPage> {
  //GENERAL VARIABLE
  FirebaseAuth? firebaseAuth;
  TextEditingController? inputEditingController;
  TextEditingController? verifyOTPPhoneNumberController;

  var versionName;

  //////////////////
  ///CUSTOM UTILS///
  //////////////////
  customLabelSpan(label, isBold, color) => TextSpan(
        text: label,
        style: GeneralStyle.labelStyle1(isBold, 15, color),
      );

  customLabel(label, size, isBold, color) => Text(
        label,
        style: GeneralStyle.labelStyle1(isBold, size, color),
      );

  brandingLogo(status) => ClipRRect(
        borderRadius: BorderRadius.circular(5.r),
        child: Image.asset(
          status == "facebook"
              ? 'assets/image/facebook_logo.png'
              : 'assets/image/google_logo.png',
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
          width: 38.w,
          height: 35.h,
        ),
      );

  decorationBox(
          {double? topLeft,
          double? topRight,
          double? bottomLeft,
          double? bottomRight}) =>
      RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeft!.r),
          topRight: Radius.circular(topRight!.r),
          bottomLeft: Radius.circular(bottomLeft!.r),
          bottomRight: Radius.circular(bottomRight!.r),
        ),
      );

  showAlertSnackbar(label) => ScaffoldMessenger.of(context).showSnackBar(
        GeneralUtils.alertSnackbar(label),
      );

  ///////////////////
  ///CUSTOM WIDGET///
  ///////////////////

  socialMediaAccContent(status) => Row(
        children: [
          brandingLogo(status),
          GeneralUtils.horizontalSpacer(5),
          customLabel(
            "Masuk Dengan ${status == "facebook" ? 'Facebook' : 'Google'}",
            14,
            true,
            ColorsTheme.white,
          )
        ],
      );

  contentBtnAction(status, status1, {String? verificationId}) => InkWell(
        onTap: () => status1 == "facebook"
            ? requestFacebookSignIn()
            : status1 == "google"
                ? requestGoogleSignIn()
                : Navigator.pushNamed(
                    context, '/home_navigation'), //: requestEmailPhoneSignIn(),
        borderRadius: BorderRadius.circular(5.r),
        child: Container(
          width: ScreenUtil().screenWidth,
          height: 39.h,
          padding: status != "custom"
              ? GeneralUtils.allAroundPadding(11, 0)
              : GeneralUtils.allAroundPadding(5, 0),
          child: status == "custom"
              ? socialMediaAccContent(status1)
              : Center(
                  child: customLabel("Login", 14, true, ColorsTheme.black),
                ),
        ),
      );

  @override
  initState() {
    super.initState();

    initConstructor();
    initData();
  }

  initConstructor() async {
    firebaseAuth = FirebaseAuth.instance;
    inputEditingController = TextEditingController();
    verifyOTPPhoneNumberController = TextEditingController();

    versionName = "";
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

  Future<UserCredential> requestGoogleSignIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    try {
      final GoogleSignInAuthentication? googleAuth =
          await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth!.accessToken,
        idToken: googleAuth.idToken,
      );

      return await firebaseAuth!.signInWithCredential(credential);
    } catch (e) {
      return showAlertSnackbar(e);
    }
  }

  requestFacebookSignIn() async {
    var result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
        loginBehavior: LoginBehavior.katanaOnly);
    switch (result.status) {
      case LoginStatus.success:
        var profileData =
            await FacebookAuth.instance.getUserData(fields: "name,email");
        //print("token: ${profileData.toString()}");
        break;
      case LoginStatus.cancelled:
        showAlertSnackbar(result.message);
        break;
      case LoginStatus.failed:
        showAlertSnackbar(result.message);
        break;
      case LoginStatus.operationInProgress:
        showAlertSnackbar(result.message);
        break;
    }
  }

  moveIntoVerifyPage(verificationId) {
    ref.read(_verificationCode.notifier).update((state) => verificationId);
    Navigator.pushNamed(context, '/verify_otp');
  }

  requestEmailPhoneSignIn() async =>
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber:
            '+62 ${inputEditingController!.text.replaceRange(0, 1, '')}',
        verificationCompleted: (credential) =>
            print("kode sms: ${credential.smsCode}"),
        verificationFailed: (e) => showAlertSnackbar(e),
        codeSent: (verificationId, resendToken) =>
            moveIntoVerifyPage(verificationId),
        codeAutoRetrievalTimeout: (verificationId) => {},
      );

  registerBottomSheet() {
    contentText(isBold, desc) => TextSpan(
          text: desc,
          style: GeneralStyle.labelStyle1(isBold, 18, ColorsTheme.black),
        );

    itemRow1() => RichText(
            text: TextSpan(children: [
          contentText(false, "Pilih Akun Sesuai "),
          contentText(true, "Kebutuhan"),
        ]));

    itemOnClick(label) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              shape: decorationBox(
                  topLeft: 10.0,
                  topRight: 10.0,
                  bottomLeft: 10.0,
                  bottomRight: 10.0),
              color: ColorsTheme.facebookColor,
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    label == "WIRAUSAHA"
                        ? {}
                        : Navigator.pushNamed(context, "/register");
                  },
                  child: SizedBox(width: 71.w, height: 51.h)),
            ),
            SizedBox(height: 10.h),
            Text(
              label,
              style: GeneralStyle.labelStyle1(false, 14, ColorsTheme.black),
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
                      style: GeneralStyle.labelStyle1(
                          true, 12, ColorsTheme.black)))
            ],
          ),
        );

    return showModalBottomSheet(
      context: context,
      shape: decorationBox(
        topLeft: 10.0,
        topRight: 10.0,
        bottomLeft: 0,
        bottomRight: 0,
      ),
      builder: (context) => contentBottomSheet(),
      isDismissible: true,
      backgroundColor: ColorsTheme.yellowSoft,
    );
  }

  @override
  Widget build(BuildContext context) {
    //////////////////////
    ///CUSTOM COMPONENT///
    //////////////////////

    versionApps() => Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Version $versionName", style: GeneralStyle.versionLabel())
          ],
        );

    registerView() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Tidak Punya Akun? ",
              style: GeneralStyle.registerAction(false),
            ),
            InkWell(
              onTap: () => registerBottomSheet(),
              child: Text(
                "Buat Akun Baru",
                style: GeneralStyle.registerAction(true),
              ),
            )
          ],
        );

    headerLabel() => Column(
          children: [
            Center(child: Image.asset('assets/image/menu_title.png')),
            GeneralUtils.verticalSpacer(10),
            RichText(
              text: TextSpan(
                children: [
                  customLabelSpan(
                      "Simpan Catatan", false, ColorsTheme.barStatusColor),
                  customLabelSpan(
                      " Keuanganmu disini", true, ColorsTheme.barStatusColor),
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
        );

    forgotPasswordLabelAction() => Padding(
          padding: EdgeInsets.only(right: 3.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {},
                child:
                    customLabel("Lupa Password", 10, true, ColorsTheme.black),
              )
            ],
          ),
        );

    ///////////////////////////////////////////
    ///SOCIAL MEDIA ACCOUNT ACTION COMPONENT///
    ///////////////////////////////////////////

    socialMediaAccountBtnAction(status, {String? status1}) => Card(
          color: status1 == "facebook"
              ? ColorsTheme.facebookColor
              : status1 == "google"
                  ? ColorsTheme.googleColor
                  : ColorsTheme.yellow,
          child: contentBtnAction(status, status1),
        );

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
            socialMediaAccountBtnAction("basic", status1: ""),
            GeneralUtils.verticalSpacer(14),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [customLabel("Atau", 12, false, ColorsTheme.black)],
            ),
            GeneralUtils.verticalSpacer(14),
            socialMediaAccountBtnAction("custom", status1: "facebook"),
            GeneralUtils.verticalSpacer(5),
            socialMediaAccountBtnAction("custom", status1: "google"),
          ],
        );

    contentWrapBody() => Wrap(
          children: [
            Column(
              children: [
                versionApps(),
                GeneralUtils.verticalSpacer(60),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: contentForm(),
                ),
                GeneralUtils.verticalSpacer(40),
                registerView(),
              ],
            ),
          ],
        );

    contentBody() => SafeArea(
          child: Scaffold(
              body: Padding(
            padding: GeneralUtils.allAroundPadding(15, 18),
            child: contentWrapBody(),
          )),
        );

    return Container(
      color: ColorsTheme.barStatusColor,
      child: contentBody(),
    );
  }
}

//deprecated

/*showVerificationBottomSheet({String? verificationId}) {
    contentText(isBold, desc) => TextSpan(
          text: desc,
          style: GeneralStyle.labelStyle1(isBold, 18, ColorsTheme.black),
        );

    itemRow1() => RichText(
            text: TextSpan(children: [
          contentText(false, "Verifikasi "),
          contentText(true, "Kode OTP"),
        ]));

    inputFormField() => GeneralUtils.generalTextFormField(
          controller: verifyOTPPhoneNumberController,
          label: "Masukkan Kode OTP dari SMS yang anda terima.",
        );

    verifyBtn() => Card(
          color: ColorsTheme.yellow,
          child: contentBtnAction(
            "basic",
            "verify_otp",
            verificationId: verificationId,
          ),
        );

    contentBottomSheet() => Container(
          height: 215.h,
          padding:
              EdgeInsets.only(left: 10.w, right: 10.w, top: 15.h, bottom: 5.h),
          child: Column(
            children: [
              itemRow1(),
              inputFormField(),
              SizedBox(height: 10.h),
              verifyBtn(),
            ],
          ),
        );

    return showModalBottomSheet(
      context: context,
      shape: decorationBox(
        topLeft: 10.0,
        topRight: 10.0,
        bottomLeft: 0,
        bottomRight: 0,
      ),
      builder: (context) => contentBottomSheet(),
      isDismissible: true,
      backgroundColor: ColorsTheme.yellowSoft,
    );
  }*/

