part of 'package:catat_uang/import_url_file.dart';

class CustomHeaderWidget extends ConsumerStatefulWidget {
  final String? fullName;
  final String? location;
  final String? conditionStatus;

  CustomHeaderWidget({
    required this.fullName,
    required this.location,
    required this.conditionStatus,
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
                SizedBox(
                  width: 120.w,
                  child: Text(
                    "${widget.conditionStatus},",
                    style:
                        FontTheme.labelStyle1(isBold: false,fontSize: 14, color: ColorsTheme.black),
                  ),
                ),
                SizedBox(
                  width: 100.w,
                  child: Text(
                    "Michael Fernando",
                    style:
                        FontTheme.labelStyle1(isBold: true,fontSize: 16, color: ColorsTheme.black),
                  ),
                ),
              ],
            )
          ],
        );

    currentTimeAndLocation() =>
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          SizedBox(
            width: 135.w,
            child: Text(
              "${widget.location}",
              style: FontTheme.labelStyle1(isBold: true,fontSize: 12, color: ColorsTheme.black),
              textAlign: TextAlign.end,
            ),
          ),
          Text(
            DateFormat("HH:mm").format(DateTime.now()),
            style: FontTheme.labelStyle1(isBold: true,fontSize: 30,color: ColorsTheme.black),
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
