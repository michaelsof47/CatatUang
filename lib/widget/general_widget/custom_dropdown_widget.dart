part of 'package:catat_uang/import_url_file.dart';

class CustomDropdownWidget extends StatelessWidget {
  List<CategoryItem>? itemMenuLabelFilter;
  Function(CategoryItem value) callback;
  CategoryItem? initialValue;
  customStyle() => FontTheme.labelStyle1(status:"regular",fontSize: 14, color: ColorsTheme.black);

  CustomDropdownWidget({
    required this.itemMenuLabelFilter,
    required this.callback,
    required this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    itemDropdown(CategoryItem value) => DropdownMenuItem<CategoryItem>(
          value: value,
          child: Text(value.name!, style: customStyle()),
        );

    itemList() => itemMenuLabelFilter!
        .map<DropdownMenuItem<CategoryItem>>((CategoryItem value) => itemDropdown(value))
        .toList();

    contentSetTextLabel() => itemMenuLabelFilter!
        .map(
          (value) => Row(children: [
            Text(value.name!, style: customStyle()),
            GeneralUtils().horizontalSpacer(10.w),
          ]),
        )
        .toList();

    return DropdownButton<CategoryItem>(
      value: initialValue,
      items: itemList(),
      underline: null,
      icon: SvgPicture.asset('assets/icon/ic_dropdown_nav.svg',
          semanticsLabel: 'ic_dropdown_nav'),
      borderRadius: BorderRadius.circular(10.r),
      onChanged: (value) {
        callback(value!);
      },
      isDense: true,
      dropdownColor: ColorsTheme.white,
      selectedItemBuilder: (context) => contentSetTextLabel(),
    );
  }
}
