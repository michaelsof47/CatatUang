part of 'package:catat_uang/import_url_file.dart';

class TransactionFormBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionController>(() => TransactionController());
  }
}

class TransactionForm extends StatefulWidget {
  @override
  State<TransactionForm> createState() => TransactionFormState();
}

class TransactionFormState extends State<TransactionForm> {
  TextEditingController? transactionDateInputCtrl;
  TextEditingController? categoryInputCtrl;
  TextEditingController? productNameInputCtrl;
  TextEditingController? itemAmountInputCtrl;
  TextEditingController? productPriceInputCtrl;
  TextEditingController? outletNameInputCtrl;
  TransactionController? controller;

  //GLOBAL UTILS
  DateFormat? currentTimeFormat;
  NumberFormat? priceNumberFormat;
  String? currencyFormat;
  var transactionDate;
  var categoryId;
  var isTyping;
  var balanceAmount;

  RxList<CategoryItem> categoriesList = <CategoryItem>[].obs;

  @override
  void initState() {
    super.initState();

    initConstructor();
    initData();
  }

  showAlertSnackbar(String? label, bool? isSuccessful) =>
      ScaffoldMessenger.of(context).showSnackBar(GeneralUtils().alertSnackbar(
          label: label,
          color: isSuccessful! ? ColorsTheme.green : ColorsTheme.redSoft));

