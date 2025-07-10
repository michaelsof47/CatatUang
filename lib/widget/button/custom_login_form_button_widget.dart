part of 'package:catat_uang/import_url_file.dart';

class CustomLoginFormButtonWidget extends StatelessWidget {

  String? status;
  Function(String status)? actionCallback;
  String? label;

  Color? palleteButtonColor() {
    switch (status) {
      case "custom":
        return ColorsTheme.googleColor;
      case "general":
        return ColorsTheme.yellow;
    }
  }

  Text? singleLabel({String? label, int? size, bool? isBold, bool? isSocMed}) {
    Color? labelColor = isSocMed! ? ColorsTheme.white : ColorsTheme.black;

    TextStyle? fontTheme = FontTheme.labelStyle1(
        isBold: isBold, fontSize: size!, color: labelColor);

    return Text(label!, style: fontTheme);
  }

  CustomLoginFormButtonWidget({
    required this.status,
    required this.actionCallback,
    this.label,
  });

  @override
  Widget build(BuildContext context) {

    double? paddingWidth = status != "custom" ? 11 : 5;
    String? socialmedLabel = 'Google';
    String? socialMedIcon = 'assets/image/google_logo.png';

    childLabelContent({String? label, bool? isSocMed}) =>
        singleLabel(label: label, size: 14, isBold: true, isSocMed: isSocMed);

    brandingLogo() => Image.asset(socialMedIcon,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
        width: 38.w,
        height: 35.h);

    socialmedContent() => Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Row(children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(5.r), child: brandingLogo()),
          GeneralUtils.horizontalSpacer(35),
          childLabelContent(
              label: "Masuk Dengan $socialmedLabel", isSocMed: true)!
        ]),
    );

    generalContent() => Center(
        child: childLabelContent(
            label: label, isSocMed: false));

    buttonContent() => Container(
          width: ScreenUtil().screenWidth,
          height: 39.h,
          padding: GeneralUtils.allAroundPadding(paddingWidth, 0),
          child: status == "custom" ? socialmedContent() : generalContent(),
        );

    return Card(
        color: palleteButtonColor(), 
        child: InkWell(
            onTap: () => actionCallback!(status!),
            borderRadius: BorderRadius.circular(5.r),
            child: buttonContent()));
  }

}