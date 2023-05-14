part of 'package:catat_uang/import_url_file.dart';

class CustomDropdownWidget extends ConsumerWidget {
  List<String>? itemMenuLabelFilter;
  Function(String? value) callback;

  customStyle() => GeneralStyle.labelStyle1(false, 14, ColorsTheme.black);

  CustomDropdownWidget({
    required this.itemMenuLabelFilter,
    required this.callback,
  });

  @override
  Widget build(context, ref) {
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
      value: ref.watch(dropdownFilterValue),
      items: itemList(),
      underline: null,
      icon: SvgPicture.asset('assets/icon/ic_dropdown_nav.svg',
          semanticsLabel: 'ic_dropdown_nav'),
      borderRadius: BorderRadius.circular(10.r),
      onChanged: (value) {
        ref.read(dropdownFilterValue.notifier).update((state) => value!);
        callback(value);
      },
      isDense: true,
      dropdownColor: ColorsTheme.white,
      selectedItemBuilder: (context) => contentSetTextLabel(),
    );
  }
}
