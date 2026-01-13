part of 'package:catat_uang/import_url_file.dart';

class ProfileFormBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}

class ProfileFormPage extends StatefulWidget {
  @override
  State<ProfileFormPage> createState() => ProfileFormPageState();
}

class ProfileFormPageState extends State<ProfileFormPage> {
  TextEditingController? firstNameInputCtrl;
  TextEditingController? lastNameInputCtrl;
  TextEditingController? emailInputCtrl;
  TextEditingController? phoneInputCtrl;

  TextEditingController? passwordInputCtrl;
  TextEditingController? repasswordInputCtrl;

  DashboardController? controller;

  var isPasswordVisible;
  var isRePasswordVisible;
  File? imageFile;
  var userId = "".obs;
  var isAddingImage;
  var imageUrl;
  var headerKey;
  var isTyping;

  var firstNameDataLength;
  var lastNameDataLength;
  var emailDataLength;
  var phoneDataLength;

  //Global Props
  showAlertSnackbar(String? label, bool? isSuccessful) =>
      ScaffoldMessenger.of(context).showSnackBar(GeneralUtils().alertSnackbar(
          label: label,
          color: isSuccessful! ? ColorsTheme.green : ColorsTheme.redSoft));

  Future<void> pickImageFunction(bool isCamera) async {
    final XFile? image = await ImagePicker()
        .pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery);

    if (image != null) {
      isAddingImage.value = true;
      setState(() => imageFile = File(image.path));
    } else {
      showAlertSnackbar("Tidak ada gambar yang dipilih", false);
    }
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();

