part of 'package:catat_uang/import_url_file.dart';

class CustomFormActionButtonWidget extends StatelessWidget {
  String? labelAction;
  VoidCallback? callback;
  VoidCallback? backCallback;

  CustomFormActionButtonWidget(
    this.labelAction,
    this.callback,
    this.backCallback,
  );

  @override
  Widget build(BuildContext context) {
    itemContent() => Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          CustomSingleButtonWidget(
            actionCallback: () => backCallback!(),
            hintLabel: "Batal",
          ),
          GeneralUtils().horizontalSpacer(20),
          CustomSingleButtonWidget(
            actionCallback: () => callback!(),
            hintLabel: labelAction,
          ),
        ]);

    return Padding(
      padding: EdgeInsets.fromLTRB(5.w, 0.h, 14.w, 13.h),
      child: itemContent(),
    );
  }
}
