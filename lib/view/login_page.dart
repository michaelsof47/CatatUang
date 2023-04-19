part of '../import_url_file.dart';

class LoginPage extends StatefulWidget {
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  //GENERAL VARIABLE
  FirebaseAuth? firebaseAuth;

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

  @override
  initState() {
    super.initState();

    initConstructor();
    initData();
  }

  initConstructor() {
    firebaseAuth = FirebaseAuth.instance;
  }

  initData() {}

  ///////////////////////////////////
  ///SOCIAL MEDIA ACCOUNT FUNCTION///
  ///////////////////////////////////

  Future<UserCredential> requestGoogleSignIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth!.accessToken,
      idToken: googleAuth.idToken,
    );

    return await firebaseAuth!.signInWithCredential(credential);
  }

  requestFacebookSignIn() async {
    var result = await FacebookAuth.instance.login(permissions: ['email','public_profile'],loginBehavior: LoginBehavior.katanaOnly);
    switch(result.status) {
      case LoginStatus.success:
        var profileData = await FacebookAuth.instance.getUserData(fields: "name,email");
        print("token: ${profileData.toString()}");
        break;
      case LoginStatus.cancelled:
        print("error: ${result.message}");
        break;
      case LoginStatus.failed:
        print("error: ${result.message}");
        break;
      case LoginStatus.operationInProgress:
        print("error: ${result.message}");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    //////////////////////
    ///CUSTOM COMPONENT///
    //////////////////////

    versionApps() => Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text("Version 0.0.1", style: GeneralStyle.versionLabel())],
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
          TextEditingController(),
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

    contentBtnAction(status, status1) => InkWell(
          onTap: () => (status1 == "facebook")
              ? requestFacebookSignIn()
              : requestGoogleSignIn(),
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

    socialMediaAccountBtnAction(status, {String? status1}) => Card(
          color: status1 == "facebook"
              ? ColorsTheme.facebookColor
              : ColorsTheme.googleColor,
          child: contentBtnAction("custom", status1),
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
            //btnLoginAction(),
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

    contentBody() => SafeArea(
          child: Scaffold(
              body: Padding(
            padding: GeneralUtils.allAroundPadding(11, 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                versionApps(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: contentForm(),
                ),
                versionApps(),
              ],
            ),
          )),
        );

    return Container(
      color: ColorsTheme.barStatusColor,
      child: contentBody(),
    );
  }
}
