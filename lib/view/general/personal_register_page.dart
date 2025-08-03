part of 'package:catat_uang/import_url_file.dart';

class RegisterUserPage extends StatefulWidget {
  @override
  State<RegisterUserPage> createState() => RegisterUserPageState();
}

class RegisterUserPageState extends State<RegisterUserPage> {
  //Global Variable
  TextEditingController? firstnameInputCtrl;
  TextEditingController? lastnameInputCtrl;
  TextEditingController? emailInputCtrl;
  TextEditingController? phoneInputCtrl;
  TextEditingController? passwordInputCtrl;
  TextEditingController? rePasswordInputCtrl;
  ScrollController? scrollController;
  LoginController? loginCtrl;

  File? imageFile;

  var labelText;
  var isChecked;
  var isPasswordVisible;
  var isRePasswordVisible;
  var alertStatus;

  //Global Props
  showAlertSnackbar(String? label, bool? isSuccessful) =>
      ScaffoldMessenger.of(context).showSnackBar(GeneralUtils().alertSnackbar(
          label: label,
          color: isSuccessful! ? ColorsTheme.green : ColorsTheme.redSoft));

  @override
  void initState() {
    super.initState();

    initConstructor();
    initData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (ModalRoute.of(context)!.settings.arguments is Map<dynamic, dynamic>) {
      final Map<dynamic, dynamic> data =
          ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>;

      emailInputCtrl!.text = data["email"];
      firstnameInputCtrl!.text = data["firstname"];
      lastnameInputCtrl!.text = data["lastname"];
    }
  }

  initConstructor() {
    firstnameInputCtrl = TextEditingController();
    lastnameInputCtrl = TextEditingController();
    emailInputCtrl = TextEditingController();
    phoneInputCtrl = TextEditingController();
    passwordInputCtrl = TextEditingController();
    rePasswordInputCtrl = TextEditingController();
    scrollController = ScrollController();
    loginCtrl = Get.put(LoginController());

    imageFile = null;

    labelText = "";
    isChecked = false;
    isPasswordVisible = false.obs;
    isRePasswordVisible = false.obs;
    alertStatus = "".obs;
  }

  initData() {
    setState(() {
      labelText =
          "Kamu setuju dengan Ketentuan Layanan dan Kebijakan Privasi Catat Uang";
    });
  }

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

  verifyForm() {
    if (imageFile == null) {
      showAlertSnackbar("Silahkan upload foto profil Anda", false);
    } else if (firstnameInputCtrl!.text.isEmpty) {
      showAlertSnackbar("Silahkan masukkan nama depan Anda", false);
    } else if (lastnameInputCtrl!.text.isEmpty) {
      showAlertSnackbar("Silahkan masukkan nama belakang Anda", false);
    } else if (emailInputCtrl!.text.isEmpty) {
      showAlertSnackbar("Silahkan masukkan email Anda", false);
    } else if (phoneInputCtrl!.text.isEmpty) {
      showAlertSnackbar("Silahkan masukkan nomor telepon Anda", false);
    } else if (passwordInputCtrl!.text.isEmpty) {
      showAlertSnackbar("Silahkan masukkan password Anda", false);
    } else if (rePasswordInputCtrl!.text.isEmpty) {
      showAlertSnackbar("Silahkan masukkan ulang password Anda", false);
    } else if (rePasswordInputCtrl!.text != passwordInputCtrl!.text) {
      showAlertSnackbar("Password tidak sama", false);
    } else if (passwordInputCtrl!.text.length < 8) {
      showAlertSnackbar("Password minimal 8 karakter", false);
    } else if (rePasswordInputCtrl!.text.length < 8) {
      showAlertSnackbar("Ulang password minimal 8 karakter", false);
    } else if (!isChecked!) {
      showAlertSnackbar("Silahkan lakukan persetujuan terlebih dahulu", false);
    } else {
      GeneralUtils().customProgressLoading(context);
      Map<String, dynamic> collectMap = {
        "url_image": imageFile!,
        "firstname": firstnameInputCtrl!.text,
        "lastname": lastnameInputCtrl!.text,
        "email": emailInputCtrl!.text,
        "phone": phoneInputCtrl!.text,
        "password": passwordInputCtrl!.text,
      };
      loginCtrl!.requestRegisterData(data: collectMap);
    }
  }

  Widget? handlingError() {
    alertStatus.value = loginCtrl!.resultStatus.value;
    var alertMessage = loginCtrl!.resultMsg.value;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      switch (alertStatus.value) {
        case "success_register":
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, '/home_navigation');
          break;
        case "failure_register":
          Navigator.pop(context);
          showAlertSnackbar(alertMessage, false);
          break;
      }