  initConstructor() {
    priceNumberFormat = NumberFormat("#,###");
    currencyFormat =
        NumberFormat.compactSimpleCurrency(locale: 'id_ID').currencySymbol;

    controller = Get.find<TransactionController>();

    transactionDateInputCtrl = TextEditingController();
    categoryInputCtrl = TextEditingController();
    outletNameInputCtrl = TextEditingController();
    productNameInputCtrl = TextEditingController();
    itemAmountInputCtrl = TextEditingController();
    productPriceInputCtrl = TextEditingController();

    transactionDate = "".obs;
    categoryId = "".obs;
    isTyping = false.obs;
    balanceAmount = 0.obs;

    outletNameInputCtrl!.addListener(() => detectTyping());
    productNameInputCtrl!.addListener(() => detectTyping());
    itemAmountInputCtrl!.addListener(() => detectTyping());
    productPriceInputCtrl!.addListener(() => detectTyping());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      var modalRoute =
          ModalRoute.of(context)!.settings.arguments as TransactionArguments;

      categoriesList.clear();
      for (var element in modalRoute.categories!) {
        categoriesList.add(element);
      }

      categoryId.value = modalRoute.initCategoryId!;
      print("categoryId : $categoryId");

      setState(() {
        categoryInputCtrl!.text =
            modalRoute.initialCategoryName! ?? "Lain-Lain";
        balanceAmount.value = modalRoute.budget!;
      });
    });
  }

  @override
  void dispose() {
    transactionDateInputCtrl!.dispose();
    categoryInputCtrl!.dispose();
    outletNameInputCtrl!.dispose();
    productNameInputCtrl!.dispose();
    itemAmountInputCtrl!.dispose();
    productPriceInputCtrl!.dispose();
    super.dispose();
  }

  initData() {
    String now = DateTime.now().toString();
    transactionDateInputCtrl!.text = GeneralUtils().dateFormat(now);
    transactionDate.value = now;
  }

  showDatePickerDialog() async {
    final DateTime? datepicker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialEntryMode: DatePickerEntryMode.calendar,
    );

    if (datepicker != null) {
      final TimeOfDay? timepicker = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (timepicker != null) {
        final DateTime combinedDateTime = DateTime(
          datepicker.year,
          datepicker.month,
          datepicker.day,
          timepicker.hour,
          timepicker.minute,
        );

        transactionDate.value = combinedDateTime.toString();
        setState(() => transactionDateInputCtrl!.text =
            GeneralUtils().dateTimeFormat(combinedDateTime.toString()));
      }
    }
  }

  validateForm() async {
    if (outletNameInputCtrl!.text.isEmpty) {
      showAlertSnackbar("Nama outlet tidak boleh kosong", false);
    } else if (productNameInputCtrl!.text.isEmpty) {
      showAlertSnackbar("Nama produk tidak boleh kosong", false);
    } else if (itemAmountInputCtrl!.text.isEmpty) {
      showAlertSnackbar("Jumlah item tidak boleh kosong", false);
    } else if (productPriceInputCtrl!.text.isEmpty) {
      showAlertSnackbar("Harga produk tidak boleh kosong", false);
    } else {
      GeneralUtils().customProgressLoading(context);
      print("tanggal: ${transactionDate.value}");
      await controller!.addTransactionCtrl(map: {
        "trans_date": transactionDate.value,
        "trans_outlet": outletNameInputCtrl!.text,
        "trans_category": categoryId.value,
        "trans_name": productNameInputCtrl!.text,
        "trans_amount":
            itemAmountInputCtrl!.text.replaceAll(RegExp(r'[^0-9]'), ''),
        "trans_price":
            productPriceInputCtrl!.text.replaceAll(RegExp(r'[^0-9]'), ''),
      });
    }
  }

  detectTyping() {
    isTyping.value = outletNameInputCtrl!.text.isNotEmpty ||
        productNameInputCtrl!.text.isNotEmpty ||
        itemAmountInputCtrl!.text.isNotEmpty ||
        productPriceInputCtrl!.text.isNotEmpty;
    setState(() {});
  }

  int calculateSubtotalPrice() {
    var priceText = productPriceInputCtrl!.text;
    var amountText = itemAmountInputCtrl!.text;

    var priceConvert = priceText.replaceAll(RegExp(r'[^0-9]'), '');
    var amountConvert = amountText.replaceAll(RegExp(r'[^0-9]'), '');

    if (priceConvert.isEmpty || amountConvert.isEmpty) {
      return 0;
    }

    return int.parse(priceConvert) * int.parse(amountConvert);
  }

  int calculateBalance() {
    return balanceAmount.value - calculateSubtotalPrice();
  }

  Widget? handlingError() {
    var alertStatus = controller!.resultStatus.value;
    var alertMessage = controller!.resultMessage.value;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      switch (alertStatus) {
        case "transaction_failure":
          Navigator.pop(context);
          showAlertSnackbar(alertMessage, false);
          break;
        case "transaction_success":
          showAlertSnackbar(alertMessage, true);
          Navigator.pop(context);
          Navigator.pop(context);
          break;
      }
      controller!.resetResponse();
    });

    return const SizedBox.shrink();
  }

  popScope() async => await GeneralUtils()
          .customAlertDialog(context, "Apakah Anda Yakin Untuk Keluar ?", () {
        Navigator.pop(context);
        Navigator.pop(context);
      });

  @override
  Widget build(BuildContext context) {
    appbar() => PreferredSize(
          preferredSize: Size.fromHeight(61.h),
          child: CustomAppBar(
              appLabel: "Tambah Transaksi",
              identifier: "",
              callback: () =>
                  isTyping.value ? popScope() : Navigator.pop(context)),
        );

    itemInputField(label) => GeneralUtils().generalTextFormField(
          controller: label == "Jumlah Item"
              ? itemAmountInputCtrl
              : label == "Harga Produk"
                  ? productPriceInputCtrl
                  : label == "Nama Outlet"
                      ? outletNameInputCtrl
                      : productNameInputCtrl,
          label: label,
          isFinalInput: label == "Harga Produk" ? true : false,
          isEnabled: true,
          decoType: "underline",
          callback: (value) {},
          isNumber:
              label == "Harga Produk" || label == "Jumlah Item" ? true : false,
          isPassword: false,
          isPasswordVisible: false,
        );

    currencyItemInputField(label) => GeneralUtils().currencyTextFormField(
          controller: label == "Jumlah Item"
              ? itemAmountInputCtrl
              : label == "Harga Produk"
                  ? productPriceInputCtrl
                  : productNameInputCtrl,
          label: label,
          isFinalInput: label == "Harga Produk" ? true : false,
          isEnabled: true,
          decoType: "underline",
          inputAction: (String? string) {
            if (string!.isNotEmpty) {
              string = priceNumberFormat!
                  .format(int.parse(string.replaceAll(',', '')));
              productPriceInputCtrl!.value = TextEditingValue(
                text: string,
                selection: TextSelection.collapsed(offset: string.length),
              );
            }
          },
          callback: (value) {},
          currencyFormat: currencyFormat,
        );

    itemClickableField(label, IconData? icon) =>
        GeneralUtils().generalClickableTextFormField(
          controller: label == "Tanggal Transaksi"
              ? transactionDateInputCtrl
              : categoryInputCtrl,
          label: label,
          isFinalInput: false,
          decoType: "underline",
          callback: label == "Tanggal Transaksi"
              ? () => showDatePickerDialog()
              : () => GeneralUtils().customDialogList(
                    context,
                    "Pilih Tipe Kategori",
                    categoriesList,
                    (value) {
                      categoryId.value = value.id.toString();
                      setState(() => categoryInputCtrl!.text = value.name!);
                    },
                  ),
          icon: icon,
        );

    subtitleInfoBudget(String? label, int? amount, bool? isOutput) =>
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(label!,
              style: FontTheme.labelStyle1(
                  status: "thin", fontSize: 12, color: ColorsTheme.black)),
          Text(GeneralUtils().currencyFormat(amount),
              style: FontTheme.labelStyle1(
                  status: "bold",
                  fontSize: 12,
                  color: isOutput! ? ColorsTheme.redSoft : ColorsTheme.green))
        ]);

    contentForm() => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            itemClickableField(
              "Tanggal Transaksi",
              Icons.calendar_today_outlined,
            ),
            GeneralUtils().verticalSpacer(10),
            itemClickableField(
              "Pilih Kategori",
              Icons.arrow_drop_down,
            ),
            GeneralUtils().verticalSpacer(10),
            itemInputField("Nama Outlet"),
            GeneralUtils().verticalSpacer(10),
            itemInputField("Nama Produk"),
            GeneralUtils().verticalSpacer(10),
            itemInputField("Jumlah Item"),
            GeneralUtils().verticalSpacer(10),
            currencyItemInputField("Harga Produk"),
          ],
        );

    budgetInfoCard() => Card(
        shape: GeneralUtils().customDecoration(),
        color: ColorsTheme.yellow,
        child: Container(
          width: ScreenUtil().screenWidth,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Proyeksi Transaksi",
                  style: FontTheme.labelStyle1(
                      status: "bold", fontSize: 14, color: ColorsTheme.black)),
              GeneralUtils().verticalSpacer(5.h),
              subtitleInfoBudget("Budget Awal", balanceAmount.value, false),
              subtitleInfoBudget(
                  "Subtotal Pengeluaran", calculateSubtotalPrice(), true),
              GeneralUtils().verticalSpacer(10.h),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("Sisa Budget"),
                Text(GeneralUtils().currencyFormat(calculateBalance()),style: FontTheme.labelStyle1(status: "bold", fontSize: 14, color: calculateBalance() < 0 ? ColorsTheme.redSoft : ColorsTheme.green),)
              ])
            ],
          ),
        ));

    contentBase() => Padding(
          padding: EdgeInsets.only(left: 17.w, right: 17.w, top: 29.h),
          child: Column(
            children: [
              SizedBox(
                width: ScreenUtil().screenWidth,
                child: CustomBorderFormWidget(
                  widgetCallback: () => contentForm(),
                ),
              ),
              GeneralUtils().verticalSpacer(30.h),
              budgetInfoCard(),
            ],
          ),
        );

    return Obx(() => WillPopScope(
        onWillPop: () async => isTyping.value ? popScope() : true,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: ColorsTheme.white,
            appBar: appbar(),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: contentBase(),
                  ),
                ),
                handlingError()!,
              ],
            ),
            bottomNavigationBar: CustomFormActionButtonWidget(
              "Simpan",
              () => validateForm(),
              () => isTyping.value ? popScope() : true,
            ),
          ),
        )));
  }
}
