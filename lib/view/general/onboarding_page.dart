part of 'package:catat_uang/import_url_file.dart';

LoginController? loginCtrl = Get.put(LoginController());

class OnBoardingPage extends StatefulWidget {
  State<OnBoardingPage> createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  //GENERAL UTILS
  TextEditingController? inputEditingController;
  MainConfig? config;

  //GENERAL VARIABLE
  var versionName;
  var roleStatusConfig;

  var alertStatus;

  ///GLOBAL PROPS///
  
  showAlertSnackbar(String? label, bool? isSuccessful) =>
    ScaffoldMessenger.of(context).showSnackBar(GeneralUtils.alertSnackbar(
        label: label,
        color: isSuccessful! ? ColorsTheme.green : ColorsTheme.redSoft));


  TextSpan? subtitleLabel({required String? label, required bool? isBold}) =>
      TextSpan(
        text: label,
        style: FontTheme.labelStyle1(
            isBold: isBold, fontSize: 15, color: ColorsTheme.barStatusColor),
      );

  @override
  initState() {
    super.initState();

    initConstructor();
    initData();
  }

  initConstructor() {
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

  onChangeRole() => setState(
        () => roleStatusConfig == "Personal"
            ? roleStatusConfig = "Owner"
            : roleStatusConfig = "Personal",
      );
  
  void navigationMenu({String? loginType}) async {
    switch (loginType) {
      case "custom":
        GeneralUtils.customProgressLoading(context);
        await loginCtrl!.requestGoogleSignIn();
        break;
      case "general":
        await Navigator.pushNamed(context, "/login");
        break;
    }
  }

  Widget? handlingError() {
    alertStatus.value = loginCtrl!.resultStatus.value;
    var alertMessage = loginCtrl!.resultMsg.value;
    var map = loginCtrl!.dataMap.value;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      switch (alertStatus.value) {
        case "success_login":
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, "/home_navigation");
          break;
        case "success_register":
          Navigator.pop(context);
          Navigator.pushNamed(context, "/register",arguments: map);
          break;
        case "failure_register":
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
    titleMenuContent() => Positioned(
        left: 30.w,
        right: 0.w,
        bottom: 370.h,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Image.asset('assets/image/menu_title.png'),
          GeneralUtils.verticalSpacer(10),
          RichText(
              text: TextSpan(
            children: [
              subtitleLabel(label: "Simpan Catatan", isBold: false)!,
              subtitleLabel(label: " Keuanganmu disini", isBold: true)!,
            ],
          ))
        ]));

    versioningContent() => Positioned(
          left: 16.w,
          right: 16.w,
          top: 16.h,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Version $versionName", style: FontTheme.versionLabel())
                ]),
            MainConfig.of(context).flavorIndicator == "cu_development"
                ? InkWell(
                    onTap: () => onChangeRole(),
                    child: Text(
                      "Role : $roleStatusConfig",
                      style: FontTheme.labelStyle1(
                          isBold: true, fontSize: 10, color: ColorsTheme.green),
                    ))
                : Container(),
          ]),
        );

    actionMenuContent() => Positioned(
        left: 0.w,
        right: 0.w,
        bottom: 24.h,
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GeneralUtils.verticalSpacer(55),
              CustomLoginFormButtonWidget(
                  status: "general",
                  actionCallback: (status) => navigationMenu(loginType: status),
                  label: "Login dengan Email / Telp"),
              GeneralUtils.verticalSpacer(14),
              Center(
                child: Text("Atau",
                    style: FontTheme.labelStyle1(
                        isBold: false, fontSize: 12, color: ColorsTheme.black)),
              ),
              GeneralUtils.verticalSpacer(14),
              CustomLoginFormButtonWidget(
                  status: "custom",
                  actionCallback: (status) =>
                      navigationMenu(loginType: status)),
            ],
          ),
        ));

    contentWrapBody() => Stack(children: [
          Positioned.fill(
            child:
                Image.asset("assets/image/image_cover.png", fit: BoxFit.cover),
          ),
          Positioned.fill(
              child: Container(color: ColorsTheme.grey.withOpacity(0.6))),
          Stack(children: [
            versioningContent(),
            titleMenuContent(),
            actionMenuContent(),
          ]),
          handlingError()!,
        ]);

    return SafeArea(child: Scaffold(body: Obx(() => contentWrapBody())));
  }
}
