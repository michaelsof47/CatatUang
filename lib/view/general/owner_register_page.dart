part of 'package:catat_uang/import_url_file.dart';

class OwnerRegisterPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<OwnerRegisterPage> createState() => OwnerRegisterPageState();
}

class OwnerRegisterPageState extends ConsumerState<OwnerRegisterPage> {
  /////////////////////
  ///GLOBAL VARIABLE///
  /////////////////////
  var count;
  var isChecked;

  ////////////////////////
  //MECHANISM CONTROLLER//
  ////////////////////////

  //FORM 1//
  TextEditingController? outletNameInputController;
  TextEditingController? emailInputController;
  TextEditingController? phoneNumberInputController;
  TextEditingController? descriptionInputController;

  //FORM 2//
  TextEditingController? outletAddressInputController;
  TextEditingController? outletSubDistrictInputController;
  TextEditingController? outletDistrictInputController;
  TextEditingController? outletCityInputController;
  TextEditingController? postalCodeInputController;
  TextEditingController? additionalInputController;

  //FORM 3//
  TextEditingController? categoryInputController;
  TextEditingController? anotherCategoryInputController;
  TextEditingController? descriptonProductOutletInputController;

  ///////////////////////
  ///CUSTOM DECORATION///
  ///////////////////////

  circleDecoration(isCompleted, isInnerCircle) => BoxDecoration(
        color: isInnerCircle
            ? ColorsTheme.white
            : isCompleted
                ? ColorsTheme.green
                : ColorsTheme.grey,
        shape: BoxShape.circle,
      );

  /////////////////////////
  ///CUSTOM PATH / SHAPE///
  /////////////////////////

  ///SINGLE PATH / SHAPE///
  checkableIcon(isCompleted) => AnimatedOpacity(
        opacity: isCompleted ? 1.0 : 0.0,
        duration: const Duration(seconds: 2),
        curve: Curves.bounceIn,
        child: SvgPicture.asset(
          'assets/icon/check_registration.svg',
          semanticsLabel: "check_success",
        ),
      );

  circlePath({bool? isCompleted, int? size, bool? isBackgroundCircle}) =>
      Container(
        width: size!.w,
        height: size.h,
        padding: EdgeInsets.all(isBackgroundCircle! ? 0.w : 3.w),
        child: checkableIcon(isCompleted),
        decoration: circleDecoration(
          isCompleted,
          isBackgroundCircle ? false : true,
        ),
      );

  linerPath(isCompleted) => Container(
        width: 34.w,
        height: 2.h,
        decoration: BoxDecoration(
          color: isCompleted ? ColorsTheme.green : ColorsTheme.grey,
        ),
      );

  ///GROUP OF PATH / SHAPE///
  customCircle(isCompleted) => Stack(
        children: [
          circlePath(
            isCompleted: isCompleted,
            size: 65,
            isBackgroundCircle: true,
          ),
          Positioned(
            child: circlePath(
              isCompleted: isCompleted,
              size: 58,
              isBackgroundCircle: false,
            ),
            top: 3.5.h,
            left: 3.4.w,
          )
        ],
      );

  customLiner(isCompleted) => isCompleted
      ? AnimatedOpacity(
          opacity: isCompleted ? 1.0 : 0.0,
          duration: const Duration(seconds: 5),
          child: linerPath(true),
        )
      : linerPath(false);

