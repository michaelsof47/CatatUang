part of 'package:catat_uang/import_url_file.dart';

class CustomShimmerCardWidget extends StatelessWidget {

  double height;

  CustomShimmerCardWidget({required this.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorsTheme.grey,
      highlightColor: ColorsTheme.white,
      child: Container(
        height: height!.h,
        width: ScreenUtil().screenWidth,
        decoration: BoxDecoration(
          color: ColorsTheme.white,
          borderRadius: BorderRadius.circular(10),
        )
      )
    );
  }
}