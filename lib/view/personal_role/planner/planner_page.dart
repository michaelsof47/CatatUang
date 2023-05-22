part of 'package:catat_uang/import_url_file.dart';

class PlannerPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<PlannerPage> createState() => PlannerPageState();
}

class PlannerPageState extends ConsumerState<PlannerPage> {
  PlannerController? controller;

  TextEditingController? inputController;
  LocalManager? localManager;

  List<String>? itemMenuLabelFilter;
  List<PieChartSectionData>? itemPieChartList;

  var bookName;
  var isAddedBook;

  @override
  void initState() {
    super.initState();

    initConstructor();
    initData();
  }

  initConstructor() {
    controller = Get.put(PlannerController());
    inputController = TextEditingController();

    itemMenuLabelFilter = [
      "3 Bulan",
      "6 Bulan",
      "9 Bulan",
      "1 Tahun",
      "Custom"
    ];

    itemPieChartList = [
      PieChartSectionData(
        value: 10,
        color: ColorsTheme.yellow,
        titleStyle: GeneralStyle.labelStyle1(true, 12, ColorsTheme.black),
        title: "Kebutuhan\nSehari-Hari",
      ),
      PieChartSectionData(
        value: 25,
        color: ColorsTheme.green,
        titleStyle: GeneralStyle.labelStyle1(true, 12, ColorsTheme.black),
        title: "Tabungan",
      ),
      PieChartSectionData(
        value: 30,
        color: ColorsTheme.redSoft,
        titleStyle: GeneralStyle.labelStyle1(true, 12, ColorsTheme.black),
        title: "Pinjaman",
      ),
    ];

    bookName = "".obs;
    isAddedBook = false.obs;
  }

  initData() async {
    bookName.value = await controller!.retrievePlannerBookController();
    print("data: ${bookName.value}");
    if (bookName.value == "") {
      isAddedBook.value = false;
    } else {
      isAddedBook.value = true;
    }
  }

  contentBottomSheet() => showModalBottomSheet(
        context: context,
        builder: (context) => CustomBottomSheetInputFieldWidget(
          callback: (value) async {
            await controller!.storedPlannerBookController(value);
            initData();
          },
          inputController: inputController,
        ),
        isScrollControlled: true,
        shape: GeneralUtils.customDecoration(),
        barrierColor: ColorsTheme.black25,
        backgroundColor: ColorsTheme.yellowSoft,
      );

