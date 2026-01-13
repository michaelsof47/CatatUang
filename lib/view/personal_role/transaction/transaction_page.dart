part of 'package:catat_uang/import_url_file.dart';

class TransactionPage extends StatefulWidget {
  @override
  State<TransactionPage> createState() => TransactionPageState();
}

class TransactionPageState extends State<TransactionPage> {
  DashboardController? controller;

  var balanceAmount;
  RxList<CategoryItem>? categoriesList;
  List<String>? dropdownList;
  var isLoading;
  var initialCategoryName;
  RxList<DetailItems> transactionList = <DetailItems>[].obs;
  ScrollController? scrollController;
  var currentPage;
  var hasMore;
  var isLoadMore;

  @override
  void initState() {
    super.initState();

    initConstructor();
    initData();
  }

  initConstructor() {
    categoriesList = <CategoryItem>[].obs;
    balanceAmount = 0.obs;
    isLoading = false.obs;
    controller = Get.put(DashboardController());
    dropdownList = [];
    initialCategoryName = "Semua".obs;
    transactionList = <DetailItems>[].obs;
    scrollController = ScrollController();
    currentPage = 1.obs;
    hasMore = true.obs;
    isLoadMore = false.obs;

    scrollController!.addListener(() {
      if (scrollController!.position.pixels ==
              scrollController!.position.maxScrollExtent &&
          hasMore.value &&
          !isLoadMore.value) {
        onLoadMoreData();
      }
    });
  }

  initData() async {
    isLoading.value = true;
    currentPage.value = 1;
    hasMore.value = true;
    await controller!.getBalanceAmountCtrl(true, token: null);
  }

  showAlertSnackbar(String? label, bool? isSuccessful) =>
      ScaffoldMessenger.of(context).showSnackBar(GeneralUtils().alertSnackbar(
          label: label,
          color: isSuccessful! ? ColorsTheme.green : ColorsTheme.redSoft));

  @override
  void dispose() {
    scrollController!.dispose();
    super.dispose();
    Get.delete();
  }

