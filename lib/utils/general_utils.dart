part of '../import_url_file.dart';

class GeneralUtils {
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

  underlineDecorationType(
          {required String? label,
          VoidCallback? onPasswordVisible,
          required bool? isNeedSuffixIcon,
          IconData? iconData,
          bool isPassword = false}) =>
      InputDecoration(
        border: underlineBorder(),
        enabledBorder: underlineBorder(),
        focusedBorder: isPassword ? null : underlineBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 6.w),
        hintText: label,
        fillColor: ColorsTheme.white,
        hintStyle: FontTheme.labelHintStyle1(false),
        suffixIcon: isNeedSuffixIcon!
            ? isPassword
                ? IconButton(
                    icon: Icon(
                      iconData!,
                      color: ColorsTheme.green,
                    ),
                    onPressed: () => onPasswordVisible!(),
                  )
                : Icon(
                    iconData!,
                    color: ColorsTheme.green,
                  )
            : null,
      );

  searchDecorationType(label, color) => InputDecoration(
        border: outlineBorder(color),
        contentPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 8.w),
        hintText: label,
        fillColor: color,
        filled: true,
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
      prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
      prefixIcon: Padding(
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
    required TextEditingController? controller,
    required String? label,
    required bool? isFinalInput,
    required bool? isEnabled,
    required String? decoType,
    required bool? isNumber,
    required bool? isPassword,
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
                label: label,
                onPasswordVisible: onPasswordVisible,
                isNeedSuffixIcon: isPassword,
                iconData: isPasswordVisible!
                    ? Icons.visibility_off
                    : Icons.visibility,
                isPassword: isPassword!)
            : borderedDecorationType(label),
        style: FontTheme.labelHintStyle1(true),
        inputFormatters: isNumber!
            ? [FilteringTextInputFormatter.digitsOnly, CustomCurrencyFormat()]
            : [],
        onChanged: (value) {
          if (isNumber) {
            String cleanValue = value.replaceAll(RegExp(r'[^0-9]'), '');
            int? intValue = int.tryParse(cleanValue);
          } else {}
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
            ? underlineDecorationType(
                label: label,
                onPasswordVisible: null,
                isNeedSuffixIcon: icon != null,
                iconData: icon)
            : borderedDecorationType(label),
        style: FontTheme.labelHintStyle1(true),
      );

  multiTextFormField({
    TextEditingController? controller,
    String? label,
    int? maxLines,
    bool? isFinalInput,
    Function(String value)? callback,
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
        onChanged: (value) => callback!(value),
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

  customAlertDialog(context, String message, VoidCallback? callback) {
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
                EdgeInsets.symmetric(horizontal: 20.w, vertical: 180.h),
            backgroundColor: ColorsTheme.white,
            elevation: 0.h,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
              side: BorderSide(color: ColorsTheme.yellow, width: 2.w),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                infoLabel("Pemberitahuan"),
                GeneralUtils().verticalSpacer(10),
                SvgPicture.asset(
                  'assets/icon/ic_alert.svg',
                  semanticsLabel: 'ic_alert',
                  width: 100.w,
                  height: 100.h,
                ),
                GeneralUtils().verticalSpacer(10),
                infoLabel(message),
                GeneralUtils().verticalSpacer(20),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  actionLabel("Batal", false, ColorsTheme.redSoft),
                  GeneralUtils().horizontalSpacer(10),
                  actionLabel("Ya", true, ColorsTheme.green)
                ])
              ]),
            )));
  }

  customDialogList(context, String title, List<CategoryItem> list,
      Function(CategoryItem)? callback) {
    headerInfo(label) => Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Center(
            child: Text(label,
                style: FontTheme.labelStyle1(
                    status: "bold", fontSize: 14, color: ColorsTheme.white))),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r)),
          color: ColorsTheme.green,
        ));

    itemClickableWidget(CategoryItem item, BuildContext dialogContext) =>
        GestureDetector(
            onTap: () {
              Navigator.of(dialogContext).pop();
              callback!(item);
            },
            child: Column(children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Text(item.name!,
                    style: FontTheme.labelStyle1(
                        status: "regular",
                        fontSize: 14,
                        color: ColorsTheme.black)),
              ),
              Container(height: 2.h, color: ColorsTheme.grey),
            ]));

    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext dialogContext) {
          RxList<CategoryItem> filteredList = List<CategoryItem>.from(list).obs;

          return Obx(() => Dialog(
              insetPadding:
                  EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
              backgroundColor: ColorsTheme.greenNature,
              elevation: 0.h,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r)),
              child: SingleChildScrollView(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  headerInfo(title),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                    child: Column(children: [
                      filterTextFormField(
                          label: "Pilih Kategori",
                          isFinalInput: true,
                          isEnabled: true,
                          color: ColorsTheme.white,
                          isNumber: false,
                          callback: (value) => filteredList.assignAll(list
                              .where((element) => element.name!
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList())),
                      filteredList.isNotEmpty
                          ? ListView.builder(
                              itemCount: filteredList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return itemClickableWidget(
                                    filteredList[index], dialogContext);
                              })
                          : Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.h),
                              child: Center(child: Text("Tidak ada data")),
                            )
                    ]),
                  ),
                ]),
              )));
        });
  }

  uploadProfileBottomSheet(
      {required BuildContext context, required Function(String)? callback}) {
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

  longPrint(Object? object) {
    String str = object.toString();
    while (str.length > 800) {
      print(str.substring(0, 800));
      str = str.substring(800);
    }
    print(str);
  }

  customDatePickerTheme(BuildContext context, Widget? child) {
    return Theme(
      data: Theme.of(context).copyWith(
          datePickerTheme: DatePickerThemeData(
              headerBackgroundColor: ColorsTheme.greenNature,
              headerForegroundColor: ColorsTheme.green,
              dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected))
                  return ColorsTheme.green;
                return null;
              })),
          colorScheme: ColorScheme.light(
            primary: ColorsTheme.green,
            onPrimary: ColorsTheme.white,
            onSurface: ColorsTheme.black,
          )),
      child: child!,
    );
  }

  customTimePickerTheme(BuildContext context, Widget? child) {
    return Theme(
      data: Theme.of(context).copyWith(
        timePickerTheme: TimePickerThemeData(
          backgroundColor: ColorsTheme.white,
          // Gunakan WidgetStateColor, bukan WidgetStateProperty
          hourMinuteColor: WidgetStateColor.resolveWith((states) {
            if (states.contains(WidgetState.selected)) return ColorsTheme.green;
            return ColorsTheme.greenNature;
          }),
          hourMinuteTextColor: WidgetStateColor.resolveWith((states) {
            if (states.contains(WidgetState.selected)) return ColorsTheme.white;
            return ColorsTheme.green;
          }),
          dialHandColor: ColorsTheme.green,
          dialBackgroundColor: ColorsTheme.greenNature,
          dialTextColor: WidgetStateColor.resolveWith((states) {
            if (states.contains(WidgetState.selected)) return ColorsTheme.white;
            return ColorsTheme.black;
          }),
          entryModeIconColor: ColorsTheme.green,
          helpTextStyle: FontTheme.labelStyle1(
              status: "bold", fontSize: 14, color: ColorsTheme.green),
        ),
        colorScheme: ColorScheme.light(
          primary: ColorsTheme.green,
          onPrimary: ColorsTheme.white,
          onSurface: ColorsTheme.black,
        ),
      ),
      child: child!,
    );
  }
}
