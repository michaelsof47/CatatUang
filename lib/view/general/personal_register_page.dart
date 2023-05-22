part of 'package:catat_uang/import_url_file.dart';

class RegisterUserPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<RegisterUserPage> createState() => RegisterUserPageState();
}

class RegisterUserPageState extends ConsumerState<RegisterUserPage> {
  //MECHANISM CONTROLLER
  TextEditingController? firstnameInputController;
  TextEditingController? lastNameInputController;
  TextEditingController? emailInputController;
  TextEditingController? phoneInputController;

  var labelText;
  var isChecked;

  @override
  void initState() {
    super.initState();

    initConstructor();
    initData();
  }

  initConstructor() {
    firstnameInputController = TextEditingController();
    lastNameInputController = TextEditingController();
    emailInputController = TextEditingController();
    phoneInputController = TextEditingController();
    labelText = "";
    isChecked = false;
  }

  initData() {
    setState(() {
      labelText =
          "Kamu setuju dengan Ketentuan Layanan dan Kebijakan Privasi Catat Uang";
    });
  }

  @override
  Widget build(context) {
    titleAppBar() => RichText(
          text: TextSpan(children: [
            TextSpan(
                text: "Buat ",
                style: GeneralStyle.labelStyle1(false, 20, ColorsTheme.black)),
            TextSpan(
                text: "Akun Baru",
                style: GeneralStyle.labelStyle1(true, 20, ColorsTheme.black)),
          ]),
        );

    itemTextSpan(label, isAction) => TextSpan(
          text: label,
          style: GeneralStyle.labelStyle1(
              false, 12, isAction ? ColorsTheme.green : ColorsTheme.black),
          recognizer: !isAction ? null : TapGestureRecognizer()
            ?..onTap = () => print("action"),
        );

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

    formField() => Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GeneralUtils.generalTextFormField(
                controller: firstnameInputController,
                label: "Nama Depan",
                isFinalInput: false,
                isEnabled: true,
                decoType: "underline",
                isNumber: false,
              ),
              GeneralUtils.verticalSpacer(5.h),
              GeneralUtils.generalTextFormField(
                controller: lastNameInputController,
                label: "Nama Belakang",
                isFinalInput: false,
                isEnabled: true,
                decoType: "underline",
                isNumber: false,
              ),
              GeneralUtils.verticalSpacer(5.h),
              GeneralUtils.generalTextFormField(
                controller: emailInputController,
                label: "Email",
                isFinalInput: false,
                isEnabled: true,
                isNumber: false,
                decoType: "underline",
              ),
              GeneralUtils.verticalSpacer(5.h),
              GeneralUtils.generalTextFormField(
                controller: phoneInputController,
                label: "No. Telp",
                isFinalInput: true,
                isEnabled: true,
                isNumber: false,
                decoType: "underline",
              ),
            ],
          ),
        );

    iconNav(isLeft) => SvgPicture.asset(
          isLeft
              ? 'assets/icon/ic_nav_left.svg'
              : 'assets/icon/ic_nav_right.svg',
          width: 27.w,
          height: 45.h,
          semanticsLabel: "icon navigation",
        );

    btnNavigationAction(isLeft) => InkWell(
          onTap: () => isLeft ? Navigator.pop(context) : {},
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

    contentBody() => SafeArea(
          child: Scaffold(
              body: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 23.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GeneralUtils.verticalSpacer(45),
                titleAppBar(),
                GeneralUtils.verticalSpacer(60),
                formField(),
                GeneralUtils.verticalSpacer(55),
                verifyCheckbox(),
                GeneralUtils.verticalSpacer(58),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    btnNavigationAction(true),
                    btnNavigationAction(false),
                  ],
                )
              ],
            ),
          )),
        );

    return Container(
      color: ColorsTheme.black,
      child: contentBody(),
    );
  }
}
