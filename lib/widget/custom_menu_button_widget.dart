part of 'package:catat_uang/import_url_file.dart';

class CustomMenuButton extends ConsumerWidget {
  String? menuLabel;
  bool? isRoundedShape;
  double? width;
  double? height;

  CustomMenuButton({
    required this.menuLabel,
    required this.isRoundedShape,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    circleShape() => BoxDecoration(
          shape: BoxShape.circle,
          color: ColorsTheme.green,
        );

    roundedRectangleShape() => BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: ColorsTheme.grey,
        );

    contentIcon() => Container(
          width: width!.w,
          height: height!.h,
          decoration: isRoundedShape! ? roundedRectangleShape() : circleShape(),
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
