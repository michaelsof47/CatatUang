part of 'package:catat_uang/import_url_file.dart';

class CustomFormActionButtonWidget extends ConsumerWidget {
  String? labelAction;
  VoidCallback? callback;

  CustomFormActionButtonWidget(
    this.labelAction,
    this.callback,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    itemContent() => Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          CustomSingleButtonWidget(
            actionCallback: () => Navigator.pop(context),
            hintLabel: "Batal",
          ),
          GeneralUtils.horizontalSpacer(20),
          CustomSingleButtonWidget(
            actionCallback: () => callback!,
            hintLabel: labelAction,
          ),
        ]);

    return Padding(
      padding: EdgeInsets.fromLTRB(5.w, 0.h, 14.w, 13.h),
      child: itemContent(),
    );
  }
}
