part of 'package:catat_uang/import_url_file.dart';

class HomeDashboardPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<HomeDashboardPage> createState() => HomeDashboardPageState();
}

class HomeDashboardPageState extends ConsumerState<HomeDashboardPage> {
  List<String>? itemMenuLabelList;
  List<String>? itemMenuActionList;

  //LocationPackage? locationPackage;
  //DashboardMessagePackage? dashboardMessagePackage;

  @override
  initState() {
    super.initState();

    initConstructor();
    initData();
  }

  initConstructor() {
    itemMenuLabelList = ["Atur Proyeksi", "Atur Transaksi", "Analisa Keuangan"];
    itemMenuActionList = ["/planner_form", "/transaction_page", ""];

    //dashboardMessagePackage = Get.put(DashboardMessagePackage());
    //locationPackage = Get.put(LocationPackage());
  }

  initData() async {
    //await dashboardMessagePackage!.statusTiming();
    //await locationPackage!.requestPermissions();
  }

  @override
  Widget build(BuildContext context) {
    ////////////////////////////////////////////
    ///CUSTOM SHORCUT MENU + SUMMARY BALANCES///
    ////////////////////////////////////////////

    rewardIconStatus() => Container(
          width: 59.w,
          height: 54.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            color: ColorsTheme.white,
            image: const DecorationImage(
              image: AssetImage('assets/image/ic_dummy_reward.png'),
              fit: BoxFit.scaleDown,
            ),
          ),
        );

    balancesInformation() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total Saldo Hari Ini",
              style: FontTheme.labelStyle1(
                  isBold: true, fontSize: 13, color: ColorsTheme.black),
            ),
            GeneralUtils.verticalSpacer(6),
            Text(
              "Rp. 250.000,00",
              style: FontTheme.labelStyle1(
                  isBold: true, fontSize: 24, color: ColorsTheme.black),
            ),
          ],
        );

    userTransactionLabel() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Rangkuman Transaksi Terbaru",
              style: FontTheme.labelStyle1(
                  isBold: true, fontSize: 10, color: ColorsTheme.black),
            ),
            Text(
              "5 Transaksi/Bulan",
              style: FontTheme.labelStyle1(
                  isBold: true, fontSize: 10, color: ColorsTheme.black),
            ),
          ],
        );

    userInformation() => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                balancesInformation(),
                rewardIconStatus(),
              ],
            ),
            GeneralUtils.verticalSpacer(11),
            userTransactionLabel(),
          ],
        );

    //////////////////////////////////////////////

    ////////////////////////////////
    ///CUSTOM LASTEST TRANSACTION///
    ////////////////////////////////

    headerLabel() => Text("Transaksi Terbaru Saat Ini",
        style: FontTheme.labelStyle1(
            isBold: true, fontSize: 14, color: ColorsTheme.white));

    iconTransaction() => Container(
          width: 70.w,
          height: 48.h,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/image/ic_dummy_outlet.png'),
              fit: BoxFit.fill,
            ),
            border: Border.all(color: ColorsTheme.white, width: 3.w),
            borderRadius: BorderRadius.circular(10.r),
          ),
        );

    itemRowLabel(label1, label2) => Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 110.w,
              child: Text(
                label1,
                style: FontTheme.labelStyle1(isBold: true,fontSize: 11, color: ColorsTheme.white),
              ),
            ),
            GeneralUtils.horizontalSpacer(4),
            Text(
              ":",
              style: FontTheme.labelStyle1(isBold: false,fontSize: 11, color: ColorsTheme.white),
            ),
            GeneralUtils.horizontalSpacer(2),
            SizedBox(
              width: 115.w,
              child: Text(
                label2,
                style: FontTheme.labelStyle1(isBold: false,fontSize: 11, color: ColorsTheme.white),
              ),
            ),
          ],
        );

    contentDescriptionInformation() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            itemRowLabel(
              "Tanggal Transaksi",
              "06 Okt 2023 19:00 WIB",
            ),
            GeneralUtils.verticalSpacer(1),
            itemRowLabel(
              "Nama Outlet",
              "Hokky Klampis Indah",
            ),
            GeneralUtils.verticalSpacer(1),
            itemRowLabel(
              "Total Pengeluaran",
              "Rp. 270.000",
            ),
          ],
        );

    transactionInformationRow() => Row(
          children: [
            iconTransaction(),
            GeneralUtils.horizontalSpacer(8),
            contentDescriptionInformation(),
          ],
        );

    contentLastestTransaction() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerLabel(),
            GeneralUtils.customCardLiner(
              color: ColorsTheme.white,
              horizontalPad: 0.w,
              verticalPad: 3.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 3.h),
              child: transactionInformationRow(),
            )
          ],
        );

    lastestTransactionCardComponent() => Card(
          shape: GeneralUtils.customDecoration(),
          color: ColorsTheme.green,
          child: Container(
            width: ScreenUtil().screenWidth,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            child: contentLastestTransaction(),
          ),
        );

    ////////////////////////////////

    /////////////////////////////
    ///CUSTOM TIPS TRANSACTION///
    /////////////////////////////

    headerLabel1() => Text("Financial Tips",
        style: FontTheme.labelStyle1(
            isBold: true, fontSize: 14, color: ColorsTheme.black));

    iconFinancial() => Container(
          width: 70.w,
          height: 48.h,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/image/ic_dummy_outlet.png'),
              fit: BoxFit.fill,
            ),
            border: Border.all(color: ColorsTheme.white, width: 3.w),
            borderRadius: BorderRadius.circular(10.r),
          ),
        );

    contentHeaderInformation() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 180.w,
              child: Text(
                "Tips untuk mengelola keuangan secara efektif ? ",
                style: FontTheme.labelStyle1(isBold: true,fontSize: 12, color: ColorsTheme.black),
              ),
            )
          ],
        );

    tipsInformationRow() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            contentHeaderInformation(),
            iconFinancial(),
          ],
        );

    contentLastestFinancialTips() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerLabel1(),
            GeneralUtils.customCardLiner(
              color: ColorsTheme.green,
              horizontalPad: 0.w,
              verticalPad: 3.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 3.h),
              child: tipsInformationRow(),
            )
          ],
        );

    lastestFinancialTipsCardComponent() => Card(
          shape: GeneralUtils.customDecoration(),
          color: ColorsTheme.yellowSoft,
          child: Container(
            width: ScreenUtil().screenWidth,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            child: contentLastestFinancialTips(),
          ),
        );

    ////////////////////////////////

    contentBody() => Column(
          children: [
            /*Obx(
              () => CustomHeaderWidget(
                fullName: "Michael Fernando",
                location: locationPackage!.itemAddress.value,
                conditionStatus: dashboardMessagePackage!.messageStatus.value,
              ),
            ),*/
            GeneralUtils.verticalSpacer(40),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 80.h, top: 0.h),
                child: Column(
                  children: [
                    CustomShortcutMenuWidget(
                      userInformation: userInformation(),
                      itemMenuLabelList: itemMenuLabelList,
                      itemMenuActionList: itemMenuActionList,
                      itemMenuHeight: 80,
                    ),
                    GeneralUtils.verticalSpacer(10),
                    lastestTransactionCardComponent(),
                    GeneralUtils.verticalSpacer(15),
                    lastestFinancialTipsCardComponent(),
                  ],
                ),
              ),
            ),
          ],
        );

    baseBody() => SafeArea(
          child: Scaffold(
            backgroundColor: ColorsTheme.transparent,
            body: Padding(
              padding: EdgeInsets.all(10.w),
              child: contentBody(),
            ),
          ),
        );

    return Container(
      child: baseBody(),
    );
  }
}
