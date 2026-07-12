part of 'package:catat_uang/import_url_file.dart';

class PlannerPage extends StatefulWidget {
  @override
  State<PlannerPage> createState() => PlannerPageState();
}

class PlannerPageState extends State<PlannerPage> {
  PlannerController? controller;

  TextEditingController? inputController;
  LocalManager? localManager;

  List<String>? itemMenuLabelFilter;
  List<PieChartSectionData>? itemPieChartList;

  var bookName;
  var isAddedBook;
  var isLoading;

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
        titleStyle: FontTheme.labelStyle1(
            status: "bold", fontSize: 12, color: ColorsTheme.black),
        title: "Kebutuhan\nSehari-Hari",
      ),
      PieChartSectionData(
        value: 25,
        color: ColorsTheme.green,
        titleStyle: FontTheme.labelStyle1(
            status: "bold", fontSize: 12, color: ColorsTheme.black),
        title: "Tabungan",
      ),
      PieChartSectionData(
        value: 30,
        color: ColorsTheme.redSoft,
        titleStyle: FontTheme.labelStyle1(
            status: "bold", fontSize: 12, color: ColorsTheme.black),
        title: "Pinjaman",
      ),
    ];

    bookName = "".obs;
    isAddedBook = false.obs;
    isLoading = false.obs;
  }

  initData() async {
    bookName.value = "";
    isLoading.value = true;

    controller!.retrieveBookList();

    //isAddedBook.value = bookName.value != "";
  }

  showAlertSnackbar(String? label, bool? isSuccessful) =>
      ScaffoldMessenger.of(context).showSnackBar(GeneralUtils().alertSnackbar(
          label: label,
          color: isSuccessful! ? ColorsTheme.green : ColorsTheme.redSoft));

  Widget? handlingError() {
    var alertStatus = "".obs;
    alertStatus.value = controller!.resultStatus.value;
    var alertMessage = controller!.resultMessage.value;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      switch (alertStatus.value) {
        case "retrieve_book_success":
          isLoading.value = false;
          isAddedBook.value = true;
          print("data: ${controller!.bookList}");
          break;
        case "retrieve_book_failure":
          isLoading.value = false;
          isAddedBook.value = false;
          showAlertSnackbar(alertMessage, false);
          break;
      }

      controller!.resetResponse();
    });

    return Container();
  }

  contentBottomSheet() => showModalBottomSheet(
        context: context,
        builder: (context) => CustomBottomSheetInputFieldWidget(
          callback: (value) async {
            initData();
          },
          inputController: inputController,
          headerLabel: "Nama Buku Proyek",
          hintLabel: "Masukkan Nama Buku Proyek",
          isNumber: false,
        ),
        isScrollControlled: true,
        shape: GeneralUtils().customDecoration(),
        barrierColor: ColorsTheme.black25,
        backgroundColor: ColorsTheme.yellowSoft,
      );

  showCreateBookForm() => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: ColorsTheme.greenNature,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r))),
        builder: (buildContext) => CustomBottomSheetInputFieldWidget(
            inputController: inputController,
            callback: (String value) {},
            headerLabel: "Tambah Buku Proyeksi Awal",
            hintLabel: "Nama Buku Proyeksi",
            isNumber: false),
      );

  @override
  Widget build(BuildContext context) {
    appbar() => PreferredSize(
          preferredSize: Size.fromHeight(61.h),
          child: CustomAppBar(
              appLabel: "Atur Proyeksi",
              identifier: "planner",
              callback: () => Navigator.pop(context)),
        );

    ////////////////////////////
    ///NEW DOCUMENT COMPONENT///
    ////////////////////////////

    newDocumentComponent() => Stack(
          children: [
            Positioned(
                bottom: 35.h,
                right: 3.w,
                child: FloatingActionButton(
                  onPressed: () => showCreateBookForm(),
                  shape: CircleBorder(),
                  child: Icon(Icons.add, size: 25.w, color: ColorsTheme.black),
                  backgroundColor: ColorsTheme.yellow,
                )),
            Column(children: [
              GeneralUtils().verticalSpacer(35.h),
              NewDocumentWidget(
                moduleType: "",
                headerLabel: "Buku Proyeksi belum tersedia",
                descLabel: "Silahkan membuat Buku Proyeksi terlebih dahulu",
              ),
            ])
          ],
        );

    ////////////////////////////

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(left: 17.w, right: 17.w, top: 29.h),
          child: Obx(() => Stack(
                children: [
                  isLoading.value
                      ? CustomShimmerCardListWidget()
                      : isAddedBook.value
                          ? Text("Ada Data")
                          : newDocumentComponent(),
                ],
              )),
        ),
        appBar: appbar(),
      ),
    );
  }
}
