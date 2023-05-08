part of 'package:catat_uang/import_url_file.dart';

class CustomHeaderWidget extends ConsumerStatefulWidget {
  final String? fullName;

  CustomHeaderWidget({
    required this.fullName,
  });

  ConsumerState<CustomHeaderWidget> createState() => CustomHeaderWidgetState();
}

class CustomHeaderWidgetState extends ConsumerState<CustomHeaderWidget> {
  @override
  build(context) {
    profileIcon() => Container(
          width: 51.w,
          height: 51.h,
          decoration: BoxDecoration(
            border: Border.all(color: ColorsTheme.yellowHard, width: 3.w),
            image: const DecorationImage(
              image: AssetImage('assets/image/icon2.jpg'),
              fit: BoxFit.fill,
            ),
            shape: BoxShape.circle,
          ),
        );

    userInformation() => Row(
          children: [
            profileIcon(),
            GeneralUtils.horizontalSpacer(7),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Selamat Siang,",
                  style: GeneralStyle.labelStyle1(false, 16, ColorsTheme.black),
                ),
                Text(
                  "Michael Fernando",
                  style: GeneralStyle.labelStyle1(true, 16, ColorsTheme.black),
                ),
              ],
            )
          ],
        );

    currentTimeAndLocation() =>
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(
            "Jakarta, Indonesia",
            style: GeneralStyle.labelStyle1(true, 12, ColorsTheme.black),
          ),
          Text(
            ref.read(currentTime),
            style: GeneralStyle.labelStyle1(true, 30, ColorsTheme.black),
          ),
        ]);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        userInformation(),
        currentTimeAndLocation(),
      ],
    );
  }
}
