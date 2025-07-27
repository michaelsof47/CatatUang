part of 'package:catat_uang/import_url_file.dart';

class CustomHeaderWidget extends StatefulWidget {
  final String? fullName;
  final String? location;
  final String? greeting;
  final String? userId;

  CustomHeaderWidget({
    required this.fullName,
    required this.userId,
    required this.location,
    required this.greeting,
  });

  State<CustomHeaderWidget> createState() => CustomHeaderWidgetState();
}

class CustomHeaderWidgetState extends State<CustomHeaderWidget> {

  var showGreeting = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      if(mounted) {
        setState(() => showGreeting = false);
      }
    });
  }

  @override
  build(context) {

    String firstLetter = widget.fullName!.isNotEmpty ? widget.fullName![0].toUpperCase() : '';

    emptyImageProfile() => Text(
            firstLetter,
            style: FontTheme.labelStyle1(status: "thin", fontSize: 20, color: ColorsTheme.white),
          );

    profileIcon() => CircleAvatar(
      radius: 35.r,
      backgroundColor: ColorsTheme.green,
      child: widget.userId != null ? ClipOval(
        child: Image.network(
          "${GeneralUtils().baseUrl}/user/${widget.userId}/profile_picture",
          width: 70.w,
          height: 70.h,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => emptyImageProfile(),
        ),
      ) : emptyImageProfile(),
    );

    currentTimeAndLocation() =>
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 5000),
            transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
            child: SizedBox(
              width: 200.w,
              child: showGreeting ? Text(
                key: const ValueKey<bool>(true),
                widget.greeting!,
                style: FontTheme.labelStyle1(status: "bold",fontSize: 15, color: ColorsTheme.black),
                textAlign: TextAlign.end,
              ) : Text(
                key: const ValueKey<bool>(false),
                widget.location!,
                style: FontTheme.labelStyle1(status: "bold",fontSize: 15, color: ColorsTheme.black),
                textAlign: TextAlign.end,
              ),
            ),
          ),
          Text(
            DateFormat("HH:mm").format(DateTime.now()),
            style: FontTheme.labelStyle1(status: "bold",fontSize: 35,color: ColorsTheme.black),
          ),
        ]);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.w, top: 10.h),
          child: profileIcon(),
        ),
        currentTimeAndLocation(),
      ],
    );
  }
}
