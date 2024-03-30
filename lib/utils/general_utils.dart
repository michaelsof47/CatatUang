part of '../import_url_file.dart';

class GeneralUtils {
  static horizontalSpacer(double? amount) => SizedBox(width: amount!.w);

  static verticalSpacer(double? amount) => SizedBox(height: amount!.h);

  static allAroundPadding(double? verticalAmount, double? horizontalAmount) =>
      EdgeInsets.symmetric(
          vertical: verticalAmount!.h, horizontal: horizontalAmount!.w);

  static fromHTBPadding({double? h,double? t, double? b}) => EdgeInsets.fromLTRB(h!.w, t!.h, h.w, b!.h);

  static symmetricPadding({double? v, double? h}) =>  EdgeInsets.symmetric(vertical: v!.h, horizontal: h!.w);

  static underlineBorder() => UnderlineInputBorder(
        borderSide: BorderSide(
          color: ColorsTheme.green,
          width: 2.w,
        ),
      );

  static outlineBorder(borderColor) => OutlineInputBorder(
        borderSide: BorderSide(
          color: borderColor,
          width: 2.w,
        ),
        borderRadius: BorderRadius.circular(10.r),
      );

  static underlineDecorationType(label, icon) => InputDecoration(
        border: GeneralUtils.underlineBorder(),
        enabledBorder: GeneralUtils.underlineBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 6.w),
        hintText: label,
        fillColor: ColorsTheme.white,
        hintStyle: FontTheme.labelHintStyle1(false),
        suffixIcon: Icon(
          icon,
          color: ColorsTheme.green,
        ),
      );

  static searchDecorationType(label, color) => InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 8.w),
        hintText: label,
        fillColor: color,
        hintStyle: FontTheme.labelHintStyle2(false),
        suffixIcon: Icon(
          Icons.search,
          color: ColorsTheme.green,
        ),
      );

  static currencyUnderlineDecoType(label, currencyFormat) => InputDecoration(
      border: GeneralUtils.underlineBorder(),
      enabledBorder: GeneralUtils.underlineBorder(),
      contentPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 6.w),
      hintText: label,
      hintStyle: FontTheme.labelHintStyle1(false),
      fillColor: ColorsTheme.white,
      prefix: Padding(
        padding: EdgeInsets.only(right: 5.w),
        child: Text(
          currencyFormat,
          style: FontTheme.labelStyle1(
              isBold: true, fontSize: 12, color: ColorsTheme.black),
        ),
      ));

  static borderedDecorationType(label) => InputDecoration(
        border: GeneralUtils.outlineBorder(ColorsTheme.white),
        enabledBorder: GeneralUtils.outlineBorder(ColorsTheme.white),
        contentPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
        hintText: label,
        filled: true,
        fillColor: ColorsTheme.white,
        hintStyle: FontTheme.labelHintStyle1(false),
      );

  static generalTextFormField({
    TextEditingController? controller,
    String? label,
    bool? isFinalInput,
    bool? isEnabled,
    String? decoType,
    bool? isNumber,
    Function(String value)? callback,
  }) =>
      TextFormField(
        controller: controller,
        cursorColor: ColorsTheme.green,
        readOnly: isEnabled! ? false : true,
        decoration: decoType == "underline"
            ? underlineDecorationType(label, null)
            : borderedDecorationType(label),
        style: FontTheme.labelHintStyle1(true),
        maxLines: 1,
        onFieldSubmitted: (value) =>
            decoType == "underline" ? {} : callback!(value),
        keyboardType: isNumber! ? TextInputType.number : TextInputType.text,
        textInputAction:
            isFinalInput! ? TextInputAction.done : TextInputAction.next,
      );

  static filterTextFormField({
    TextEditingController? controller,
    String? label,
    bool? isFinalInput,
    bool? isEnabled,
    Color? color,
    bool? isNumber,
    Function(String value)? callback,
  }) =>
      TextFormField(
        controller: controller,
        cursorColor: ColorsTheme.green,
        readOnly: isEnabled! ? false : true,
        decoration: searchDecorationType(label, color),
        style: FontTheme.labelHintStyle2(true),
        maxLines: 1,
        onFieldSubmitted: (value) => callback!(value),
        keyboardType: isNumber! ? TextInputType.number : TextInputType.text,
        textInputAction:
            isFinalInput! ? TextInputAction.done : TextInputAction.next,
      );

  static currencyTextFormField({
    TextEditingController? controller,
    String? label,
    bool? isFinalInput,
    bool? isEnabled,
    String? decoType,
    String? currencyFormat,
    Function(String v)? inputAction,
    Function(String value)? callback,
  }) =>
      TextFormField(
        controller: controller,
        cursorColor: ColorsTheme.green,
        readOnly: isEnabled! ? false : true,
        onChanged: (string) => inputAction!(string),
        decoration: currencyUnderlineDecoType(label, currencyFormat),
        style: FontTheme.labelHintStyle1(true),
        maxLines: 1,
        keyboardType: TextInputType.number,
        textInputAction:
            isFinalInput! ? TextInputAction.done : TextInputAction.next,
      );

  static generalClickableTextFormField({
    TextEditingController? controller,
    String? label,
    bool? isFinalInput,
    String? decoType,
    Function()? callback,
    IconData? icon,
  }) =>
      TextFormField(
        controller: controller,
        readOnly: true,
        onTap: () => decoType == "underline" ? callback!() : {},
        decoration: decoType == "underline"
            ? underlineDecorationType(label, icon)
            : borderedDecorationType(label),
        style: FontTheme.labelHintStyle1(true),
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
          border: GeneralUtils.outlineBorder(ColorsTheme.green),
          enabledBorder: GeneralUtils.outlineBorder(ColorsTheme.green),
          contentPadding:
              EdgeInsets.only(left: 8.w, top: 10.h, bottom: 10.h, right: 5.w),
          hintText: label,
          hintStyle: FontTheme.labelHintStyle1(false),
        ),
        style: FontTheme.labelHintStyle1(true),
        maxLines: maxLines,
        keyboardType: TextInputType.text,
        textInputAction:
            isFinalInput! ? TextInputAction.done : TextInputAction.next,
      );

  static alertSnackbar({required String? label, required Color? color}) =>
      SnackBar(
        content: Text(label!,
            style: FontTheme.labelStyle1(isBold: false,fontSize: 12, color: ColorsTheme.white)),
        backgroundColor: color!,
        duration: const Duration(seconds: 3),
        dismissDirection: DismissDirection.down,
        behavior: SnackBarBehavior.floating,
      );

  static customCardLiner({
    Color? color,
    double? horizontalPad,
    double? verticalPad,
    double? width,
  }) =>
      Padding(
        padding: EdgeInsets.symmetric(
          vertical: verticalPad!.h,
          horizontal: horizontalPad!.w,
        ),
        child: Container(
          height: 3.h,
          width: width == null ? ScreenUtil().screenWidth : width.w,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5.r),
          ),
        ),
      );

  static customHCardLiner({
    Color? color,
    double? horizontalPad,
    double? verticalPad,
  }) =>
      Padding(
        padding: EdgeInsets.symmetric(
          vertical: verticalPad!.h,
          horizontal: horizontalPad!.w,
        ),
        child: Container(
          width: 3.w,
          height: 82.h,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5.r),
          ),
        ),
      );

  static customDecoration() => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      );

  static customBottomSheet() => RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      );

  static customBoxStyle1() => BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: ColorsTheme.white,
      );

  static customBoxStyleOnlyBorder() => BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: ColorsTheme.green, width: 2.w),
      );
}
