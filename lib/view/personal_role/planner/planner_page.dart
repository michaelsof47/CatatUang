part of 'package:catat_uang/import_url_file.dart';

class PlannerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocalManager>(() => LocalManager());
    Get.lazyPut<PlannerServiceInterface>(() => PlannerService());

    Get.lazyPut<PlannerController>(() => PlannerController(
          service: Get.find<PlannerServiceInterface>(),
          localManager: Get.find<LocalManager>(),
        ));
  }
}

class PlannerPage extends StatefulWidget {
  @override
  State<PlannerPage> createState() => PlannerPageState();
}

class PlannerPageState extends State<PlannerPage> {
  
  late PlannerController controller;
  late LocalManager localManager;
  late List<BooksItem> bookList;
  late ScrollController scrollCtrl;
  late List<String> bottomsheetHintLabels;
  late TextEditingController booknameInputController;
  late TextEditingController startdateInputController;
  late TextEditingController enddateInputController;
  late TextEditingController currencyInputController;
  late TextEditingController filterInputController;

  var currentPage;
  var isLoadMore;
  var hasMore;
  var isEmptyBook;
  var isLoading;
  var isSearchNotFound;

  @override
  void initState() {
    super.initState();

    initConstructor();
    initData();
  }

  initConstructor() {
    controller = Get.find<PlannerController>();
    booknameInputController = TextEditingController();
    startdateInputController = TextEditingController();
    enddateInputController = TextEditingController();
    currencyInputController = TextEditingController();
    filterInputController = TextEditingController();
    scrollCtrl = ScrollController();

    isLoading = false.obs;
    bookList = [];
    currentPage = 1.obs;
    hasMore = true.obs;
    isLoadMore = false.obs;
    isEmptyBook = true.obs;
    isSearchNotFound = false.obs;
    bottomsheetHintLabels = ["Nama Buku Proyeksi", "Tanggal Awal", "Tanggal Akhir", "Jumlah Saldo"];

    scrollCtrl.addListener(() {
      if (scrollCtrl.position.pixels == scrollCtrl.position.maxScrollExtent &&
          hasMore.value &&
          !isLoadMore.value) {
        onLoadMoreData();
      }
    });
  }

  initData() async {
    isLoading.value = true;
    controller.retrieveBookList(currentPage: currentPage.value, filter: "");
  }

  showAlertSnackbar(String? label, bool? isSuccessful) =>
      ScaffoldMessenger.of(context).showSnackBar(GeneralUtils().alertSnackbar(
          label: label,
          color: isSuccessful! ? ColorsTheme.green : ColorsTheme.redSoft));

  Widget? handlingError() {
    var alertStatus = "".obs;
    alertStatus.value = controller.resultStatus.value;
    var alertMessage = controller.resultMessage.value;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      switch (alertStatus.value) {
        case "retrieve_book_success":
          isLoading.value = false;

          if (currentPage.value == 1) {
            bookList.clear();
          }

          PlannerBookListModel tempBookList =
              PlannerBookListModel.fromJson(controller.bookList!);
          for (var book in tempBookList.booksItem!) {
            bookList.add(book);
          }

          if (bookList.length < tempBookList.pagination!.totalItems!) {
            hasMore.value =
                bookList.length >= tempBookList.pagination!.pageSize!;
          } else {
            hasMore.value = false;
          }

          isLoadMore.value = false;
          isSearchNotFound.value = false;
          isEmptyBook.value = false;
          break;
        case "retrieve_book_failure":
          isLoading.value = false;
          isLoadMore.value = false;
          isSearchNotFound.value = true;
          isEmptyBook.value = false;
          showAlertSnackbar(alertMessage, false);
          break;
      }

      controller.resetResponse();
    });

    return Container();
  }

  Future<void> onRefreshList() async {
    isLoading.value = true;
    currentPage.value = 1;
    bookList.clear();
    controller.retrieveBookList(
        currentPage: currentPage.value, filter: filterInputController.text);
  }

  Future<void> onLoadMoreData() async {
    isLoadMore.value = true;
    currentPage.value++;
    print("masuk sini");
    controller.retrieveBookList(
        currentPage: currentPage.value, filter: filterInputController.text);
  }

  Future<void> onFilteredData(String value) async {
    isLoading.value = true;
    currentPage.value = 1;
    bookList.clear();
    controller.retrieveBookList(currentPage: currentPage.value, filter: value);
  }

  showCreateBookForm() => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: ColorsTheme.greenNature,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r))),
        builder: (buildContext) => CustomBSPlannerInputFieldWidget(
          headerLabel: "Form Tambah Buku",
          booknameInputController: booknameInputController,
          startdateInputController: startdateInputController,
          enddateInputController: enddateInputController,
          currencyInputController: currencyInputController,
          hintLabels: bottomsheetHintLabels,
        ),
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

    bookListComponent() {
      itemList() => Expanded(
          child: RefreshIndicator(
              onRefresh: () async => onRefreshList(),
              child: ListView.builder(
                  shrinkWrap: true,
                  controller: scrollCtrl,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: bookList.length + (hasMore.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < bookList.length) {
                      return CustomPlannerListWidget(book: bookList[index]);
                    } else {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                  })));

      return Column(children: [
        GeneralUtils().iconClickableTextFormField(
            controller: filterInputController,
            label: "Cari Buku Proyeksi",
            isFinalInput: true,
            isEnabled: true,
            color: ColorsTheme.yellow,
            click_type: "search",
            isNumber: false,
            callback: (value) => onFilteredData(value)),
        GeneralUtils().verticalSpacer(20.h),
        isSearchNotFound.value
            ? Column(
              children: [
                GeneralUtils().verticalSpacer(35.h),
                Lottie.asset("assets/animation/emptybox.json",
                        width: 220.w, height: 220.h, fit: BoxFit.fill),
                GeneralUtils().verticalSpacer(10.h),
                Text("Buku Tidak Tersedia",
                    style: FontTheme.labelStyle1(
                        status: "bold",
                        fontSize: 16,
                        color: ColorsTheme.black)),
              ])
            : itemList()
      ]);
    }

    baseComponent() => Stack(
          children: [
            isEmptyBook.value
                ? Column(children: [
                    GeneralUtils().verticalSpacer(35.h),
                    NewDocumentWidget(
                      moduleType: "",
                      headerLabel: "Buku Proyeksi belum tersedia",
                      descLabel:
                          "Silahkan membuat Buku Proyeksi terlebih dahulu",
                    )
                  ])
                : bookListComponent(),
            isSearchNotFound.value
                ? Container()
                : Positioned(
                    bottom: 35.h,
                    right: 3.w,
                    child: FloatingActionButton(
                      onPressed: () => showCreateBookForm(),
                      shape: CircleBorder(),
                      child:
                          Icon(Icons.add, size: 25.w, color: ColorsTheme.black),
                      backgroundColor: ColorsTheme.yellow,
                    )),
          ],
        );

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.only(left: 17.w, right: 17.w, top: 29.h),
          child: Obx(() => Stack(
                children: [
                  isLoading.value
                      ? CustomShimmerCardListWidget()
                      : baseComponent(),
                  handlingError()!,
                ],
              )),
        ),
        appBar: appbar(),
      ),
    );
  }
}
