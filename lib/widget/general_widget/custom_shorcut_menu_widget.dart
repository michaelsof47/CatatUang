part of 'package:catat_uang/import_url_file.dart';

class CustomShortcutMenuWidget extends StatelessWidget {
  Widget? userInformation;
  List<String>? itemMenuLabelList;
  List<String>? itemMenuActionList;
  int? itemMenuHeight;
  Function(int index)? callback;

  CustomShortcutMenuWidget({
    required this.userInformation,
    required this.itemMenuLabelList,
    required this.itemMenuActionList,
    required this.itemMenuHeight,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {

    itemMenuList() => SizedBox(
          height: itemMenuHeight!.h,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 130.w,
              mainAxisSpacing: 5.w,
              childAspectRatio: 0.7,
              crossAxisSpacing: 5.h,
            ),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: itemMenuLabelList!.length,
            itemBuilder: (context, index) => CustomMenuButton(
              isCategoryData: false,
              menuLabel: itemMenuLabelList![index],
              isRoundedShape: false,
              width: 51,
              height: 51,
              action: () => callback!(index)
            ),
          ),
        );

    return Card(
      shape: GeneralUtils().customDecoration(),
      color: ColorsTheme.yellowSoft,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        child: Column(
          children: [
            userInformation!,
            GeneralUtils().customCardLiner(
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
