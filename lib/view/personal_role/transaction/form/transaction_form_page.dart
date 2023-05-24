part of 'package:catat_uang/import_url_file.dart';

class TransactionForm extends ConsumerStatefulWidget {
  @override
  ConsumerState<TransactionForm> createState() => TransactionFormState();
}

class TransactionFormState extends ConsumerState<TransactionForm> {
  TextEditingController? transactionDateInputCtrl;
  TextEditingController? categoryInputCtrl;
  TextEditingController? productNameInputCtrl;
  TextEditingController? itemAmountInputCtrl;
  TextEditingController? productPriceInputCtrl;

  //GLOBAL UTILS
  DateFormat? currentTimeFormat;
  NumberFormat? priceNumberFormat;
  String? currencyFormat;

  @override
  void initState() {
    super.initState();

    initConstructor();
    initData();
  }

  initConstructor() {
    initializeDateFormatting();

    currentTimeFormat = DateFormat("dd MMM yyyy", 'id_ID');
    priceNumberFormat = NumberFormat("#,###");
    currencyFormat =
        NumberFormat.compactSimpleCurrency(locale: 'id_ID').currencySymbol;

    transactionDateInputCtrl = TextEditingController();
    categoryInputCtrl = TextEditingController();
    productNameInputCtrl = TextEditingController();
    itemAmountInputCtrl = TextEditingController();
    productPriceInputCtrl = TextEditingController();
  }

  initData() {
    transactionDateInputCtrl!.text = currentTimeFormat!.format(
      ref.read(currentTime1),
    );
    categoryInputCtrl!.text = "Lain-Lain";
  }

  showDatePickerDialog() async {
    final DateTime? datepicker = await showDatePicker(
      context: context,
      initialDate: ref.read(currentTime1),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );

    if (datepicker != null && datepicker != ref.read(currentTime1)) {
      setState(() {
        ref.read(currentTime1.notifier).update(
              (state) => datepicker,
            );
        transactionDateInputCtrl!.text = currentTimeFormat!.format(
          ref.read(currentTime1),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    appbar() => PreferredSize(
          preferredSize: Size.fromHeight(61.h),
          child: CustomAppBar(appLabel: "Tambah Transaksi"),
        );

    ////////////////////

    itemInputField(label) => GeneralUtils.generalTextFormField(
          controller: label == "Jumlah Item"
              ? itemAmountInputCtrl
              : label == "Harga Produk"
                  ? productPriceInputCtrl
                  : productNameInputCtrl,
          label: label,
          isFinalInput: label == "Harga Produk" ? true : false,
          isEnabled: true,
          decoType: "underline",
          callback: (value) {},
          isNumber:
              label == "Harga Produk" || label == "Jumlah Item" ? true : false,
        );

    currencyItemInputField(label) => GeneralUtils.currencyTextFormField(
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
            string = priceNumberFormat!
                .format(int.parse(string!.replaceAll(',', '')));
            productPriceInputCtrl!.value = TextEditingValue(
              text: string,
              selection: TextSelection.collapsed(offset: string.length),
            );
          },
          callback: (value) {},
          currencyFormat: currencyFormat,
        );

    itemClickableField(label, IconData? icon) =>
        GeneralUtils.generalClickableTextFormField(
          controller: label == "Tanggal Transaksi"
              ? transactionDateInputCtrl
              : categoryInputCtrl,
          label: label,
          isFinalInput: false,
          decoType: "underline",
          callback: () =>
              label == "Tanggal Transaksi" ? showDatePickerDialog() : {},
          icon: icon,
        );

    contentForm() => Column(
          children: [
            itemClickableField(
              "Tanggal Transaksi",
              Icons.calendar_today_outlined,
            ),
            GeneralUtils.verticalSpacer(10),
            itemClickableField(
              "Lain-Lain",
              Icons.arrow_drop_down,
            ),
            GeneralUtils.verticalSpacer(10),
            itemInputField("Nama Produk"),
            GeneralUtils.verticalSpacer(10),
            itemInputField("Jumlah Item"),
            GeneralUtils.verticalSpacer(10),
            currencyItemInputField("Harga Produk"),
            GeneralUtils.verticalSpacer(10),
          ],
        );

    contentBase() => SizedBox(
          width: ScreenUtil().screenWidth,
          height: 260.h,
          child: SingleChildScrollView(
            child: contentForm(),
          ),
        );

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorsTheme.white,
        body: Padding(
          padding: EdgeInsets.only(left: 17.w, right: 17.w, top: 29.h),
          child: CustomBorderFormWidget(widgetCallback: () => contentBase()),
        ),
        bottomNavigationBar: CustomFormActionButtonWidget(),
        appBar: appbar(),
      ),
    );
  }
}
