part of 'package:catat_uang/import_url_file.dart';

class CustomBottomSheetTwoActionWidget extends ConsumerWidget {
  String? label1;
  String? label2;
  VoidCallback? categoryCallback;
  VoidCallback? transactionCallback;

  CustomBottomSheetTwoActionWidget({
    required this.label1,
    required this.label2,
    required this.categoryCallback,
    required this.transactionCallback,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    exitBottomSheet() => InkWell(
          onTap: () => Navigator.pop(context),
          child: Text(
            "Batal",
            style: FontTheme.labelStyle1(isBold: false,fontSize: 14, color: ColorsTheme.redSoft),
          ),
        );

    headerLabel() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Opsi Pilih Tambah Dokumen",
              style: FontTheme.labelStyle1(isBold: false,fontSize: 14, color: ColorsTheme.black),
            ),
            exitBottomSheet(),
          ],
        );

    itemRow() => Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            CustomMenuButton(
              menuLabel: label1,
              isRoundedShape: true,
              width: 75.w,
              height: 50.h,
              action: () => categoryCallback!(),
            ),
            CustomMenuButton(
              menuLabel: label2,
              isRoundedShape: true,
              width: 75.w,
              height: 50.h,
              action: () => transactionCallback!(),
            ),
          ]),
        );

    contentBody() => Column(
          children: [
            headerLabel(),
            GeneralUtils.verticalSpacer(20),
            itemRow(),
          ],
        );

    return Container(
      width: ScreenUtil().screenWidth,
      height: 200.h,
      padding: EdgeInsets.fromLTRB(12.w, 23.h, 20.w, 18.h),
      child: contentBody(),
    );
  }
}
