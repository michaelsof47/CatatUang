part of 'package:catat_uang/import_url_file.dart';

class CustomBottomSheetInputFieldWidget extends ConsumerWidget {
  TextEditingController? inputController;
  Function(String value)? callback;

  CustomBottomSheetInputFieldWidget({
    required this.callback,
    required this.inputController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    exitBottomSheet() => InkWell(
          onTap: () => Navigator.pop(context),
          child: Text(
            "Batal",
            style: FontTheme.labelStyle1(isBold: false,fontSize: 14, color: ColorsTheme.redSoft),
          ),
        );

    headerLabel() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Tambah Buku Proyeksi",
              style: FontTheme.labelStyle1(isBold: false,fontSize: 14, color: ColorsTheme.black),
            ),
            exitBottomSheet(),
          ],
        );

    contentBody() => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            headerLabel(),
            GeneralUtils.verticalSpacer(5),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 5.h),
              child: GeneralUtils.generalTextFormField(
                controller: inputController,
                label: "Nama Buku Proyeksi",
                isEnabled: true,
                isFinalInput: true,
                decoType: "bordered",
                isNumber: false,
                callback: (value) {
                  Navigator.pop(context);
                  callback!(inputController!.text);
                },
              ),
            ),
            GeneralUtils.verticalSpacer(5),
            CustomSingleButtonWidget(
                actionCallback: () {
                  Navigator.pop(context);
                  callback!(inputController!.text);
                },
                hintLabel: "Simpan"),
          ],
        );

    return Padding(
      padding: EdgeInsets.fromLTRB(
          12.w, 23.h, 20.w, MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: 160.h,
        child: contentBody(),
      ),
    );
  }
}
