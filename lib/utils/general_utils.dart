part of '../import_url_file.dart';

class GeneralUtils {
  static horizontalSpacer(double? amount) => SizedBox(width: amount!.w);

  static verticalSpacer(double? amount) => SizedBox(height: amount!.h);

  static allAroundPadding(double? verticalAmount, double? horizontalAmount) =>
      EdgeInsets.symmetric(
          vertical: verticalAmount!.h, horizontal: horizontalAmount!.w);

  static outlineBorder() => UnderlineInputBorder(
        borderSide: BorderSide(
          color: ColorsTheme.green,
          width: 2.w,
        ),
      );

  static generalTextFormField(controller) => TextFormField(
        controller: controller,
        cursorColor: ColorsTheme.green,
        decoration: InputDecoration(
          border: GeneralUtils.outlineBorder(),
          enabledBorder: GeneralUtils.outlineBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 6.w),
          hintText: "Email / No. Telp",
          hintStyle: GeneralStyle.labelHintStyle1(false),
        ),
        style: GeneralStyle.labelHintStyle1(true),
        maxLines: 1,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
      );
}
