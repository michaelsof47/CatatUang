part of 'package:catat_uang/import_url_file.dart';

class CustomShortcutMenuWidget extends ConsumerWidget {
  Widget? userInformation;
  List<String>? itemMenuLabelList;
  int? itemMenuHeight;

  CustomShortcutMenuWidget({
    required this.userInformation,
    required this.itemMenuLabelList,
    required this.itemMenuHeight,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    itemMenuList() => SizedBox(
          height: itemMenuHeight!.h,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 100.w,
              mainAxisSpacing: 5.w,
              childAspectRatio: 1,
              crossAxisSpacing: 5.h,
            ),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: itemMenuLabelList!.length,
            itemBuilder: (context, index) => CustomMenuButton(
              menuLabel: itemMenuLabelList![index],
              isRoundedShape: false,
              width: 51,
              height: 51,
              action: () {},
            ),
          ),
        );

    return Card(
      shape: GeneralUtils.customDecoration(),
      color: ColorsTheme.yellowSoft,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
        child: Column(
          children: [
            userInformation!,
            GeneralUtils.customCardLiner(
              color: ColorsTheme.green,
              verticalPad: 9.h,
              horizontalPad: 14.w,
            ),
            itemMenuList(),
          ],
        ),
      ),
    );
  }
}
