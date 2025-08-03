part of 'package:catat_uang/import_url_file.dart';

class CustomHeaderNoInfoTimeWidget extends StatelessWidget {
  final String? fullName;
  final String? rewardStatus;
  String? imageUrl;
  Key? headerKey;

  CustomHeaderNoInfoTimeWidget({
    required this.fullName,
    required this.rewardStatus,
    required this.imageUrl,
    required this.headerKey,
  });

  @override
  Widget build(BuildContext context) {

     String firstLetter = fullName!.isNotEmpty ? fullName![0].toUpperCase() : '';

    emptyImageProfile() => Text(
          firstLetter,
          style: FontTheme.labelStyle1(
              status: "thin", fontSize: 20, color: ColorsTheme.white),
        );

    profileIcon() => GeneralUtils().avatarBorder(
      child: CircleAvatar(
          radius: 26.r,
          backgroundColor: ColorsTheme.green,
          child: imageUrl != ""
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(26.r),
                  child: Image.network(
                    key: headerKey,
                    imageUrl!,
                    width: 51.w,
                    height: 51.h,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        emptyImageProfile(),
                  ),
                )
              : emptyImageProfile(),
        )
    );

    accountInformation() => Row(children: [
          Text(
            "Reward Status",
            style: FontTheme.labelStyle1(
                status: "thin", fontSize: 12, color: ColorsTheme.black),
          ),
          GeneralUtils().horizontalSpacer(5),
          Text(
            ":",
            style: FontTheme.labelStyle1(
                status: "thin", fontSize: 12, color: ColorsTheme.black),
          ),
          GeneralUtils().horizontalSpacer(5),
          Text(
            rewardStatus!,
            style: FontTheme.labelStyle1(
                status: "bold", fontSize: 12, color: ColorsTheme.black),
          )
        ]);

    return Row(
      children: [
        profileIcon(),
        GeneralUtils().horizontalSpacer(7),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              fullName!,
              style: FontTheme.labelStyle1(
                  status: "bold", fontSize: 16, color: ColorsTheme.black),
            ),
            GeneralUtils().verticalSpacer(3),
            accountInformation(),
          ],
        )
      ],
    );
  }
}