  @override
  Widget build(BuildContext context) {
    appbar() => PreferredSize(
          preferredSize: Size.fromHeight(61.h),
          child: CustomAppBar(appLabel: "Atur Proyeksi"),
        );

    ////////////////////////////
    ///NEW DOCUMENT COMPONENT///
    ////////////////////////////

    newDocumentComponent() => Stack(children: [
          Positioned(
            bottom: 85.h,
            right: 3.w,
            child: CustomSingleButtonWidget(
              actionCallback: () => contentBottomSheet(),
              hintLabel: "Tambah Proyeksi",
            ),
          ),
          NewDocumentWidget(
            headerLabel: "Buku Proyeksi belum tersedia",
            descLabel: "Silahkan membuat Buku Proyeksi terlebih dahulu",
          ),
        ]);

    ////////////////////////////

    ////////////////////////////////
    ///PLANNER DOCUMENT COMPONENT///
    ////////////////////////////////

    ///ACTION COMPONENT UTILS///

    contentButton() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 7.h),
        child: Text(
          "Ubah",
          style: GeneralStyle.labelStyle1(true, 14, ColorsTheme.greenNature),
        ));

    updatePlannerBookNameButton() => Card(
          elevation: 5,
          shape: GeneralUtils.customDecoration(),
          color: ColorsTheme.green,
          child: InkWell(
            onTap: () async {
              inputController!.text = bookName.value;
              await contentBottomSheet();
            },
            borderRadius: BorderRadius.circular(10.r),
            child: contentButton(),
          ),
        );

    ///VIEW COMPONENT UTILS///

    //Header Information//

    columnInfoBookName() =>
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Nama Buku",
            style: GeneralStyle.labelStyle1(false, 10, ColorsTheme.black),
          ),
          GeneralUtils.verticalSpacer(1),
          Text(
            bookName.value,
            style: GeneralStyle.labelStyle1(true, 18, ColorsTheme.black),
          ),
        ]);

    plannerInfoBookName() => Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            columnInfoBookName(),
            updatePlannerBookNameButton(),
          ]),
        );

    //Filter Planner Book//
    dropdownItem() => DropdownButtonHideUnderline(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 8.w),
            child: CustomDropdownWidget(
              initialValue: ref.watch(durationPlannerItemDropdownValue),
              itemMenuLabelFilter: itemMenuLabelFilter,
              callback: (value) {
                ref
                    .read(durationPlannerItemDropdownValue.notifier)
                    .update((state) => value!);
                print(value!);
              },
            ),
            decoration: GeneralUtils.customBoxStyle1(),
          ),
        );

    contentDurationRangeFilter() =>
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            "Rencana Proyeksi",
            style: GeneralStyle.labelStyle1(true, 14, ColorsTheme.white),
          ),
          dropdownItem(),
        ]);

    durationRangeFilterCardComponent() => Card(
        shape: GeneralUtils.customDecoration(),
        color: ColorsTheme.green,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 9.w),
          child: contentDurationRangeFilter(),
        ));

    //Pie Chart Graphic//

    contentItem(label1, label2, isHeader) =>
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            label1,
            style: GeneralStyle.labelStyle1(isHeader ? false : true, 14,
                isHeader ? ColorsTheme.black : ColorsTheme.green),
          ),
          GeneralUtils.verticalSpacer(5),
          Text(
            label2,
            style: GeneralStyle.labelStyle1(isHeader ? false : true, 14,
                isHeader ? ColorsTheme.black : ColorsTheme.redSoft),
          ),
        ]);

    itemInfoRowLabel() =>
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            width: 145.w,
            child: contentItem("Proyeksi Dana", "Dana yang Tersedia", true),
          ),
          GeneralUtils.horizontalSpacer(5),
          SizedBox(
            width: 5.w,
            child: contentItem(":", ":", true),
          ),
          GeneralUtils.horizontalSpacer(5),
          SizedBox(
            width: 110.w,
            child: contentItem("Rp. 8.000.000", "Rp. 3.000.000", false),
          ),
        ]);

    pieChartInfoGraphic() => SizedBox(
          width: 260.w,
          height: 260.h,
          child: PieChart(
            PieChartData(
              sections: itemPieChartList,
            ),
            swapAnimationDuration: const Duration(milliseconds: 500),
            swapAnimationCurve: Curves.linear,
          ),
        );

    pieChartHeader() => Padding(
          padding: EdgeInsets.only(left: 15.w),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Preview Grafik Saat Ini",
              style: GeneralStyle.labelStyle1(true, 14, ColorsTheme.black),
            ),
            GeneralUtils.horizontalSpacer(5),
            Tooltip(
              message: "Berikut ini merupakan grafik \nperkembangan saat ini",
              textStyle: GeneralStyle.labelStyle1(false, 10, ColorsTheme.white),
              child: Icon(
                Icons.info_rounded,
                color: ColorsTheme.green,
                size: 15.w,
              ),
            )
          ]),
        );

    contentInfoGraphic() => Container(
          height: 350.h,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 70.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                itemInfoRowLabel(),
                GeneralUtils.verticalSpacer(20),
                pieChartHeader(),
                GeneralUtils.verticalSpacer(5),
                pieChartInfoGraphic(),
              ],
            ),
          ),
        );

    infoGraphicCardComponent() => Card(
        shape: GeneralUtils.customDecoration(),
        color: ColorsTheme.yellowSoft,
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.w, 19.h, 10.w, 0.h),
          child: contentInfoGraphic(),
        ));

    ///GENERAL COMPONENT///

    plannerDashboardComponent() => Stack(children: [
          Column(children: [
            plannerInfoBookName(),
            GeneralUtils.verticalSpacer(20),
            durationRangeFilterCardComponent(),
            GeneralUtils.verticalSpacer(10),
            infoGraphicCardComponent(),
          ]),
          Positioned(
            bottom: 85.h,
            right: 3.w,
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: ColorsTheme.green,
              child: Icon(Icons.add_rounded, color: ColorsTheme.white),
            ),
          ),
        ]);

    ////////////////////////////////

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(left: 17.w, right: 17.w, top: 29.h),
          child: Obx(
            () => isAddedBook.value
                ? plannerDashboardComponent()
                : newDocumentComponent(),
          ),
        ),
        appBar: appbar(),
      ),
    );
  }
}
