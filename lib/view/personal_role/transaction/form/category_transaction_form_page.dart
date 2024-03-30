part of 'package:catat_uang/import_url_file.dart';

class CategoryTransactionForm extends ConsumerStatefulWidget {
  @override
  ConsumerState<CategoryTransactionForm> createState() =>
      CategoryTransactionFormState();
}

class CategoryTransactionFormState
    extends ConsumerState<CategoryTransactionForm> {
  @override
  Widget build(BuildContext context) {
    appbar() => PreferredSize(
          preferredSize: Size.fromHeight(61.h),
          child: CustomAppBar(appLabel: "Tambah Kategori"),
        );

    ////////////////////

    contentForm() => Column(
          children: [
            CustomUploadPhotoButtonWidget(
              headerTitle: "Tambah Gambar Kategori Produk",
              headerSubtitle:
                  "Ketentuan : Minimal Foto yang di upload adalah 500 x 500 px",
              colors: ColorsTheme.white,
              colors2: ColorsTheme.green,
              isNeedSubtitled: true,
              mode: 1,
            ),
            GeneralUtils.verticalSpacer(21),
            GeneralUtils.generalTextFormField(
              controller: TextEditingController(),
              label: "Nama Kategori",
              isFinalInput: false,
              isEnabled: true,
              decoType: "underline",
              callback: (value) {},
              isNumber: false,
            ),
            GeneralUtils.verticalSpacer(19),
            GeneralUtils.multiTextFormField(
              controller: TextEditingController(),
              label: "Deskripsi",
              maxLines: 5,
              isFinalInput: true,
            ),
          ],
        );

    contentBase() => SizedBox(
          width: ScreenUtil().screenWidth,
          height: 260.h,
          child: SingleChildScrollView(
            child: contentForm(),
          ),
        );

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorsTheme.white,
        body: Padding(
          padding: EdgeInsets.only(left: 17.w, right: 17.w, top: 29.h),
          child: CustomBorderFormWidget(widgetCallback: () => contentBase()),
        ),
        bottomNavigationBar: CustomFormActionButtonWidget(
          "Simpan",
          () {},
        ),
        appBar: appbar(),
      ),
    );
  }
}
