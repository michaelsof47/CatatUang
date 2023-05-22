part of 'package:catat_uang/import_url_file.dart';

class TransactionForm extends ConsumerStatefulWidget {
  @override
  ConsumerState<TransactionForm> createState() => TransactionFormState();
}

class TransactionFormState extends ConsumerState<TransactionForm> {
  @override
  Widget build(BuildContext context) {
    appbar() => PreferredSize(
          preferredSize: Size.fromHeight(61.h),
          child: CustomAppBar(appLabel: "Tambah Transaksi"),
        );

    ////////////////////

    itemInputField(label) => GeneralUtils.generalTextFormField(
          controller: TextEditingController(),
          label: label,
          isFinalInput: label == "Harga Produk" ? true : false,
          isEnabled: true,
          decoType: "underline",
          callback: (value) {},
          isNumber:
              label == "Harga Produk" || label == "Jumlah Item" ? true : false,
        );

    itemClickableField(label, IconData? icon) =>
        GeneralUtils.generalClickableTextFormField(
          controller: TextEditingController(),
          label: label,
          isFinalInput: label == "Harga Produk" ? true : false,
          decoType: "underline",
          callback: () {},
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
            itemInputField("Harga Produk"),
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
