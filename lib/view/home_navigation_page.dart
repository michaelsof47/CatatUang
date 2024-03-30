part of 'package:catat_uang/import_url_file.dart';

class HomeNavigationPage extends StatefulWidget {
  const HomeNavigationPage({super.key});

  @override
  State<HomeNavigationPage> createState() => HomeNavigationPageState();

  static HomeNavigationPageState? of(context) =>
      context.findAncestorStateOfType<HomeNavigationPageState>();
}

class HomeNavigationPageState extends State<HomeNavigationPage> {
  ///////////////////
  //GLOBAL DATASETS//
  ///////////////////
  List<String>? navActionLabel;
  List<String>? navActionIcon;
  List<Widget>? navPage;

  ///////////////////
  //GLOBAL VARIABLE//
  ///////////////////
  var currentIndex;
  var role;

  ////////////////
  //GLOBAL UTILS//
  ////////////////
  DateTime? currentBackPressed;
  LoginController? controller;

  //backIntoHome(int i) => setState(() => currentIndex.value = i);

  /////////////////////
  //CUSTOM DECORATION//
  /////////////////////
  customDecoration() => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      );

  customBoxBlur() => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            ColorsTheme.white,
            ColorsTheme.white,
          ],
        ),
      );

  @override
  void initState() {
    super.initState();

    initConstructor();
    initData();
  }

  initConstructor() {
    role = "Personal".obs;
    navActionLabel = [];
    navActionIcon = [
      'assets/icon/home.svg',
      'assets/icon/transaction.svg',
      'assets/icon/planner.svg',
      'assets/icon/more.svg'
    ];

    navPage = [];

    currentIndex = 0.obs;

    controller = Get.put(LoginController());
  }

  initData() async {
    //role.value = await controller!.retrieveDevelopmentRoleStatusController();

    if (role.value == "Personal") {
      setState(() {
        navPage = [
          HomeDashboardPage(),
          TransactionPage(),
          PlannerPage(),
          ProfilePage()
        ];
        navActionLabel = ["Home", "Transaction", "Planner", "More"];
      });
    } else if (role.value == "Owner") {
      setState(() {
        navPage = [
          //OwnerDashboardPage(),
          //ProductPage(),
          //DebtLoanBookPage(),
          ProfilePage(),
        ];
        navActionLabel = ["Home", "Add Product", "Debt and Loan", "More"];
      });
    }
  }

  Future<bool> backpressedAction() {
    DateTime now = DateTime.now();

    if (currentBackPressed == null ||
        now.difference(currentBackPressed!) > const Duration(seconds: 2)) {
      currentBackPressed = now;
      ScaffoldMessenger.of(context).showSnackBar(
        GeneralUtils.alertSnackbar(
          label: "Klik 2x untuk keluar dari aplikasi.",
          color: ColorsTheme.black,
        ),
      );
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    btnItemContent(index) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              navActionIcon![index],
              width: 18.w,
              height: 18.h,
              fit: BoxFit.scaleDown,
              semanticsLabel: "icon navigation menu",
            ),
            GeneralUtils.verticalSpacer(5),
            Text(
              navActionLabel![index],
              style: FontTheme.labelStyle1(
                  isBold: false, fontSize: 10, color: ColorsTheme.black),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ],
        );

    iconBtnList(index) => Container(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          width: 65.w,
          child: InkWell(
            onTap: () => currentIndex.value = index,
            splashColor: ColorsTheme.yellow,
            borderRadius: BorderRadius.circular(10.r),
            child: btnItemContent(index),
          ),
        );

    itemMenu() => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              iconBtnList(0),
              iconBtnList(1),
              iconBtnList(2),
              iconBtnList(3),
            ]);

    customBottomNav() => Padding(
        padding: GeneralUtils.fromHTBPadding(h: 30, b: 10, t: 0),
        child: Card(
          shape: customDecoration(),
          elevation: 6.h,
          child: Container(
              height: 58.h,
              padding: GeneralUtils.symmetricPadding(v: 5, h: 10),
              child: itemMenu()),
        ));

    blurBackground() => BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
          blendMode: BlendMode.srcOver,
          child: Container(
            width: ScreenUtil().screenWidth,
            decoration: customBoxBlur(),
          ),
        );

    itemComponentWidget({bool? isImage, double? t, double? r, double? b}) =>
        Positioned(
          top: t == 0.0 ? null : t!.h,
          bottom: b == 0.0 ? null : b!.h,
          right: r!.w,
          child: isImage!
              ? SvgPicture.asset('assets/image/iv_cloud.svg',
                  semanticsLabel: 'cloud_bg')
              : ClipRRect(
                  child: Stack(
                  children: [blurBackground(), customBottomNav()],
                )),
        );

    respHandlerWidget() => Obx(() => Stack(children: [
          itemComponentWidget(isImage: true, t: -10, r: -10, b: 0),
          navPage![currentIndex.value],
          itemComponentWidget(isImage: false, b: 1, r: 0, t: 0),
        ]));

    contentBody() => Container(
        color: ColorsTheme.barStatusColor,
        child: SafeArea(
          child: Scaffold(body: respHandlerWidget()),
        ));

    return PopScope(
        canPop: true,
        onPopInvoked: (_) => backpressedAction(),
        child: contentBody());
  }
}
