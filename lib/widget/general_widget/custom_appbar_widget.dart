part of 'package:catat_uang/import_url_file.dart';

class CustomAppBar extends ConsumerWidget {
  var appLabel;

  CustomAppBar({
    required this.appLabel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    iconNavBack() => SizedBox(
          width: 15.w,
          height: 25.h,
          child: InkWell(
            onTap: () {},//=> HomeNavigationPage.of(context)!.backIntoHome(0),
            child: SvgPicture.asset(
              'assets/icon/ic_nav_back.svg',
              semanticsLabel: 'ic_nav_back',
            ),
          ),
        );

    normalNavBack() => Row(
          children: [
            iconNavBack(),
            GeneralUtils.horizontalSpacer(13),
            Text(
              appLabel,
              style: FontTheme.navigationHeaderLabel(),
            ),
          ],
        );

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
              GeneralUtils.horizontalSpacer(7),
              Text(
                "Rp. 250.000",
                style: FontTheme.labelStyle1(
                    isBold: true, fontSize: 12, color: ColorsTheme.black),
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
            appLabel != "Transaksi" ? Container() : currentBalances(),
          ],
        ),
      ),
    );
  }
}
