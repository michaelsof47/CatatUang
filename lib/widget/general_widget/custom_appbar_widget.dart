part of 'package:catat_uang/import_url_file.dart';

class CustomAppBar extends StatelessWidget {
  var appLabel;
  VoidCallback? callback;
  var identifier;
  VoidCallback? actionCallback;
  var balanceAmount;
  var isLoading;

  CustomAppBar({
    required this.appLabel,
    required this.identifier,
    required this.callback,
    this.actionCallback,
    this.balanceAmount,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    iconNavBack() => SizedBox(
          width: 15.w,
          height: 25.h,
          child: InkWell(
            onTap: () => callback!(),
            child: SvgPicture.asset(
              'assets/icon/ic_nav_back.svg',
              semanticsLabel: 'ic_nav_back',
            ),
          ),
        );

    normalNavBack() => Row(
          children: [
            iconNavBack(),
            GeneralUtils().horizontalSpacer(13),
            Text(
              appLabel,
              style: FontTheme.navigationHeaderLabel(),
            ),
          ],
        );

    saveButton() => Card(
        shape: GeneralUtils().customDecoration(),
        color: ColorsTheme.yellow,
        elevation: 0.h,
        child: InkWell(
          onTap: () => actionCallback!(),
          splashColor: ColorsTheme.white,
          borderRadius: BorderRadius.circular(10.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 8.h),
            child: Text("Simpan",
                style: FontTheme.labelStyle1(
                    status: "bold", fontSize: 12, color: ColorsTheme.black)),
          ),
        ));

    currentBalances() => Container(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 7.w),
          decoration: BoxDecoration(
            border: Border.all(color: ColorsTheme.green, width: 2.w),
            color: ColorsTheme.white,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.money, color: ColorsTheme.black),
              GeneralUtils().horizontalSpacer(7),
              Text(
                FormatUtils().currencyFormat(balanceAmount),
                style: FontTheme.labelStyle1(
                    status: "bold", fontSize: 12, color: ColorsTheme.black),
              )
            ],
          ),
        );

    return Container(
      width: ScreenUtil().screenWidth,
      color: ColorsTheme.yellowSoft,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 11.h, horizontal: 26.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            normalNavBack(),
            identifier == "transaction"
                ? isLoading
                    ? Container()
                    : currentBalances()
                : identifier == "profile_form"
                    ? saveButton()
                    : Container(),
          ],
        ),
      ),
    );
  }
}
