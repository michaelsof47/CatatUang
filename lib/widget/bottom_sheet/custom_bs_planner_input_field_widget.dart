part of 'package:catat_uang/import_url_file.dart';

class CustomBSPlannerInputFieldWidget extends StatelessWidget {

  late String headerLabel;
  late TextEditingController booknameInputController;
  late TextEditingController startdateInputController;
  late TextEditingController enddateInputController;
  late TextEditingController currencyInputController;
  late List<String> hintLabels;

  late NumberFormat numberFormat;

  CustomBSPlannerInputFieldWidget({
    required this.headerLabel,
    required this.booknameInputController,
    required this.startdateInputController,
    required this.enddateInputController,
    required this.currencyInputController,
    required this.hintLabels,
  }) {
    this.numberFormat = NumberFormat("#,###");
  }

  @override
  Widget build(BuildContext context) {
    
    exitBottomSheet() => InkWell(
          onTap: () => Navigator.pop(context),
          child: Text(
            "Batal",
            style: FontTheme.labelStyle1(
                status: "thin", fontSize: 14, color: ColorsTheme.redSoft),
          ),
        );

    headerContent() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              headerLabel,
              style: FontTheme.labelStyle1(
                  status: "regular", fontSize: 14, color: ColorsTheme.black),
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
              child: Column(
                children: [
                  GeneralUtils().generalTextFormField(
                    controller: booknameInputController,
                    label: hintLabels[0],
                    isEnabled: true,
                    isFinalInput: false,
                    decoType: "bordered",
                    isNumber: false,
                    callback: (value) {
                    },
                    isPassword: false,
                  ),
                  GeneralUtils().verticalSpacer(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 150.w,
                        child: GeneralUtils().iconClickableTextFormField(
                          controller: startdateInputController,
                          label: hintLabels[1],
                          isEnabled: true,
                          isFinalInput: false,
                          isNumber: false,
                          click_type: "date",
                          color: ColorsTheme.white,
                          callback: (value) {
                          },
                        )
                      ),
                      GeneralUtils().horizontalSpacer(2),
                      Container(
                        width: 150.w,
                        child: GeneralUtils().iconClickableTextFormField(
                          controller: enddateInputController,
                          label: hintLabels[2],
                          isEnabled: true,
                          isFinalInput: false,
                          isNumber: false,
                          click_type: "date",
                          color: ColorsTheme.white,
                          callback: (value) {
                          },
                        ),
                      )
                    ]
                  ),
                  GeneralUtils().verticalSpacer(5),
                  GeneralUtils().currencyTextFormField(
                    controller: currencyInputController,
                    label: hintLabels[3],
                    isEnabled: true,
                    isFinalInput: true,
                    decoType: "currency_compact",
                    currencyFormat: NumberFormat.compactSimpleCurrency(locale: 'id_ID').currencySymbol,
                    callback: (value) {
                    },
                    inputAction: (String? string) {
                      if (string!.isNotEmpty) {
                        string = numberFormat.format(int.parse(string.replaceAll(',', '')));
                        currencyInputController.value = TextEditingValue(
                          text: string,
                          selection: TextSelection.collapsed(offset: string.length),
                        );
                      }
                    }
                  ),
                ]
              )
            ),
            GeneralUtils().verticalSpacer(5),
            CustomSingleButtonWidget(
                actionCallback: () {
                  //callback!(inputController!.text);
                },
                hintLabel: "Simpan"),
          ],
        );

    return Padding(
        padding: EdgeInsets.fromLTRB(
            12.w, 23.h, 20.w, MediaQuery.of(context).viewInsets.bottom + 20.h),
        child: SingleChildScrollView(
          child: contentBody(),
        ));
  }

}