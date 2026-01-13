part of 'package:catat_uang/import_url_file.dart';

class CustomMenuButton extends StatelessWidget {
  String? menuLabel;
  bool? isRoundedShape;
  bool? isCategoryData;
  CategoryItem? categoryItem;
  double? width;
  double? height;
  VoidCallback? action;
  Function(int? categoryId)? removeAction;

  CustomMenuButton({
    required this.isCategoryData,
    required this.isRoundedShape,
    required this.width,
    required this.height,
    required this.action,
    this.removeAction,
    this.categoryItem,
    this.menuLabel,
  });

  @override
  Widget build(BuildContext context) {
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
          child: isCategoryData!
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: CachedNetworkImage(
                    imageUrl:
                        "${GeneralUtils().baseUrl}/${categoryItem!.categoryUrlImage}",
                    width: 32.w,
                    height: 32.h,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                        color: ColorsTheme.green,
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(
                      Icons.error,
                      color: ColorsTheme.redSoft,
                    ),
                  ))
              : null,
        );

    contentBody() => Column(children: [
          contentIcon(),
          GeneralUtils().verticalSpacer(5),
          Text(
            isCategoryData! ? categoryItem!.name! : menuLabel!,
            style: FontTheme.labelStyle1(
                status: "bold", fontSize: 11, color: ColorsTheme.black),
            textAlign: TextAlign.center,
          ),
        ]);

    return InkWell(
      onTap: () => action!(),
      onLongPress: () => removeAction!(categoryItem!.id),
      splashColor: ColorsTheme.grey,
      borderRadius: BorderRadius.circular(10.r),
      child: Padding(
        padding: EdgeInsets.all(5.w),
        child: contentBody(),
      ),
    );
  }
}
