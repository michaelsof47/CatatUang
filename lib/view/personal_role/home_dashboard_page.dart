part of 'package:catat_uang/import_url_file.dart';

class HomeDashboardPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<HomeDashboardPage> createState() => HomeDashboardPageState();
}

class HomeDashboardPageState extends ConsumerState<HomeDashboardPage> {
  List<String>? itemMenuLabelList;

  ///////////////////////
  ///CUSTOM DECORATION///
  ///////////////////////

  customBorder() => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      );

  //////////////////
  ///CUSTOM UTILS///
  //////////////////

  customLiner({Color? color, double? horizontalPad, double? verticalPad}) =>
      Padding(
        padding: EdgeInsets.symmetric(
          vertical: verticalPad!.h,
          horizontal: horizontalPad!.w,
        ),
        child: Container(
          height: 3.h,
          width: ScreenUtil().screenWidth,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5.r),
          ),
        ),
      );

  @override
  initState() {
    super.initState();

    initConstructor();
    initData();
  }

  initConstructor() {
    itemMenuLabelList = ["Atur Proyeksi", "Atur Transaksi", "Analisis"];
  }

  initData() {}

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
              style: GeneralStyle.labelStyle1(true, 13, ColorsTheme.black),
            ),
            GeneralUtils.verticalSpacer(6),
            Text(
              "Rp. 250.000,00",
              style: GeneralStyle.labelStyle1(true, 24, ColorsTheme.black),
            ),
          ],
        );

    userTransactionLabel() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Rangkuman Transaksi Terbaru",
              style: GeneralStyle.labelStyle1(true, 10, ColorsTheme.black),
            ),
            Text(
              "5 Transaksi/Bulan",
              style: GeneralStyle.labelStyle1(true, 10, ColorsTheme.black),
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

    itemMenuList() => SizedBox(
          height: 80.h,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 100.w,
              mainAxisSpacing: 5.w,
              childAspectRatio: 1,
              crossAxisSpacing: 5.h,
            ),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) => CustomMenuButton(
              menuLabel: itemMenuLabelList![index],
            ),
          ),
        );

    shortcutMenuAndSummaryBalancesCardComponent() => Card(
          shape: customBorder(),
          color: ColorsTheme.yellowSoft,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
            child: Column(
              children: [
                userInformation(),
                customLiner(
                  color: ColorsTheme.green,
                  verticalPad: 9.h,
                  horizontalPad: 14.w,
                ),
                itemMenuList(),
              ],
            ),
          ),
        );

    //////////////////////////////////////////////

    ////////////////////////////////
    ///CUSTOM LASTEST TRANSACTION///
    ////////////////////////////////

    headerLabel() => Text(
          "Transaksi Terbaru Saat Ini",
          style: GeneralStyle.labelStyle1(true, 14, ColorsTheme.white),
        );

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
                style: GeneralStyle.labelStyle1(true, 11, ColorsTheme.white),
              ),
            ),
            GeneralUtils.horizontalSpacer(4),
            Text(
              ":",
              style: GeneralStyle.labelStyle1(false, 11, ColorsTheme.white),
            ),
            GeneralUtils.horizontalSpacer(2),
            SizedBox(
              width: 115.w,
              child: Text(
                label2,
                style: GeneralStyle.labelStyle1(false, 11, ColorsTheme.white),
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
            customLiner(
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
          shape: customBorder(),
          color: ColorsTheme.green,
          child: Container(
            width: ScreenUtil().screenWidth,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            child: contentLastestTransaction(),
          ),
        );

    ////////////////////////////////

    ////////////////////////////////
    ///CUSTOM LASTEST TRANSACTION///
    ////////////////////////////////

    headerLabel1() => Text(
          "Financial Tips",
          style: GeneralStyle.labelStyle1(true, 14, ColorsTheme.black),
        );

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
                style: GeneralStyle.labelStyle1(true, 12, ColorsTheme.black),
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
            customLiner(
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
          shape: customBorder(),
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
            CustomHeaderWidget(
              fullName: "Michael Fernando",
            ),
            GeneralUtils.verticalSpacer(40),
            shortcutMenuAndSummaryBalancesCardComponent(),
            GeneralUtils.verticalSpacer(10),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 80.h, top: 0.h),
                child: Column(
                  children: [
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
