part of 'package:catat_uang/import_url_file.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocalManager>(() => LocalManager());
    Get.lazyPut<DashboardServiceInterface>(() => DashboardService());

    Get.lazyPut<DashboardController>(() => DashboardController(
          localManager: Get.find<LocalManager>(),
          dashboardService: Get.find<DashboardServiceInterface>(),
        ));
  }
}

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  List<String>? menuLabelList;
  List<IconData>? menuIconList;

  DashboardController? controller;

  var fullName;
  var rewardStatus;
  var isLoading;
  var profileImage;
  RxMap<String, dynamic>? temporaryMap;

  showAlertSnackbar(String? label, bool? isSuccessful) =>
      ScaffoldMessenger.of(context).showSnackBar(GeneralUtils().alertSnackbar(
          label: label,
          color: isSuccessful! ? ColorsTheme.green : ColorsTheme.redSoft));

  @override
  void initState() {
    super.initState();

    initConstructor();
    initData();
  }

  @override
  void dispose() {
    super.dispose();

    //Get.delete<DashboardController>();
  }

  initConstructor() {
    menuLabelList = [
      "Pengaturan",
      "Pengingat Otomatis",
      "Kebijakan Privasi",
      "Pusat Bantuan",
      "Saran dan Masukkan",
      "Keluar"
    ];

    menuIconList = [
      Icons.settings,
      Icons.alarm,
      Icons.security,
      Icons.help,
      Icons.message,
      Icons.logout,
    ];

    controller = Get.find<DashboardController>();

    fullName = "".obs;
    rewardStatus = "".obs;
    isLoading = true.obs;
    temporaryMap = <String, dynamic>{}.obs;
    profileImage = Uint8List(0).obs;
  }

  initData() async {
    isLoading.value = true;
    await controller!.getDashboardDataCtrl(false);
  }

  logout() async {
    GeneralUtils().customAlertDialog(
        context, "Apakah Anda Yakin Untuk Keluar ?", () async {
      Navigator.pop(context);
      GeneralUtils().customProgressLoading(context);
      await controller!.logoutCtrl();
    });
  }

  Widget? handlingError() {
    var alertStatus = "".obs;
    alertStatus.value = controller!.resultStatus.value;
    var alertMessage = controller!.resultMsg.value;
    var dataMap = controller!.dashboardData!;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      switch (alertStatus.value) {
        case "jwt_expired":
          showAlertSnackbar(alertMessage, false);
          controller!.resetAccountCtrl();
          Navigator.pushReplacementNamed(context, "/onboarding");
          break;
        case "dashboard_failure":
          showAlertSnackbar(alertMessage, false);
          break;
        case "dashboard_success":
          AccountModel accountModel = AccountModel.fromJson(dataMap);
          var userId = accountModel.id.toString();
          fullName.value = "${accountModel.firstName} ${accountModel.lastName}";
          rewardStatus.value = accountModel.rewardStatus;
          profileImage.value = controller!.profileImage!.value;
          temporaryMap!.assignAll({
            "userId": userId,
            "firstName": accountModel.firstName,
            "lastName": accountModel.lastName,
            "email": accountModel.email,
            "phone": accountModel.phone,
            "url_image": profileImage.value,
          });

          isLoading.value = false;

          break;
        case "logout_success":
          showAlertSnackbar(alertMessage, true);
          Navigator.pushNamedAndRemoveUntil(
              context, '/onboarding', (route) => false);
          break;
      }
      controller!.resetResponse();
    });

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    ///CORE INFORMATION COMPONENT///

    updateProfilAction() =>
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          InkWell(
            onTap: () => Navigator.pushNamed(context, '/profile_form_page',
                    arguments: temporaryMap?.value)
                .then((_) => initData()),
            child: Text(
              "Ubah Profil",
              style: FontTheme.labelStyle1(
                  status: "bold", fontSize: 10, color: ColorsTheme.green),
            ),
          )
        ]);

    contentInformation() => Column(children: [
          CustomHeaderNoInfoTimeWidget(
            fullName: fullName.value,
            rewardStatus: rewardStatus.value,
            imageUrl: profileImage.value,
            headerKey: UniqueKey(),
          ),
          GeneralUtils().verticalSpacer(11),
          updateProfilAction(),
        ]);

    informationComponent() => Card(
          shape: GeneralUtils().customDecoration(),
          color: ColorsTheme.yellowSoft,
          elevation: 5.h,
          child: Container(
            width: ScreenUtil().screenWidth,
            padding: EdgeInsets.fromLTRB(19.w, 17.h, 19.w, 9.h),
            child: contentInformation(),
          ),
        );

    ////////////////////////////////

    //////////////////////////////
    ///STATISTIC DATA COMPONENT///
    //////////////////////////////

    contentStatisticAction() =>
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            "Statistik Masuk / Keluar Dana",
            style: FontTheme.labelStyle1(
                status: "bold", fontSize: 14, color: ColorsTheme.white),
          ),
          SvgPicture.asset(
            'assets/icon/planner.svg',
            semanticsLabel: 'ic_planner',
            width: 34.w,
            height: 29.h,
          ),
        ]);

    statisticActionComponent() => Card(
        shape: GeneralUtils().customDecoration(),
        color: ColorsTheme.green,
        elevation: 5.h,
        child: InkWell(
          onTap: () {},
          splashColor: ColorsTheme.yellowSoft,
          borderRadius: BorderRadius.circular(10.r),
          child: Container(
            width: ScreenUtil().screenWidth,
            padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 17.w),
            child: contentStatisticAction(),
          ),
        ));

    //////////////////////////////

    menuListComponent() => Card(
        shape: GeneralUtils().customDecoration(),
        color: ColorsTheme.yellowSoft,
        child: Container(
          width: ScreenUtil().screenWidth,
          height: 270.h,
          padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 12.h),
          child: ListView.builder(
            itemCount: menuLabelList!.length,
            padding: EdgeInsets.only(bottom: 60.h),
            itemBuilder: (context, index) => CustomMenuProfileWidget(
              label: menuLabelList![index],
              iconLabel: menuIconList![index],
              callback: (label) => label == "Keluar" ? logout() : {},
            ),
          ),
        ));

    //////////////////////////////

    appbar() => PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: CustomAppBar(
              appLabel: "Profil",
              identifier: "profile",
              callback: () => HomeNavigationPage.of(context)!.backIntoHome(0)),
        );

    contentBody() => isLoading.value
        ? CustomShimmerCardWidget(height: 60.h)
        : Column(
            children: [
              informationComponent(),
              GeneralUtils().verticalSpacer(15),
              statisticActionComponent(),
              GeneralUtils().verticalSpacer(22),
              menuListComponent(),
            ],
          );

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(left: 17.w, right: 17.w, top: 10.h),
          child: Obx(() => Stack(children: [contentBody(), handlingError()!])),
        ),
        appBar: appbar(),
      ),
    );
  }
}
