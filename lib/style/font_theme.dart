part of 'package:catat_uang/import_url_file.dart';

class FontTheme {
  static labelStyle1({
    required bool? isBold,
    required int? fontSize,
    required Color? color,
  }) =>
      GoogleFonts.mulish(
        fontSize: fontSize!.sp,
        fontWeight: (isBold!) ? FontWeight.w800 : FontWeight.w300,
        color: color,
      );

  static labelHintStyle1(isFilled) => GoogleFonts.mulish(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: isFilled ? ColorsTheme.black : ColorsTheme.black25,
      );

  static labelHintStyle2(isFilled) => GoogleFonts.mulish(
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
        color: isFilled ? ColorsTheme.black : ColorsTheme.black25,
      );

  static versionLabel() => GoogleFonts.mulish(
        fontSize: 10.sp,
        fontWeight: FontWeight.w300,
        color: ColorsTheme.barStatusColor,
      );

  static registerAction(isAction) => GoogleFonts.mulish(
        fontSize: 10.sp,
        fontWeight: isAction ? FontWeight.w500 : FontWeight.w300,
        color: isAction ? ColorsTheme.green : ColorsTheme.black,
      );

  static navigationActionLabel() => GoogleFonts.mulish(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: ColorsTheme.black,
      );

  static navigationHeaderLabel() => GoogleFonts.mulish(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: ColorsTheme.black,
      );
}
