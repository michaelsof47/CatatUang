part of 'package:catat_uang/import_url_file.dart';

class HomeNavigationPage extends ConsumerStatefulWidget {
  const HomeNavigationPage({super.key});

  @override
  ConsumerState<HomeNavigationPage> createState() => HomeNavigationPageState();
}

class HomeNavigationPageState extends ConsumerState<HomeNavigationPage> {
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

  ////////////////
  //GLOBAL UTILS//
  ////////////////

  DateTime? currentBackPressed;

  /////////////////////
  //CUSTOM DECORATION//
  /////////////////////
  customDecoration() => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      );

  @override
  void initState() {
    super.initState();

    initConstructor();
    initData();
  }

  initConstructor() {
    navActionLabel = ["Home", "Transaction", "Planner", "More"];
    navActionIcon = [
      'assets/icon/home.svg',
      'assets/icon/transaction.svg',
      'assets/icon/planner.svg',
      'assets/icon/more.svg'
    ];

    navPage = [
      HomeDashboardPage(),
      TransactionPage(),
      PlannerPage(),
      ProfilePage(),
    ];
    currentIndex = 0;
  }

  initData() {}

  Future<bool> backpressedAction() {
    DateTime now = DateTime.now();
    if (currentBackPressed == null ||
        now.difference(currentBackPressed!) > Duration(seconds: 2)) {
      currentBackPressed = now;
      print("Klik 2x untuk keluar dari Aplikasi");
      return Future.value(false);
    }
    return Future.value(true);
  }

  ///////////////////
  ///CUSTOM WIDGET///
  ///////////////////

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
            style: GeneralStyle.labelStyle1(false, 10, ColorsTheme.black),
          )
        ],
      );

  iconBtnList(index) => SizedBox(
        width: 65.w,
        child: InkWell(
          onTap: () => setState(() => currentIndex = index),
          splashColor: ColorsTheme.yellow,
          borderRadius: BorderRadius.circular(10.r),
          child: btnItemContent(index),
        ),
      );

  @override
  Widget build(BuildContext context) {
    bottomNav1() => Card(
          shape: customDecoration(),
          elevation: 6.h,
          child: Container(
            height: 54.h,
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                iconBtnList(0),
                iconBtnList(1),
                iconBtnList(2),
                iconBtnList(3),
              ],
            ),
          ),
        );

    customBottomNav() => Padding(
          padding: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 10.h),
          child: bottomNav1(),
        );

    contentBody() => SafeArea(
          child: Scaffold(
            body: navPage![currentIndex],
            bottomNavigationBar: customBottomNav(),
          ),
        );

    return WillPopScope(
      child: Container(
        color: ColorsTheme.barStatusColor,
        child: contentBody(),
      ),
      onWillPop: () => backpressedAction(),
    );
  }
}
