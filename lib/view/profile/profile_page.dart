part of 'package:catat_uang/import_url_file.dart';

class ProfilePage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends ConsumerState<ProfilePage> {
  List<String>? menuLabelList;
  List<IconData>? menuIconList;

  LoginController? loginController;

  @override
  void initState() {
    super.initState();

    initConstructor();
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

    loginController = Get.put(LoginController());
  }

  logout() async {
    await loginController!.storeLoginStatusController(false);
    await loginController!.clearDataController();
    Navigator.popAndPushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    ////////////////////////////////
    ///CORE INFORMATION COMPONENT///
    ////////////////////////////////

    updateProfilAction() =>
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          InkWell(
            onTap: () {},
            child: Text(
              "Ubah Profil",
              style: FontTheme.labelStyle1(isBold: true,fontSize: 10, color: ColorsTheme.green),
            ),
          )
        ]);

    contentInformation() => Column(children: [
          CustomHeaderNoInfoTimeWidget(
            fullName: "Michael Fernando",
            statusInformation: "Novice",
          ),
          GeneralUtils.verticalSpacer(11),
          updateProfilAction(),
        ]);

    informationComponent() => Card(
          shape: GeneralUtils.customDecoration(),
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
            style: FontTheme.labelStyle1(isBold: true,fontSize: 14,color: ColorsTheme.white),
          ),
          SvgPicture.asset(
            'assets/icon/planner.svg',
            semanticsLabel: 'ic_planner',
            width: 34.w,
            height: 29.h,
          ),
        ]);

    statisticActionComponent() => Card(
        shape: GeneralUtils.customDecoration(),
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
        shape: GeneralUtils.customDecoration(),
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
          preferredSize: Size.fromHeight(61.h),
          child: CustomAppBar(appLabel: "Profil"),
        );

    contentBody() => Column(
          children: [
            informationComponent(),
            GeneralUtils.verticalSpacer(15),
            statisticActionComponent(),
            GeneralUtils.verticalSpacer(22),
            menuListComponent(),
          ],
        );

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(left: 17.w, right: 17.w, top: 29.h),
          child: contentBody(),
        ),
        appBar: appbar(),
      ),
    );
  }
}