  customGroup() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          customCircle(count >= 1 ? true : false),
          customLiner(count >= 2 ? true : false),
          customCircle(count >= 2 ? true : false),
          customLiner(count >= 3 ? true : false),
          customCircle(count >= 3 ? true : false),
        ],
      );

  ///////////////////
  ///CUSTOM WIDGET///
  ///////////////////

  inputFormField({
    String? label,
    TextEditingController? controller,
    bool? isFinalInput,
    bool? isEnabled,
  }) =>
      GeneralUtils.generalTextFormField(
        controller: controller,
        label: label,
        isNumber: false,
        isFinalInput: isFinalInput,
        isEnabled: isEnabled,
        decoType: "underline",
      );

  itemTextSpan(label, isAction) => TextSpan(
        text: label,
        style: GeneralStyle.labelStyle1(
            false, 12, isAction ? ColorsTheme.green : ColorsTheme.black),
        recognizer: !isAction ? null : TapGestureRecognizer()
          ?..onTap = () => print("action"),
      );

  @override
  void initState() {
    super.initState();

    initConstructor();
    initData();
  }

  initConstructor() {
    count = 0;
    isChecked = false;

    outletNameInputController = TextEditingController();
    emailInputController = TextEditingController();
    phoneNumberInputController = TextEditingController();
    descriptionInputController = TextEditingController();
    postalCodeInputController = TextEditingController();
  }

  initData() {}

  navigationAction(isLeft) {
    setState(() {
      if (isLeft) {
        if (count == 0) {
          Navigator.pop(context);
        } else {
          count -= 1;
        }
      } else {
        if (count == 3) {
          //move into main page
        } else {
          count += 1;
        }
      }
    });
  }

  //////////////////
  ///CUSTOM UTILS///
  //////////////////

  String? headerLabel(row) => row == 1
      ? count == 0
          ? "Informasi "
          : "Informasi Utama "
      : count == 0
          ? "Utama"
          : count == 1
              ? "Lokasi Toko"
              : "Kategori Toko";

  @override
  Widget build(context) {
    //////////////////
    ///HEADER LABEL///
    //////////////////
    contentTextSpan(row) => TextSpan(
          text: headerLabel(row),
          style: GeneralStyle.labelStyle1(
              row == 1 ? false : true, 20, ColorsTheme.black),
        );

    titleAppBar() => RichText(
          text: TextSpan(children: [
            contentTextSpan(1),
            contentTextSpan(2),
          ]),
        );

    //////////////////
    ///FORM GROUP 3///
    //////////////////

    verifyCheckbox() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
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

    contentGroup3() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            inputFormField(
              label: "Kategori Toko",
              controller: postalCodeInputController,
              isFinalInput: false,
              isEnabled: false,
            ),
            GeneralUtils.verticalSpacer(10),
            inputFormField(
              label: "Kategori Toko",
              controller: postalCodeInputController,
              isFinalInput: false,
              isEnabled: false,
            ),
            GeneralUtils.verticalSpacer(10),
            GeneralUtils.multiTextFormField(
              label: "Keterangan Produk Toko",
              controller: postalCodeInputController,
              isFinalInput: false,
              maxLines: 3,
            ),
            GeneralUtils.verticalSpacer(10),
            verifyCheckbox(),
          ],
        );

    //////////////////
    ///FORM GROUP 2///
    //////////////////

    contentGroup2() => Column(
          children: [
            CustomUploadPhotoButtonWidget(
              headerTitle: "Tambah Lokasi Toko",
              headerSubtitle: "",
              colors: ColorsTheme.green,
              colors2: ColorsTheme.white,
              isNeedSubtitled: false,
              mode: 2,
            ),
            GeneralUtils.verticalSpacer(10),
            inputFormField(
              label: "Alamat Toko",
              controller: postalCodeInputController,
              isFinalInput: false,
              isEnabled: false,
            ),
            GeneralUtils.verticalSpacer(10),
            inputFormField(
              label: "Kelurahan",
              controller: postalCodeInputController,
              isFinalInput: false,
              isEnabled: false,
            ),
            GeneralUtils.verticalSpacer(10),
            inputFormField(
              label: "Kecamatan",
              controller: postalCodeInputController,
              isFinalInput: false,
              isEnabled: false,
            ),
            GeneralUtils.verticalSpacer(10),
            inputFormField(
              label: "Kabupaten/Kota",
              controller: postalCodeInputController,
              isFinalInput: false,
              isEnabled: false,
            ),
            GeneralUtils.verticalSpacer(10),
            inputFormField(
              label: "Kode Pos",
              controller: postalCodeInputController,
              isFinalInput: false,
              isEnabled: true,
            ),
            GeneralUtils.verticalSpacer(10),
            inputFormField(
              label: "Detail Lainnya",
              controller: postalCodeInputController,
              isFinalInput: false,
              isEnabled: true,
            ),
          ],
        );

    //////////////////
    ///FORM GROUP 1///
    //////////////////

    contentGroup1() => Column(
          children: [
            CustomUploadPhotoButtonWidget(
              headerTitle: "Tambah Foto Profil Toko",
              headerSubtitle:
                  "Ketentuan : Minimal Foto yang di upload adalah 500 x 500 px",
              colors: ColorsTheme.green,
              colors2: ColorsTheme.white,
              isNeedSubtitled: true,
              mode: 1,
            ),
            GeneralUtils.verticalSpacer(5),
            inputFormField(
              label: "Nama Toko",
              controller: outletNameInputController,
              isFinalInput: false,
              isEnabled: true,
            ),
            GeneralUtils.verticalSpacer(10),
            inputFormField(
              label: "Email Toko",
              controller: emailInputController,
              isFinalInput: false,
              isEnabled: true,
            ),
            GeneralUtils.verticalSpacer(10),
            inputFormField(
              label: "No. Telp Toko",
              controller: phoneNumberInputController,
              isFinalInput: false,
              isEnabled: true,
            ),
            GeneralUtils.verticalSpacer(10),
            GeneralUtils.multiTextFormField(
              controller: descriptionInputController,
              label: "Deskripsi",
              maxLines: 5,
              isFinalInput: true,
            )
          ],
        );

    ///////////////////////
    ///SYSTEM NAVIGATION///
    ///////////////////////

    iconNav(isLeft) => SvgPicture.asset(
          isLeft
              ? 'assets/icon/ic_nav_left.svg'
              : 'assets/icon/ic_nav_right.svg',
          width: 27.w,
          height: 45.h,
          semanticsLabel: "icon navigation",
        );

    btnNavigationAction(isLeft) => InkWell(
          onTap: () => navigationAction(isLeft),
          child: Row(
            children: [
              isLeft ? iconNav(isLeft) : Container(),
              GeneralUtils.horizontalSpacer(5),
              Text(
                isLeft ? "Kembali" : "Lanjut",
                style: GeneralStyle.navigationActionLabel(),
              ),
              !isLeft ? iconNav(isLeft) : Container(),
            ],
          ),
        );

    systemNavigationBar() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            btnNavigationAction(true),
            btnNavigationAction(false),
          ],
        );

    //////////////////
    ///GENERAL BASE///
    //////////////////

    formContent() => Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(12.w, 30.h, 12.w, 35.h),
              child: count == 0
                  ? contentGroup1()
                  : count == 1
                      ? contentGroup2()
                      : contentGroup3(),
            ),
          ),
        );

    contentBody() => SafeArea(
          child: Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 23.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  customGroup(),
                  GeneralUtils.verticalSpacer(20),
                  titleAppBar(),
                  formContent(),
                  systemNavigationBar(),
                ],
              ),
            ),
          ),
        );

    return Container(
      color: ColorsTheme.black,
      child: contentBody(),
    );
  }
}
