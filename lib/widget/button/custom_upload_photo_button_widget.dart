part of 'package:catat_uang/import_url_file.dart';

class CustomUploadPhotoButtonWidget extends ConsumerWidget {
  String? headerTitle;
  String? headerSubtitle;
  bool? isUploadedPhoto;
  Color? colors;
  Color? colors2;
  bool? isNeedSubtitled;
  int? mode;

  CustomUploadPhotoButtonWidget({
    required this.headerTitle,
    required this.headerSubtitle,
    this.isUploadedPhoto,
    required this.colors,
    required this.colors2,
    required this.isNeedSubtitled,
    required this.mode,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    addImageAction() => Card(
          elevation: 0,
          shape: GeneralUtils.customDecoration(),
          color: colors,
          child: InkWell(
            onTap: () => Navigator.pushNamed(context, '/camera'),
            borderRadius: BorderRadius.circular(10.r),
            child: Container(
              width: 69.w,
              height: 55.h,
              padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 17.w),
              child: Icon(
                Icons.add_rounded,
                color: colors2,
                size: 36.w,
              ),
            ),
          ),
        );

    outletImageDescriptionLabel({String? headerLabel, String? subtitleLabel}) =>
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              headerLabel!,
              style: FontTheme.labelStyle1(isBold: true,fontSize: 14, color: ColorsTheme.black),
            ),
            GeneralUtils.verticalSpacer(5),
            SizedBox(
              width: 200.w,
              child: Text(
                subtitleLabel!,
                style: FontTheme.labelStyle1(isBold: false,fontSize: 10, color: ColorsTheme.black),
              ),
            ),
          ],
        );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        mode == 1 ? addImageAction() : Container(),
        SizedBox(
          width: 200.w,
          child: isNeedSubtitled!
              ? outletImageDescriptionLabel(
                  headerLabel: headerTitle,
                  subtitleLabel: headerSubtitle,
                )
              : Text(
                  headerTitle!,
                  style: FontTheme.labelStyle1(isBold: true,fontSize: 14, color: ColorsTheme.black),
                ),
        ),
        mode == 2 ? addImageAction() : Container(),
      ],
    );
  }
}