  Widget? handlingError() {
    var alertStatus = "".obs;
    alertStatus.value = controller!.resultStatus.value;
    var alertMessage = controller!.resultMsg.value;
    var categoriesMap = controller!.categoriesData!;
    var transactionMap = controller!.transactionData!;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      switch (alertStatus.value) {
        case "transaction_success":
          isLoading.value = false;
          balanceAmount.value = controller!.balanceAmount.value;

          CategoriesModel datamodel = CategoriesModel.fromJson(categoriesMap);
          categoriesList!.value = datamodel.detailsItem!;
          dropdownList!.clear();
          dropdownList!.add("Semua");
          for(var item in datamodel.detailsItem!) {
            dropdownList!.add(item.name!);
          }

          TransactionModel transactionModel = TransactionModel.fromJson(transactionMap);
          GeneralUtils().longPrint('dari page : ${jsonEncode(transactionMap['data'])}');
          
          if (currentPage.value == 1) {
            transactionList.clear();
          }
          
          for(var item in transactionModel.data!) {
            transactionList.add(item);
          }

          if (transactionList.length >= transactionModel.pagination!.totalItems!) {
            hasMore.value = false;
          } else {
            hasMore.value = true;
          }
          isLoadMore.value = false;
          break;
        case "transaction_failure":
          isLoading.value = false;
          isLoadMore.value = false;
          showAlertSnackbar(alertMessage, false);
          break;
        case "categories_remove_success":
          isLoading.value = true;
          Navigator.pop(context);
          showAlertSnackbar(alertMessage, true);
          initData();
          break;
        case "categories_remove_failure":
          Navigator.pop(context);
          showAlertSnackbar(alertMessage, false);
          break;
      }

      controller!.resetResponse();
    });

    return Container();
  }

  doRemoveCategory(int? categoryId) {
    Navigator.pop(context);
    GeneralUtils().customProgressLoading(context);
    controller!.removeCategoryCtrl(categoryId: categoryId);
  }

  Future<void> onLoadData() async {
    isLoading.value = true;
    currentPage.value = 1;
    hasMore.value = true;
    await controller!.getBalanceAmountCtrl(true, token: null);
  }

  Future<void> onLoadMoreData() async {
    isLoadMore.value = true;
    currentPage.value++;
    await controller!.getTransactionDataCtrl(page: currentPage.value);
  }

  @override
  Widget build(BuildContext context) {
    singleLineLabel({label, color, size}) => Text(
          label,
          style: FontTheme.labelStyle1(
              status: "bold", fontSize: size, color: color),
        );

    /////////////////////
    ///FILTER SHORTCUT///
    /////////////////////

    categoryHeaderLabel() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            singleLineLabel(
              label: "Apa yang mau dicatat ?",
              size: 12,
              color: ColorsTheme.black,
            ),
            GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, '/category_form').then((_) {
                isLoading.value = true;
                initData();
              }),
              child: singleLineLabel(
                label: "Tambah Pintasan",
                size: 12,
                color: ColorsTheme.green,
              ),
            )
          ],
        );

    categoryItemList() => SizedBox(
        height: 89.h,
        child: Row(children: [
          ListView.builder(
            itemCount: categoriesList!.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: CustomMenuButton(
                isCategoryData: true,
                categoryItem: categoriesList![index],
                isRoundedShape: true,
                width: 80,
                height: 60,
                action: () => Navigator.pushNamed(context, '/transaction_form',arguments: TransactionArguments(categoriesList,categoriesList![index].name,categoriesList![index].id.toString(),balanceAmount.value)),
                removeAction: (categoryId) => GeneralUtils().customAlertDialog(
                    context,
                    "Apakah Anda Yakin Untuk Melanjutkan Penghapusan ?",
                    () => doRemoveCategory(categoryId)),
              ),
            ),
          ),
          if (categoriesList!.length < 3) Spacer(),
        ]));

    contentCategoryComponent() => Column(
          children: [
            categoryHeaderLabel(),
            GeneralUtils().verticalSpacer(11),
            categoryItemList(),
          ],
        );

    categoryShortcutComponentCard() => Card(
          shape: GeneralUtils().customDecoration(),
          color: ColorsTheme.yellowSoft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 13.h),
            child: contentCategoryComponent(),
          ),
        );

    /////////////////////

    /////////////////////
    ///DROPDOWN FILTER///
    /////////////////////

    dropdownFilter() => DropdownButtonHideUnderline(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 8.w),
            child: CustomDropdownWidget(
              initialValue: initialCategoryName.value,
              itemMenuLabelFilter: dropdownList,
              callback: (value) {
                initialCategoryName.value = value;
              },
          ),
          decoration: GeneralUtils().customBoxStyle1(),
          ),
        );

    contentCategoryFilter() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 150.w,
              child: singleLineLabel(
                label: "Catatan Transaksi Berdasarkan Kategori",
                color: ColorsTheme.white,
                size: 12,
              ),
            ),
            dropdownFilter(),
          ],
        );

    categoryFilterCardComponent() => Card(
          shape: GeneralUtils().customDecoration(),
          color: ColorsTheme.green,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 9.w),
            child: contentCategoryFilter(),
          ),
        );

    /////////////////////

    /////////////////////
    ///ADD TRANSACTION///
    /////////////////////

    btnAction() => Card(
        shape: GeneralUtils().customDecoration(),
        color: ColorsTheme.yellowSoft,
        child: InkWell(
          onTap: () => Navigator.pushNamed(context, '/transaction_form',arguments: TransactionArguments(categoriesList,"Pilih Kategori","",balanceAmount.value)).then((_) {
            isLoading.value = true;
            initData();
          }),
          borderRadius: BorderRadius.circular(10.r),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
            child: Icon(Icons.add_rounded, color: ColorsTheme.green),
          ),
        ));

    contentAddTransaction() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            singleLineLabel(
              label: "Tambah Transaksi",
              color: ColorsTheme.green,
              size: 14,
            ),
            btnAction(),
          ],
        );

    addTransactionComponent() => Padding(
          padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 9.w),
          child: contentAddTransaction(),
        );

    /////////////////////

    //////////////////////
    ///TRANSACTION LIST///
    //////////////////////

    itemList() => ListView.builder(
          controller: scrollController,
          itemCount: transactionList.length + (hasMore.value ? 1 : 0),
          shrinkWrap: true,
          padding: EdgeInsets.only(bottom: 75.h),
          itemBuilder: (context, index) {
            if (index < transactionList.length) {
              return CustomTransactionListWidget(
                transactionItem: transactionList[index],
              );
            } else {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Center(child: CircularProgressIndicator()),
              );
            }
          },
        );

    transactionListComponent() => Card(
        shape: GeneralUtils().customDecoration(),
        color: ColorsTheme.yellowSoft,
        child: Container(
          width: ScreenUtil().screenWidth,
          height: 270.h,
          padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 45.h),
          child: itemList(),
        ));

    stackedView() => SizedBox(
          height: 270.h,
          child: Stack(
            children: [
              transactionListComponent(),
              categoryFilterCardComponent(),
            ],
          ),
        );

    //////////////////////

    appbar() => PreferredSize(
          preferredSize: Size.fromHeight(61.h),
          child: CustomAppBar(
              appLabel: "Transaksi",
              identifier: "transaction",
              balanceAmount: balanceAmount.value,
              isLoading: isLoading.value,
              callback: () => HomeNavigationPage.of(context)!.backIntoHome(0)),
        );

    contentBody() => CustomScrollView(slivers: [
          SliverToBoxAdapter(
              child: Column(
            children: isLoading.value
                ? [
                    CustomShimmerCardWidget(height: 100.h),
                    GeneralUtils().verticalSpacer(20),
                    CustomShimmerCardWidget(height: 200.h),
                  ]
                : [
                    categoryShortcutComponentCard(),
                    GeneralUtils().verticalSpacer(20),
                    addTransactionComponent(),
                    GeneralUtils().verticalSpacer(10),
                    stackedView(),
                  ],
          ))
        ]);

    return SafeArea(
        child: Obx(() => Stack(children: [
              Scaffold(
                body: Padding(
                  padding: EdgeInsets.only(left: 17.w, right: 17.w, top: 29.h),
                  child: RefreshIndicator(
                      child: contentBody(), onRefresh: onLoadData),
                ),
                appBar: appbar(),
              ),
              handlingError()!,
            ])));
  }
}
