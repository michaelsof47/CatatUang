part of '../import_url_file.dart';

class GeneralStyle {
  static labelStyle1(isBold, int? fontSize, color) => GoogleFonts.mulish(
        fontSize: fontSize!.sp,
        fontWeight: (isBold) ? FontWeight.w800 : FontWeight.w300,
        color: color,
      );

  static labelHintStyle1(isFilled) => GoogleFonts.mulish(
        fontSize: 16.sp,
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