      loginCtrl!.resetResponse();
    });

    return Container();
  }

  var wasKeyboardOpen = false.obs;

  @override
  Widget build(BuildContext context) {
    //menentukan keyboard muncul atau tidak
    final bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    final ScrollPhysics scrollPhysics = isKeyboardOpen
        ? const AlwaysScrollableScrollPhysics()
        : const NeverScrollableScrollPhysics();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (wasKeyboardOpen.value && !isKeyboardOpen) {
        scrollController!.animateTo(0.0,
            duration: const Duration(milliseconds: 100), curve: Curves.easeOut);
      }
      wasKeyboardOpen.value = isKeyboardOpen;
    });

    titleAppBar() => RichText(
          text: TextSpan(children: [
            TextSpan(
                text: "Buat ",
                style: FontTheme.labelStyle1(
                    status: "thin", fontSize: 25, color: ColorsTheme.black)),
            TextSpan(
                text: "Akun Baru",
                style: FontTheme.labelStyle1(
                    status: "bold", fontSize: 25, color: ColorsTheme.black)),
          ]),
        );

    itemTextSpan(label, isAction) => TextSpan(
          text: label,
          style: FontTheme.labelStyle1(
              status: "thin",
              fontSize: 12,
              color: isAction ? ColorsTheme.green : ColorsTheme.black),
          recognizer: !isAction ? null : TapGestureRecognizer()
            ?..onTap = () => print("action"),
        );

    verifyCheckbox() => Row(
          children: [
            Checkbox(
              value: isChecked,
              onChanged: (value) => setState(() => isChecked = value),
              activeColor: ColorsTheme.black,
            ),
            SizedBox(
              width: 240.w,
              child: RichText(
                text: TextSpan(
                  children: [
                    itemTextSpan("Kamu setuju dengan ", false),
                    itemTextSpan("Ketentuan Layanan ", true),
                    itemTextSpan("dan ", false),
                    itemTextSpan(" Kebijakan Privasi ", true),
                    itemTextSpan(" Catat Uang", false),
                  ],
                ),
              ),
            ),
          ],
        );

    formField() => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GeneralUtils().generalTextFormField(
                controller: firstnameInputCtrl,
                label: "Masukkan Nama Depan",
                isFinalInput: false,
                isEnabled: true,
                decoType: "underline",
                isNumber: false,
                isPassword: false),
            GeneralUtils().verticalSpacer(5.h),
            GeneralUtils().generalTextFormField(
                controller: lastnameInputCtrl,
                label: "Masukkan Nama Belakang",
                isFinalInput: false,
                isEnabled: true,
                decoType: "underline",
                isNumber: false,
                isPassword: false),
            GeneralUtils().verticalSpacer(5.h),
            GeneralUtils().generalTextFormField(
                controller: emailInputCtrl,
                label: "Masukkan Email",
                isFinalInput: false,
                isEnabled: true,
                isNumber: false,
                decoType: "underline",
                isPassword: false),
            GeneralUtils().verticalSpacer(5.h),
            GeneralUtils().generalTextFormField(
                controller: phoneInputCtrl,
                label: "Masukkan No. Telp",
                isFinalInput: false,
                isEnabled: true,
                isNumber: false,
                decoType: "underline",
                isPassword: false),
            GeneralUtils().verticalSpacer(5.h),
            GeneralUtils().generalTextFormField(
                controller: passwordInputCtrl,
                label: "Masukkan Password",
                isFinalInput: false,
                isEnabled: true,
                isNumber: false,
                decoType: "underline",
                isPassword: true,
                onPasswordVisible: () =>
                    isPasswordVisible.value = !isPasswordVisible.value,
                isPasswordVisible: isPasswordVisible.value),
            GeneralUtils().verticalSpacer(5.h),
            GeneralUtils().generalTextFormField(
                controller: rePasswordInputCtrl,
                label: "Masukkan Ulang Password",
                isFinalInput: true,
                isEnabled: true,
                isNumber: false,
                decoType: "underline",
                isPassword: true,
                onPasswordVisible: () =>
                    isRePasswordVisible.value = !isRePasswordVisible.value,
                isPasswordVisible: isRePasswordVisible.value),
          ],
        );

    iconNav(isLeft) => SvgPicture.asset(
          isLeft
              ? 'assets/icon/ic_nav_left.svg'
              : 'assets/icon/ic_nav_right.svg',
          width: 22.61.w,
          height: 38.h,
          semanticsLabel: "icon navigation",
        );

    btnNavigationAction(isLeft) => InkWell(
          onTap: () => isLeft ? Navigator.pop(context) : verifyForm(),
          child: Row(
            children: [
              isLeft ? iconNav(isLeft) : Container(),
              GeneralUtils().horizontalSpacer(5),
              Text(
                isLeft ? "Kembali" : "Lanjut",
                style: FontTheme.navigationActionLabel(),
              ),
              !isLeft ? iconNav(isLeft) : Container(),
            ],
          ),
        );

    uploadProfileContent() =>
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
              width: 150.w,
              child: Text("Tambahkan Foto Profilmu Anda di Sini")),
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r)),
            color: ColorsTheme.green,
            child: InkWell(
                onTap: () => GeneralUtils().uploadProfileBottomSheet(
                    context: context,
                    callback: (label) => pickImageFunction(label == "Camera")),
                child: imageFile == null
                    ? Container(
                        width: 80.w,
                        height: 80.h,
                        padding: EdgeInsets.all(10.w),
                        child: Icon(Icons.add,
                            size: 30.w, color: ColorsTheme.white),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: Image.file(
                          imageFile!,
                          width: 80.w,
                          height: 80.h,
                          fit: BoxFit.cover,
                        ))),
          )
        ]);

    contentForm() => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              uploadProfileContent(),
              formField(),
              GeneralUtils().verticalSpacer(10.h),
              verifyCheckbox(),
            ]);

    contentBody() => SingleChildScrollView(
        controller: scrollController,
        physics: scrollPhysics,
        child: SizedBox(
            height: 800.h,
            child: Padding(
              padding: EdgeInsets.fromLTRB(15.w, 30.h, 15.w, 0.h),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleAppBar(),
                    GeneralUtils().verticalSpacer(20.h),
                    contentForm(),
                  ]),
            )));

    bottomNavigationMenu() => Container(
        height: 50.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            btnNavigationAction(true),
            btnNavigationAction(false),
          ],
        ));

    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: ColorsTheme.white,
          body: Obx(() => Stack(children: [contentBody(), handlingError()!])),
          bottomNavigationBar: bottomNavigationMenu()),
    );
  }
}
