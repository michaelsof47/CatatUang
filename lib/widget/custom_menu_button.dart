part of 'package:catat_uang/import_url_file.dart';

class CustomMenuButton extends ConsumerWidget {
  String? menuLabel;

  CustomMenuButton({
    required this.menuLabel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    contentIcon() => Container(
          width: 51.w,
          height: 51.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorsTheme.green,
          ),
        );

    contentBody() => Column(children: [
          contentIcon(),
          GeneralUtils.verticalSpacer(5),
          Text(
            menuLabel!,
            style: GeneralStyle.labelStyle1(true, 11, ColorsTheme.black),
          ),
        ]);

    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(10.r),
      child: contentBody(),
    );
  }
}
