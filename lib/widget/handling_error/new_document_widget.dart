part of 'package:catat_uang/import_url_file.dart';

class NewDocumentWidget extends ConsumerWidget {
  final String? moduleType;
  final String? headerLabel;
  final String? descLabel;

  NewDocumentWidget({
    required this.moduleType,
    required this.headerLabel,
    required this.descLabel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    emptyDocument() => SizedBox(
        width: 200.w,
        height: 200.h,
        child: Lottie.asset(
          moduleType == "pos"
              ? 'assets/animation/empty_cart.json'
              : 'assets/animation/empty_state.json',
        ));

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      emptyDocument(),
      GeneralUtils.verticalSpacer(10),
      Text(
        headerLabel!,
        style: FontTheme.labelStyle1(isBold: true,fontSize: 16,color: ColorsTheme.black),
        textAlign: TextAlign.center,
      ),
      GeneralUtils.verticalSpacer(17),
      Text(
        descLabel!,
        style: FontTheme.labelStyle1(isBold: false,fontSize: 14,color: ColorsTheme.black),
        textAlign: TextAlign.center,
      ),
    ]);
  }
}
