part of 'package:catat_uang/import_url_file.dart';

class CustomTransactionListWidget extends ConsumerWidget {
  List<String>? headerLabel = ["Jumlah Transaksi", "Items Termahal", "Outlet"];
  List<String>? dummyLabel = [
    "Rp.200.000",
    "Daia Detergen 1 Kg",
    "Hypermart PTC"
  ];

  int? lastIndex;
  int? totalData;

  CustomTransactionListWidget({
    required this.totalData,
    required this.lastIndex,
  });

  @override
  Widget build(context, ref) {
    singleLineLabel({label, size, color}) => Text(
          label,
          style: GeneralStyle.labelStyle1(true, size, color),
        );

    itemInfoLabel({label, isHeader}) => Text(
          label,
          style: GeneralStyle.labelStyle1(
            isHeader ? true : false,
            11,
            ColorsTheme.black,
          ),
        );

    itemRowGroup({label, label2, label3}) =>
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            width: 105.w,
            child: itemInfoLabel(label: label, isHeader: true),
          ),
          GeneralUtils.verticalSpacer(2),
          SizedBox(
            width: 5.w,
            child: itemInfoLabel(label: label2, isHeader: true),
          ),
          GeneralUtils.verticalSpacer(2),
          SizedBox(
            width: 100.w,
            child: itemInfoLabel(label: label3, isHeader: false),
          ),
        ]);

    contentItemLabel() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            singleLineLabel(
              label: "Friday, 07 October 2022",
              size: 14,
              color: ColorsTheme.black,
            ),
            GeneralUtils.verticalSpacer(2),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                itemRowGroup(
                  label: "Jumlah Transaksi",
                  label2: ":",
                  label3: "Rp. 250.000,00",
                ),
                GeneralUtils.horizontalSpacer(1),
                itemRowGroup(
                  label: "Items Termahal",
                  label2: ":",
                  label3: "Daia Detergen 1 Kg",
                ),
                GeneralUtils.horizontalSpacer(2),
                itemRowGroup(
                  label: "Outlet",
                  label2: ":",
                  label3: "Hypermart PTC",
                ),
              ],
            ),
          ],
        );

    return Column(children: [
      Padding(
        padding: EdgeInsets.only(bottom: 5.h, top: lastIndex == 1 ? 0.h : 10.h),
        child: Row(
          children: [
            Image.asset('assets/image/ic_dummy_outlet.png',
                width: 66.w, height: 57.h),
            GeneralUtils.horizontalSpacer(7),
            contentItemLabel(),
          ],
        ),
      ),
      totalData == lastIndex
          ? Container()
          : GeneralUtils.customCardLiner(
              color: ColorsTheme.green,
              horizontalPad: 0.w,
              verticalPad: 0.w,
            ),
    ]);
  }
}
