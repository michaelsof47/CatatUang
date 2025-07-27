part of 'package:catat_uang/import_url_file.dart';

class CustomShimmerProfileWidget extends StatelessWidget {

  CustomShimmerProfileWidget();

  @override
  Widget build(BuildContext context) {

    shimmerContent(String type,{int? width, int? height}) => Shimmer.fromColors(
      baseColor: ColorsTheme.grey,
      highlightColor: ColorsTheme.white,
      child: Container(
        width: type == "avatar" ? 70.w : width!.w,
        height: type == "avatar" ? 70.h : height!.h,
        decoration: BoxDecoration(
          color: ColorsTheme.grey,
          shape: type == "avatar" ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: type == "avatar" ? null : BorderRadius.circular(10),
        )
      )
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.w, top: 10.h),
          child: shimmerContent("avatar"),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            shimmerContent("text", width: 150, height: 15),
            GeneralUtils().verticalSpacer(5),
            shimmerContent("text", width: 90, height: 35),
          ]
        )
      ]
    );
  }
}