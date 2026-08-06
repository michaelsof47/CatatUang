part of 'package:catat_uang/import_url_file.dart';

class CategoryFormBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionServiceInterface>(() => TransactionService());
    Get.lazyPut<LocalManager>(() => LocalManager());

    Get.lazyPut<TransactionController>(() => TransactionController(
          localManager: Get.find<LocalManager>(),
          service: Get.find<TransactionServiceInterface>(),
        ));
  }
}

class CategoryForm extends StatefulWidget {
  @override
  State<CategoryForm> createState() => CategoryFormState();
}

class CategoryFormState extends State<CategoryForm> {
  File? imageFile;
  TextEditingController? categoryNameCtrl;
  TextEditingController? descriptionCtrl;
  TransactionController? controller;
  var isTyping;

  @override
  initState() {
    super.initState();
    categoryNameCtrl = TextEditingController();
    descriptionCtrl = TextEditingController();
    controller = Get.find<TransactionController>();
    isTyping = false.obs;

    categoryNameCtrl!.addListener(() => detectTyping());
    descriptionCtrl!.addListener(() => detectTyping());
  }

  @override
  void dispose() {
    categoryNameCtrl!.dispose();
    descriptionCtrl!.dispose();
    imageFile = null;
    super.dispose();
  }

  detectTyping() {
    if (categoryNameCtrl!.text.isNotEmpty ||
        descriptionCtrl!.text.isNotEmpty ||
        imageFile != null) {
      isTyping.value = true;
    } else {
      isTyping.value = false;
    }
  }

  showAlertSnackbar(String? label, bool? isSuccessful) =>
      ScaffoldMessenger.of(context).showSnackBar(GeneralUtils().alertSnackbar(
          label: label,
          color: isSuccessful! ? ColorsTheme.green : ColorsTheme.redSoft));

  //Take an image or Capture from camera (temporary)
  Future<void> pickImageFunction(bool isCamera) async {
    final XFile? image = await ImagePicker()
        .pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery);

    if (image != null) {
      setState(() => imageFile = File(image.path));
    } else {
      showAlertSnackbar("Tidak ada gambar yang dipilih", false);
    }
  }

  validateForm() async {
    if (imageFile == null) {
      showAlertSnackbar("Gambar kategori tidak boleh kosong", false);
    } else if (categoryNameCtrl!.text.isEmpty) {
      showAlertSnackbar("Nama kategori tidak boleh kosong", false);
    } else {
      GeneralUtils().customProgressLoading(context);
      await controller!.addCategoryCtrl(map: {
        "name": categoryNameCtrl!.text,
        "description": descriptionCtrl!.text,
        "image_url": imageFile,
      });
    }
  }

  Widget? handlingError() {
    var alertStatus = controller!.resultStatus.value;
    var alertMessage = controller!.resultMessage.value;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      switch (alertStatus) {
        case "categories_failure":
          showAlertSnackbar(alertMessage, false);
          break;
        case "categories_success":
          showAlertSnackbar(alertMessage, true);
          Navigator.pop(context);
          Navigator.pop(context);
          break;
      }
      controller!.resetResponse();
    });

    return Container();
  }

  popScope() async => await GeneralUtils()
          .customAlertDialog(context, "Apakah Anda Yakin Untuk Keluar ?", () {
        Navigator.pop(context);
        Navigator.pop(context);
      });

  @override
  Widget build(BuildContext context) {
    appbar() => PreferredSize(
          preferredSize: Size.fromHeight(61.h),
          child: CustomAppBar(
              appLabel: "Tambah Kategori",
              identifier: "category",
              callback: () =>
                  isTyping.value ? popScope() : Navigator.pop(context)),
        );

    ////////////////////

    contentForm() => Column(
          children: [
            CustomUploadPhotoButtonWidget(
              headerTitle: "Tambah Gambar Kategori Produk",
              colors: ColorsTheme.white,
              colors2: ColorsTheme.green,
              mode: 1,
              callback: () => GeneralUtils().uploadProfileBottomSheet(
                  context: context,
                  callback: (label) => pickImageFunction(label == "Camera")),
              imageFile: imageFile,
            ),
            GeneralUtils().verticalSpacer(21),
            GeneralUtils().generalTextFormField(
              controller: categoryNameCtrl!,
              label: "Nama Kategori",
              isFinalInput: false,
              isEnabled: true,
              decoType: "underline",
              isNumber: false,
              isPassword: false,
              isPasswordVisible: false,
            ),
            GeneralUtils().verticalSpacer(19),
            GeneralUtils().multiTextFormField(
              controller: descriptionCtrl!,
              label: "Deskripsi",
              maxLines: 5,
              isFinalInput: true,
            ),
          ],
        );

    contentBase() => Scaffold(
          backgroundColor: ColorsTheme.white,
          body: Padding(
            padding: EdgeInsets.only(left: 17.w, right: 17.w, top: 29.h),
            child: CustomBorderFormWidget(
                widgetCallback: () => SizedBox(
                      width: ScreenUtil().screenWidth,
                      height: 280.h,
                      child: SingleChildScrollView(
                        child: contentForm(),
                      ),
                    )),
          ),
          bottomNavigationBar: CustomFormActionButtonWidget(
            "Simpan",
            () => validateForm(),
            () => isTyping.value ? popScope() : true,
          ),
          appBar: appbar(),
        );

    return Obx(() => WillPopScope(
        onWillPop: () async => isTyping.value ? popScope() : true,
        child: SafeArea(
          child: Stack(children: [contentBase(), handlingError()!]),
        )));
  }
}
