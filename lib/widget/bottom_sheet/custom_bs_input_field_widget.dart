part of 'package:catat_uang/import_url_file.dart';

class CustomBottomSheetInputFieldWidget extends StatelessWidget {
  TextEditingController? inputController;
  Function(String value)? callback;
  String? headerLabel;
  String? hintLabel;
  bool? isNumber;

  CustomBottomSheetInputFieldWidget({
    required this.callback,
    required this.inputController,
    required this.headerLabel,
    required this.hintLabel,
    required this.isNumber,
  });

  @override
  Widget build(BuildContext context) {
    exitBottomSheet() => InkWell(
          onTap: () => Navigator.pop(context),
          child: Text(
            "Batal",
            style: FontTheme.labelStyle1(status: "thin",fontSize: 14, color: ColorsTheme.redSoft),
          ),
        );

    headerContent() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              headerLabel!,
              style: FontTheme.labelStyle1(status: "regular",fontSize: 14, color: ColorsTheme.black),
            ),
            exitBottomSheet(),
          ],
        );

    contentBody() => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            headerContent(),
            GeneralUtils().verticalSpacer(5),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 5.h),
              child: GeneralUtils().generalTextFormField(
                controller: inputController,
                label: hintLabel,
                isEnabled: true,
                isFinalInput: true,
                decoType: "bordered",
                isNumber: isNumber,
                callback: (value) {
                  print("data dari selesai : $value");
                  callback!(value);
                },
                isPassword: false,
              ),
            ),
            GeneralUtils().verticalSpacer(5),
            CustomSingleButtonWidget(
                actionCallback: () {
                  callback!(inputController!.text);
                },
                hintLabel: "Simpan"),
          ],
        );

    return Padding(
      padding: EdgeInsets.fromLTRB(
          12.w, 23.h, 20.w, MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: 130.h,
        child: contentBody(),
      ),
    );
  }
}
