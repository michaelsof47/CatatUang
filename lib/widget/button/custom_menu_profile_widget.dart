part of 'package:catat_uang/import_url_file.dart';

class CustomMenuProfileWidget extends ConsumerWidget {
  var label;
  var iconLabel;
  Function(String)? callback;

  CustomMenuProfileWidget({
    required this.label,
    required this.iconLabel,
    required this.callback,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    icon1() => SizedBox(
          width: 15.w,
          height: 19.h,
          child: FittedBox(
            fit: BoxFit.cover,
            child: Icon(
              iconLabel,
              color:
                  label == "Keluar" ? ColorsTheme.redSoft : ColorsTheme.green,
            ),
          ),
        );

    itemRow() => Row(children: [
          icon1(),
          GeneralUtils.horizontalSpacer(7),
          Text(
            label,
            style: FontTheme.labelStyle1(isBold: true,fontSize: 14,
                color: label == "Keluar" ? ColorsTheme.redSoft : ColorsTheme.black),
          ),
        ]);

    contentItem() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            itemRow(),
            SvgPicture.asset(
              'assets/icon/ic_nav_right.svg',
              semanticsLabel: 'ic_right',
              width: 15.w,
              height: 25.h,
            ),
          ],
        );

    return Column(children: [
      InkWell(
        onTap: () => callback!(label),
        child: Padding(
          padding: EdgeInsets.fromLTRB(17.w, 6.h, 17.w, 7.h),
          child: contentItem(),
        ),
      ),
      GeneralUtils.customCardLiner(
        color: ColorsTheme.grey,
        horizontalPad: 0.w,
        verticalPad: 0.h,
      )
    ]);
  }
}
