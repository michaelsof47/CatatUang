part of 'package:catat_uang/import_url_file.dart';

class CustomBorderFormWidget extends StatelessWidget {
  var widgetCallback;

  CustomBorderFormWidget({
    required this.widgetCallback,
  });

  @override
  Widget build(BuildContext context) {
    baseHeader() => Card(
          shape: GeneralUtils().customDecoration(),
          color: ColorsTheme.yellow,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
            child: Text(
              "Informasi Utama",
              style: FontTheme.labelStyle1(status: "bold",fontSize: 14, color: ColorsTheme.black),
            ),
          ),
        );

    baseBackground() => Card(
          margin: EdgeInsets.zero,
          elevation: 0,
          shape: GeneralUtils().customDecoration(),
          color: ColorsTheme.yellowSoft,
          child: Padding(
            padding: EdgeInsets.fromLTRB(15.w, 24.h, 15.w, 13.h),
            child: widgetCallback!(),
          ),
        );

    return Stack(children: [
      Padding(
        padding: EdgeInsets.only(top: 14.h),
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
