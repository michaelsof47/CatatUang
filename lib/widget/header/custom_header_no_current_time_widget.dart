part of 'package:catat_uang/import_url_file.dart';

class CustomHeaderNoInfoTimeWidget extends ConsumerWidget {
  final String? fullName;
  final String? statusInformation;

  CustomHeaderNoInfoTimeWidget({
    required this.fullName,
    required this.statusInformation,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    profileIcon() => Container(
          width: 51.w,
          height: 51.h,
          decoration: BoxDecoration(
            border: Border.all(color: ColorsTheme.yellowHard, width: 3.w),
            image: const DecorationImage(
              image: AssetImage('assets/image/icon2.jpg'),
              fit: BoxFit.fill,
            ),
            shape: BoxShape.circle,
          ),
        );

    accountInformation() => Row(children: [
          Text(
            "Status Information",
            style: GeneralStyle.labelStyle1(false, 12, ColorsTheme.black),
          ),
          GeneralUtils.horizontalSpacer(5),
          Text(
            ":",
            style: GeneralStyle.labelStyle1(false, 12, ColorsTheme.black),
          ),
          GeneralUtils.horizontalSpacer(5),
          Text(
            statusInformation!,
            style: GeneralStyle.labelStyle1(true, 12, ColorsTheme.black),
          )
        ]);

    return Row(
      children: [
        profileIcon(),
        GeneralUtils.horizontalSpacer(7),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Michael Fernando",
              style: GeneralStyle.labelStyle1(true, 16, ColorsTheme.black),
            ),
            GeneralUtils.verticalSpacer(3),
            accountInformation(),
          ],
        )
      ],
    );
  }
}
