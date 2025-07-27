part of 'package:catat_uang/import_url_file.dart';

class CustomHeaderNoInfoTimeWidget extends StatelessWidget {
  final String? fullName;
  final String? rewardStatus;
  final String? userId;

  CustomHeaderNoInfoTimeWidget({
    required this.fullName,
    required this.rewardStatus,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {

     String firstLetter = fullName!.isNotEmpty ? fullName![0].toUpperCase() : '';

    emptyImageProfile() => Text(
          firstLetter,
          style: FontTheme.labelStyle1(
              status: "thin", fontSize: 20, color: ColorsTheme.white),
        );

    profileIcon() => CircleAvatar(
          radius: 26.r,
          backgroundColor: ColorsTheme.green,
          child: userId != null
              ? ClipOval(
                  child: Image.network(
                    "${GeneralUtils().baseUrl}/user/$userId/profile_picture",
                    width: 51.w,
                    height: 51.h,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        emptyImageProfile(),
                  ),
                )
              : emptyImageProfile(),
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
