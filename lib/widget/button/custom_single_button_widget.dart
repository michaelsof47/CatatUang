part of 'package:catat_uang/import_url_file.dart';

class CustomSingleButtonWidget extends StatelessWidget {
  final VoidCallback? actionCallback;
  final String? hintLabel;

  CustomSingleButtonWidget({
    required this.actionCallback,
    required this.hintLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3.h,
        shape: GeneralUtils().customDecoration(),
        color: ColorsTheme.yellow,
        child: InkWell(
          onTap: () => actionCallback!(),
          borderRadius: BorderRadius.circular(10.r),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 10.w),
            child: Text(
              hintLabel!,
              style: FontTheme.labelStyle1(
                  status: "bold", fontSize: 14, color: ColorsTheme.black),
            ),
          ),
        ));
  }
}
