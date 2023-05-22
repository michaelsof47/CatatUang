part of 'package:catat_uang/import_url_file.dart';

class NewDocumentWidget extends ConsumerWidget {
  final String? headerLabel;
  final String? descLabel;

  NewDocumentWidget({
    required this.headerLabel,
    required this.descLabel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    emptyDocument() => SizedBox(
        width: 200.w,
        height: 200.h,
        child: Lottie.asset('assets/animation/empty_state.json'));

    return Column(children: [
      emptyDocument(),
      GeneralUtils.verticalSpacer(10),
      Text(
        headerLabel!,
        style: GeneralStyle.labelStyle1(true, 16, ColorsTheme.black),
      ),
      GeneralUtils.verticalSpacer(17),
      Text(
        "Silahkan membuat Buku Proyeksi terlebih dahulu",
        style: GeneralStyle.labelStyle1(false, 14, ColorsTheme.black),
        textAlign: TextAlign.center,
      ),
    ]);
  }
}
