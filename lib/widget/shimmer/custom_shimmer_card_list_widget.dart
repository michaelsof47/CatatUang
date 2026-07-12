part of 'package:catat_uang/import_url_file.dart';

class CustomShimmerCardListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CustomShimmerCardWidget(height: 35.h),
      GeneralUtils().verticalSpacer(40.h),
      ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: 7,
          itemBuilder: (context, index) {
            return Column(children: [
              CustomShimmerCardWidget(height: 50.h),
              GeneralUtils().verticalSpacer(10.h)
            ]);
          })
    ]);
  }
}
