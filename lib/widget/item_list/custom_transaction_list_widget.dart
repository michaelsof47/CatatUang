part of 'package:catat_uang/import_url_file.dart';

class CustomTransactionListWidget extends StatelessWidget {
  List<String>? headerLabel = ["Jumlah Transaksi", "Items Termahal", "Outlet"];
  DetailItems? transactionItem;

  int? lastIndex;
  int? totalData;

  CustomTransactionListWidget({
    required this.transactionItem,
  });

  @override
  Widget build(context) {
    singleLineLabel({label, size, color}) => Text(
          label,
          style: FontTheme.labelStyle1(status: "bold",fontSize: size,color: color),
        );

    itemInfoLabel({label, isHeader}) => Text(
          label,
          style: FontTheme.labelStyle1(
            status: isHeader ? "bold" : "thin",
            fontSize: 11,
            color: ColorsTheme.black,
          ),
        );

    itemRowGroup({label, label2, label3}) =>
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            width: 105.w,
            child: itemInfoLabel(label: label, isHeader: true),
          ),
          GeneralUtils().verticalSpacer(2),
          SizedBox(
            width: 5.w,
            child: itemInfoLabel(label: label2, isHeader: true),
          ),
          GeneralUtils().verticalSpacer(2),
          SizedBox(
            width: 100.w,
            child: itemInfoLabel(label: label3, isHeader: false),
          ),
        ]);

    contentItemLabel() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            singleLineLabel(
              label: GeneralUtils().dateTimeFormat(transactionItem!.transactionDate),
              size: 14,
              color: ColorsTheme.black,
            ),
            GeneralUtils().verticalSpacer(2),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                itemRowGroup(
                  label: "Nama Transaksi",
                  label2: ":",
                  label3: transactionItem!.name,
                ),
                GeneralUtils().horizontalSpacer(1),
                itemRowGroup(
                  label: "Nama Outlet",
                  label2: ":",
                  label3: transactionItem!.outletName,
                ),
                GeneralUtils().horizontalSpacer(2),
                itemRowGroup(
                  label: "Total Transaksi",
                  label2: ":",
                  label3: GeneralUtils().currencyFormat(transactionItem!.totalPrice),
                ),
              ],
            ),
          ],
        );

    return Column(children: [
      Padding(
        padding: EdgeInsets.only(bottom: 5.h, top: 10.h),
        child: Row(
          children: [
            Image.asset('assets/image/ic_dummy_outlet.png',
                width: 66.w, height: 57.h),
            GeneralUtils().horizontalSpacer(7),
            contentItemLabel(),
          ],
        ),
      ),
      GeneralUtils().customCardLiner(
              color: ColorsTheme.green,
              horizontalPad: 0.w,
              verticalPad: 0.w,
            ),
    ]);
  }
}
