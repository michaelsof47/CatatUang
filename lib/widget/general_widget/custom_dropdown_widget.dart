part of 'package:catat_uang/import_url_file.dart';

class CustomDropdownWidget extends StatelessWidget {
  List<String>? itemMenuLabelFilter;
  Function(String? value) callback;
  String? initialValue;
  customStyle() => FontTheme.labelStyle1(isBold: false,fontSize: 14, color: ColorsTheme.black);

  CustomDropdownWidget({
    required this.itemMenuLabelFilter,
    required this.callback,
    required this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    itemDropdown(String value) => DropdownMenuItem(
          value: value,
          child: Text(value, style: customStyle()),
        );

    itemList() => itemMenuLabelFilter!
        .map<DropdownMenuItem<String>>((value) => itemDropdown(value))
        .toList();

    contentSetTextLabel() => itemMenuLabelFilter!
        .map(
          (value) => Row(children: [
            Text(value, style: customStyle()),
            GeneralUtils.horizontalSpacer(10.w),
          ]),
        )
        .toList();

    return DropdownButton<String>(
      value: initialValue,
      items: itemList(),
      underline: null,
      icon: SvgPicture.asset('assets/icon/ic_dropdown_nav.svg',
          semanticsLabel: 'ic_dropdown_nav'),
      borderRadius: BorderRadius.circular(10.r),
      onChanged: (value) {
        callback(value);
      },
      isDense: true,
      dropdownColor: ColorsTheme.white,
      selectedItemBuilder: (context) => contentSetTextLabel(),
    );
  }
}