    final Map<String, dynamic>? data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    userId.value = data!["userId"];
    firstNameInputCtrl!.text = data["firstName"];
    firstNameDataLength = data["firstName"].length;
    lastNameInputCtrl!.text = data["lastName"];
    lastNameDataLength = data["lastName"].length;
    emailInputCtrl!.text = data["email"];
    emailDataLength = data["email"].length;
    phoneInputCtrl!.text = data["phone"];
    phoneDataLength = data["phone"].length;
    imageUrl = data["url_image"];
    headerKey = UniqueKey();
  }

  @override
  initState() {
    super.initState();

    initConstructor();
  }

  initConstructor() {
    isPasswordVisible = false.obs;
    isRePasswordVisible = false.obs;

    firstNameInputCtrl = TextEditingController();
    lastNameInputCtrl = TextEditingController();
    emailInputCtrl = TextEditingController();
    phoneInputCtrl = TextEditingController();

    passwordInputCtrl = TextEditingController();
    repasswordInputCtrl = TextEditingController();

    controller = Get.find<DashboardController>();

    isAddingImage = false.obs;
    isTyping = false.obs;

    firstNameInputCtrl!.addListener(() => detectTyping());
    lastNameInputCtrl!.addListener(() => detectTyping());
    emailInputCtrl!.addListener(() => detectTyping());
    phoneInputCtrl!.addListener(() => detectTyping());
    passwordInputCtrl!.addListener(() => detectTyping());
    repasswordInputCtrl!.addListener(() => detectTyping());
  }

  detectTyping() {
    if (firstNameInputCtrl!.text.length > firstNameDataLength || 
        lastNameInputCtrl!.text.length > lastNameDataLength ||
        emailInputCtrl!.text.length > emailDataLength ||
        phoneInputCtrl!.text.length > phoneDataLength ||
        passwordInputCtrl!.text.length > 0 ||
        repasswordInputCtrl!.text.length > 0 ||
        imageFile != null) {
      isTyping.value = true;
    } else {
      isTyping.value = false;
    }
  }

  validateForm() {
    if (passwordInputCtrl!.text.length > 1 ||
        repasswordInputCtrl!.text.length > 1) {
      if (passwordInputCtrl!.text.isEmpty) {
        showAlertSnackbar("Masukkan Password Terlebih Dahulu", false);
      } else if (repasswordInputCtrl!.text.isEmpty) {
        showAlertSnackbar("Masukkan Ulang Password Terlebih Dahulu", false);
      } else if (passwordInputCtrl!.text != repasswordInputCtrl!.text) {
        showAlertSnackbar("Password Tidak Sama", false);
      } else {
        GeneralUtils().customProgressLoading(context);
        controller!.updatePasswordCtrl(passwordInputCtrl!.text);
      }
    } else if (firstNameInputCtrl!.text.length > 1 ||
        lastNameInputCtrl!.text.length > 1 ||
        emailInputCtrl!.text.length > 1 ||
        phoneInputCtrl!.text.length > 1) {
      if (firstNameInputCtrl!.text.isEmpty) {
        showAlertSnackbar("Masukkan Nama Depan Terlebih Dahulu", false);
      } else if (lastNameInputCtrl!.text.isEmpty) {
        showAlertSnackbar("Masukkan Nama Belakang Terlebih Dahulu", false);
      } else if (emailInputCtrl!.text.isEmpty) {
        showAlertSnackbar("Masukkan Email Terlebih Dahulu", false);
      } else if (phoneInputCtrl!.text.isEmpty) {
        showAlertSnackbar("Masukkan No. HP Terlebih Dahulu", false);
      } else {
        GeneralUtils().customProgressLoading(context);

        if (!isAddingImage.value) {
          Map<String, dynamic>? datamap = {
            "firstName": firstNameInputCtrl!.text,
            "lastName": lastNameInputCtrl!.text,
            "email": emailInputCtrl!.text,
            "phone": phoneInputCtrl!.text,
          };

          controller!.updateProfileCtrl(datamap);
        } else {
          controller!.updateImageProfileCtrl(imageFile!);
        }
      }
    }
  }

  Widget? handlingError() {
    var alertStatus = "".obs;
    alertStatus.value = controller!.resultStatus.value;
    var alertMessage = controller!.resultMsg.value;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      switch (alertStatus.value) {
        case "success_profile":
          Navigator.pop(context);
          Navigator.pop(context);
          showAlertSnackbar(alertMessage, true);
          break;
        case "success_image_profile":
        case "success_password":
          Map<String, dynamic>? datamap = {
            "firstName": firstNameInputCtrl!.text,
            "lastName": lastNameInputCtrl!.text,
            "email": emailInputCtrl!.text,
            "phone": phoneInputCtrl!.text,
          };
          controller!.updateProfileCtrl(datamap);
          break;
        case "failure":
          Navigator.pop(context);
          showAlertSnackbar(alertMessage, false);
          break;
      }

      controller!.resetResponse();
    });

    return Container();
  }

  popScope() async => await GeneralUtils().customAlertDialog(context,"Apakah Anda Yakin Untuk Keluar ?", () {
        Navigator.pop(context);
        Navigator.pop(context);
      });

  @override
  Widget build(BuildContext context) {
    customLabel(label, status) => Text(label,
        style: status == "header"
            ? FontTheme.labelStyle1(
                status: "regular", fontSize: 12, color: ColorsTheme.green)
            : status == "subtitle"
                ? FontTheme.labelStyle1(
                    status: "thin", fontSize: 8, color: ColorsTheme.black)
                : FontTheme.labelStyle1(
                    status: "regular", fontSize: 12, color: ColorsTheme.grey));

    itemProfile() => Card(
        shape: GeneralUtils().customDecoration(),
        elevation: 0.h,
        color: ColorsTheme.greenNature,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
          child: Row(children: [
            GeneralUtils().avatarBorder(
                child: CircleAvatar(
              radius: 40.r,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(40.r),
                  child: isAddingImage.value
                      ? Image.file(imageFile!,
                          width: 80.w, height: 80.h, fit: BoxFit.cover)
                      : Image.network(
                          imageUrl!,
                          key: headerKey,
                          width: 80.w,
                          height: 80.h,
                          fit: BoxFit.cover,
                        )),
            )),
            GeneralUtils().horizontalSpacer(10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              customLabel("Tambah Foto Profil", "header"),
              SizedBox(
                  width: 180.w,
                  child: customLabel(
                      "Klik \"Upload Profil\" untuk mengubah foto profil",
                      "subtitle")),
              GeneralUtils().verticalSpacer(20),
              SizedBox(
                  width: 180.w,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => GeneralUtils().uploadProfileBottomSheet(
                              context: context,
                              callback: (label) =>
                                  pickImageFunction(label == "Camera")),
                          child: Text("Upload Profil",
                              style: FontTheme.labelStyle1(
                                  status: "bold",
                                  fontSize: 12,
                                  color: ColorsTheme.green)),
                        ),
                      ]))
            ])
          ]),
        ));

    headerTitleForm(label) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: ColorsTheme.yellow,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
            child: customLabel(label, "header"),
          ),
        );

    contentGeneralForm() => Column(children: [
          GeneralUtils().generalTextFormField(
            controller: firstNameInputCtrl,
            label: "Nama Depan",
            isFinalInput: false,
            isEnabled: true,
            decoType: "underline",
            isNumber: false,
            isPassword: false,
          ),
          GeneralUtils().generalTextFormField(
            controller: lastNameInputCtrl,
            label: "Nama Belakang",
            isFinalInput: false,
            isEnabled: true,
            decoType: "underline",
            isNumber: false,
            isPassword: false,
          ),
          GeneralUtils().generalTextFormField(
            controller: emailInputCtrl,
            label: "Email",
            isFinalInput: false,
            isEnabled: true,
            decoType: "underline",
            isNumber: false,
            isPassword: false,
          ),
          GeneralUtils().generalTextFormField(
            controller: phoneInputCtrl,
            label: "No. HP",
            isFinalInput: true,
            isEnabled: true,
            decoType: "underline",
            isNumber: false,
            isPassword: false,
          ),
        ]);

    contentPasswordForm() => Column(children: [
          GeneralUtils().generalTextFormField(
            controller: passwordInputCtrl,
            label: "Password Baru",
            isFinalInput: false,
            isEnabled: true,
            decoType: "underline",
            isNumber: false,
            isPassword: true,
            onPasswordVisible: () {
              isPasswordVisible.value = !isPasswordVisible.value;
            },
            isPasswordVisible: isPasswordVisible.value,
          ),
          GeneralUtils().generalTextFormField(
            controller: repasswordInputCtrl,
            label: "Ulang Password Baru",
            isFinalInput: true,
            isEnabled: true,
            decoType: "underline",
            isNumber: false,
            isPassword: true,
            onPasswordVisible: () {
              isRePasswordVisible.value = !isRePasswordVisible.value;
            },
            isPasswordVisible: isRePasswordVisible.value,
          )
        ]);

    itemForm(isGeneralForm) => Container(
          width: ScreenUtil().screenWidth,
          height: 200.h,
          child: Stack(children: [
            Positioned(
              left: 0.w,
              top: 8.h,
              right: 0.w,
              child: Card(
                  shape: GeneralUtils().customDecoration(),
                  color: ColorsTheme.greenNature,
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 15.h),
                      child: isGeneralForm
                          ? contentGeneralForm()
                          : contentPasswordForm())),
            ),
            Positioned(
              left: 15.w,
              top: 0.h,
              child: headerTitleForm(
                  isGeneralForm ? "Informasi Utama" : "Informasi Password"),
            ),
          ]),
        );

    contentBody() => Column(children: [
          itemProfile(),
          GeneralUtils().verticalSpacer(10),
          itemForm(true),
          GeneralUtils().verticalSpacer(10),
          itemForm(false),
        ]);

    appbar() => PreferredSize(
          preferredSize: Size.fromHeight(61.h),
          child: CustomAppBar(
              appLabel: "Profil",
              identifier: "profile_form",
              callback: () =>
                  isTyping.value ? popScope() : Navigator.pop(context),
              actionCallback: () => validateForm()),
        );

    contentBase() => Padding(
          padding: EdgeInsets.only(left: 17.w, right: 17.w, top: 10.h),
          child: SingleChildScrollView(
              child: Stack(children: [contentBody(), handlingError()!])),
        );

    return Obx(() => WillPopScope(
        onWillPop: () async => isTyping.value ? popScope() : true,
        child: SafeArea(
          child: Scaffold(body: contentBase(), appBar: appbar()),
        )));
  }
}
