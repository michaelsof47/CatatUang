part of '../import_url_file.dart';

class LoginPage extends StatefulWidget {
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  //////////////////
  ///CUSTOM LABEL///
  //////////////////
  customLabelSpan(label, isBold) => TextSpan(
        text: label,
        style: GeneralStyle.labelStyle1(isBold, 15),
      );

  customLabel(label, size) => Text(
        label,
        style: GeneralStyle.labelStyle1(true, size),
      );

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
                  customLabelSpan("Simpan Catatan", false),
                  customLabelSpan(" Keuanganmu disini", true),
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
                child: customLabel("Lupa Password", 10),
              )
            ],
          ),
        );

    btnLoginAction() => Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.r),
          ),
          color: ColorsTheme.yellow,
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(5.r),
            child: Container(
              width: ScreenUtil().screenWidth,
              padding: GeneralUtils.allAroundPadding(11, 0),
              child: Center(child: customLabel("Login", 14)),
            ),
          ),
        );

    contentForm() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerLabel(),
            GeneralUtils.verticalSpacer(20),
            inputFormField(),
            GeneralUtils.verticalSpacer(8),
            forgotPasswordLabelAction(),
            GeneralUtils.verticalSpacer(8),
            btnLoginAction(),
          ],
        );

    ////////////////////
    ///BASE COMPONENT///
    ////////////////////

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
