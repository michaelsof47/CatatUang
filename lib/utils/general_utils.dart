part of '../import_url_file.dart';

class GeneralUtils {
  static horizontalSpacer(double? amount) => SizedBox(width: amount!.w);

  static verticalSpacer(double? amount) => SizedBox(height: amount!.h);

  static allAroundPadding(double? verticalAmount, double? horizontalAmount) =>
      EdgeInsets.symmetric(
          vertical: verticalAmount!.h, horizontal: horizontalAmount!.w);

  static underlineBorder() => UnderlineInputBorder(
        borderSide: BorderSide(
          color: ColorsTheme.green,
          width: 2.w,
        ),
      );

  static outlineBorder() => OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorsTheme.green,
          width: 2.w,
        ),
        borderRadius: BorderRadius.circular(10.r),
      );

  static generalTextFormField({
    TextEditingController? controller,
    String? label,
    bool? isFinalInput,
    bool? isEnabled,
  }) =>
      TextFormField(
        controller: controller,
        cursorColor: ColorsTheme.green,
        readOnly: isEnabled! ? false : true,
        decoration: InputDecoration(
          border: GeneralUtils.underlineBorder(),
          enabledBorder: GeneralUtils.underlineBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 6.w),
          hintText: label,
          hintStyle: GeneralStyle.labelHintStyle1(false),
        ),
        style: GeneralStyle.labelHintStyle1(true),
        maxLines: 1,
        keyboardType: TextInputType.text,
        textInputAction:
            isFinalInput! ? TextInputAction.done : TextInputAction.next,
      );

  static multiTextFormField({
    TextEditingController? controller,
    String? label,
    int? maxLines,
    bool? isFinalInput,
  }) =>
      TextFormField(
        controller: controller,
        cursorColor: ColorsTheme.green,
        decoration: InputDecoration(
          border: GeneralUtils.outlineBorder(),
          enabledBorder: GeneralUtils.outlineBorder(),
          contentPadding:
              EdgeInsets.only(left: 8.w, top: 10.h, bottom: 10.h, right: 5.w),
          hintText: label,
          hintStyle: GeneralStyle.labelHintStyle1(false),
        ),
        style: GeneralStyle.labelHintStyle1(true),
        maxLines: maxLines,
        keyboardType: TextInputType.text,
        textInputAction:
            isFinalInput! ? TextInputAction.done : TextInputAction.next,
      );

  static alertSnackbar(label) => SnackBar(
        content: Text(label,
            style: GeneralStyle.labelStyle1(false, 12, ColorsTheme.white)),
        backgroundColor: ColorsTheme.black,
        duration: const Duration(seconds: 3),
        dismissDirection: DismissDirection.down,
        behavior: SnackBarBehavior.floating,
      );
}
