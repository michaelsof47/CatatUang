part of '../import_url_file.dart';

class GeneralUtils {
  String baseUrl = "https://ed2cd9f454f1.ngrok-free.app";

  horizontalSpacer(double? amount) => SizedBox(width: amount!.w);

  verticalSpacer(double? amount) => SizedBox(height: amount!.h);

  fromHTBPadding({double? h, double? t, double? b}) =>
      EdgeInsets.fromLTRB(h!.w, t!.h, h.w, b!.h);

  avatarBorder({Widget? child}) => Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: ColorsTheme.green,
            width: 2.w,
          )),
      child: child);

  underlineBorder() => UnderlineInputBorder(
        borderSide: BorderSide(
          color: ColorsTheme.green,
          width: 2.w,
        ),
      );

  outlineBorder(borderColor) => OutlineInputBorder(
        borderSide: BorderSide(
          color: borderColor,
          width: 2.w,
        ),
        borderRadius: BorderRadius.circular(10.r),
      );

  underlineDecorationType(label, bool? isPasswordVisible,
          VoidCallback? onPasswordVisible, bool? isPassword) =>
      InputDecoration(
        border: underlineBorder(),
        enabledBorder: underlineBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 6.w),
        hintText: label,
        fillColor: ColorsTheme.white,
        hintStyle: FontTheme.labelHintStyle1(false),
        suffixIcon: isPassword!
            ? IconButton(
                icon: Icon(
                  isPasswordVisible! ? Icons.visibility_off : Icons.visibility,
                  color: ColorsTheme.green,
                ),
                onPressed: () => onPasswordVisible!(),
              )
            : null,
      );

  searchDecorationType(label, color) => InputDecoration(
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

  currencyUnderlineDecoType(label, currencyFormat) => InputDecoration(
      border: underlineBorder(),
      enabledBorder: underlineBorder(),
      contentPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 6.w),
      hintText: label,
      hintStyle: FontTheme.labelHintStyle1(false),
      fillColor: ColorsTheme.white,
      prefix: Padding(
        padding: EdgeInsets.only(right: 5.w),
        child: Text(
          currencyFormat,
          style: FontTheme.labelStyle1(
              status: "bold", fontSize: 12, color: ColorsTheme.black),
        ),
      ));

  borderedDecorationType(label) => InputDecoration(
        border: outlineBorder(ColorsTheme.white),
        enabledBorder: outlineBorder(ColorsTheme.white),
        contentPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
        hintText: label,
        filled: true,
        fillColor: ColorsTheme.white,
        hintStyle: FontTheme.labelHintStyle1(false),
      );

  generalTextFormField({
    TextEditingController? controller,
    String? label,
    bool? isFinalInput,
    bool? isEnabled,
    String? decoType,
    bool? isNumber,
    bool? isPassword,
    Function(String value)? callback,
    VoidCallback? onPasswordVisible,
    bool? isPasswordVisible,
  }) =>
      TextFormField(
        controller: controller,
        cursorColor: ColorsTheme.green,
        readOnly: isEnabled! ? false : true,
        decoration: decoType == "underline"
            ? underlineDecorationType(
                label, isPasswordVisible, onPasswordVisible, isPassword)
            : borderedDecorationType(label),
        style: FontTheme.labelHintStyle1(true),
        inputFormatters: isNumber!
            ? [FilteringTextInputFormatter.digitsOnly, CustomCurrencyFormat()]
            : [],
        onChanged: (value) {
          if (isNumber) {
            String cleanValue = value.replaceAll(RegExp(r'[^0-9]'), '');
            int? intValue = int.tryParse(cleanValue);
          } else {
            //do nothing
          }
        },
        maxLines: 1,
        onFieldSubmitted: (value) =>
            decoType == "underline" ? {} : callback!(value),
        keyboardType: isNumber! ? TextInputType.number : TextInputType.text,
        textInputAction:
            isFinalInput! ? TextInputAction.done : TextInputAction.next,
        obscuringCharacter: "*",
        obscureText: isPassword! ? !isPasswordVisible! : false,
      );

  filterTextFormField({
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

  currencyTextFormField({
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

  generalClickableTextFormField({
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
            ? underlineDecorationType(label, false, () {}, false)
            : borderedDecorationType(label),
        style: FontTheme.labelHintStyle1(true),
      );

  multiTextFormField({
    TextEditingController? controller,
    String? label,
    int? maxLines,
    bool? isFinalInput,
  }) =>
      TextFormField(
        controller: controller,
        cursorColor: ColorsTheme.green,
        decoration: InputDecoration(
          border: outlineBorder(ColorsTheme.green),
          enabledBorder: outlineBorder(ColorsTheme.green),
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

  alertSnackbar({required String? label, required Color? color}) => SnackBar(
        content: Text(label!,
            style: FontTheme.labelStyle1(
                status: "thin", fontSize: 12, color: ColorsTheme.white)),
        backgroundColor: color!,
        duration: const Duration(seconds: 3),
        dismissDirection: DismissDirection.down,
        behavior: SnackBarBehavior.floating,
      );

  customCardLiner({
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

  customHCardLiner({
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

  customDecoration() => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      );

  customBottomSheet() => RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      );

  customBoxStyle1() => BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: ColorsTheme.white,
      );

  customBoxStyleOnlyBorder() => BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: ColorsTheme.green, width: 2.w),
      );

  customProgressLoading(context) => showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => Dialog(
          insetPadding:
              EdgeInsets.symmetric(horizontal: 100.w, vertical: 250.h),
          backgroundColor: ColorsTheme.white,
          elevation: 0.h,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
            side: BorderSide(color: ColorsTheme.yellow, width: 2.w),
          ),
          child: Center(child: CircularProgressIndicator())));

  customAlertDialog(context, VoidCallback? callback) {
    infoLabel(label) => Text(label,
        style: FontTheme.labelStyle1(
            status: "bold", fontSize: 14, color: ColorsTheme.black));

    actionLabel(label, isYes, color) => GestureDetector(
          onTap: () => isYes ? callback!() : Navigator.pop(context),
          child: Text(label,
              style: FontTheme.labelStyle1(
                  status: "bold", fontSize: 14, color: color)),
        );

    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) => Dialog(
            insetPadding:
                EdgeInsets.symmetric(horizontal: 20.w, vertical: 200.h),
            backgroundColor: ColorsTheme.white,
            elevation: 0.h,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
              side: BorderSide(color: ColorsTheme.yellow, width: 2.w),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Column(children: [
                infoLabel("Pemberitahuan"),
                GeneralUtils().verticalSpacer(10),
                SvgPicture.asset(
                  'assets/icon/ic_alert.svg',
                  semanticsLabel: 'ic_alert',
                  width: 100.w,
                  height: 100.h,
                ),
                GeneralUtils().verticalSpacer(10),
                infoLabel("Apakah Anda Yakin Untuk Keluar ?"),
                GeneralUtils().verticalSpacer(20),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  actionLabel("Batal", false, ColorsTheme.redSoft),
                  GeneralUtils().horizontalSpacer(10),
                  actionLabel("Ya", true, ColorsTheme.green)
                ])
              ]),
            )));
  }

  currencyFormat(int? value) => NumberFormat.currency(
        locale: 'id_ID',
        symbol: 'Rp. ',
        decimalDigits: 0,
      ).format(value);

  dateTimeFormat(String? date) =>
      DateFormat('dd MMM yyyy HH:mm').format(DateTime.parse(date!));

  uploadProfileBottomSheet({required BuildContext context,required Function(String)? callback}) {
    contentText(isBold, desc) => TextSpan(
        text: desc,
        style: FontTheme.labelStyle1(
            status: isBold, fontSize: 18, color: ColorsTheme.black));

    itemOnClick(label) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              shape: LayoutTheme.allRoundedRect(radius: 10),
              color: ColorsTheme.googleColor,
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    callback!(label);
                  },
                  child: SizedBox(
                      width: 71.w,
                      height: 51.h,
                      child: Icon(
                          label == "Camera" ? Icons.camera_alt : Icons.image,
                          size: 30.w,
                          color: ColorsTheme.white))),
            ),
            SizedBox(height: 10.h),
            Text(
              label,
              style: FontTheme.labelStyle1(
                  status: "thin", fontSize: 14, color: ColorsTheme.black),
            )
          ],
        );

    actionBottomSheet() => Padding(
          padding: EdgeInsets.fromLTRB(28.w, 10.h, 28.w, 10.h),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [itemOnClick("Camera"), itemOnClick("Galeri")]),
        );

    contentBottomSheet() => Container(
          height: 160.h,
          padding: EdgeInsets.fromLTRB(10.w, 15.h, 10.w, 0.h),
          child: Column(
            children: [
              RichText(
                  text: TextSpan(children: [
                contentText("thin", "Pilih opsi untuk upload "),
                contentText("bold", "foto profilmu"),
              ])),
              actionBottomSheet(),
              InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Text("Kembali",
                      style: FontTheme.labelStyle1(
                          status: "bold",
                          fontSize: 12,
                          color: ColorsTheme.black)))
            ],
          ),
        );

    return showModalBottomSheet(
      context: context,
      shape: LayoutTheme.allRoundedRect(radius: 10),
      builder: (context) => contentBottomSheet(),
      isDismissible: true,
      backgroundColor: ColorsTheme.yellowSoft,
    );
  }
}
