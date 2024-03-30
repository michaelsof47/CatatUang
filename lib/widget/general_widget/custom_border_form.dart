part of 'package:catat_uang/import_url_file.dart';

class CustomBorderFormWidget extends ConsumerWidget {
  var widgetCallback;

  CustomBorderFormWidget({
    required this.widgetCallback,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    baseHeader() => Card(
          shape: GeneralUtils.customDecoration(),
          color: ColorsTheme.yellow,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
            child: Text(
              "Informasi Utama",
              style: FontTheme.labelStyle1(isBold: true,fontSize: 14, color: ColorsTheme.black),
            ),
          ),
        );

    baseBackground() => Card(
          shape: GeneralUtils.customDecoration(),
          color: ColorsTheme.yellowSoft,
          child: Padding(
            padding: EdgeInsets.fromLTRB(15.w, 24.h, 15.w, 5.h),
            child: widgetCallback!(),
          ),
        );

    return Stack(children: [
      Positioned(
        top: 14.h,
        left: 0.w,
        right: 0.w,
        child: baseBackground(),
      ),
      Positioned(
        top: 0.h,
        left: 15.w,
        child: baseHeader(),
      )
    ]);
  }
}
