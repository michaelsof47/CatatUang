part of '../../import_url_file.dart';

class VerifyOTPPage extends ConsumerStatefulWidget {
  ConsumerState<VerifyOTPPage> createState() => VerifyOTPPageState();
}

class VerifyOTPPageState extends ConsumerState<VerifyOTPPage> {
  //////////////////
  ///GLOBAL UTILS///
  //////////////////

  TextEditingController? inputTextController;

  /////////////////////
  ///GLOBAL VARIABLE///
  /////////////////////
  var verificationId;

  ///////////////////////
  ///CUSTOM DECORATION///
  ///////////////////////

  pinFieldDecoration() => UnderlineDecoration(
        textStyle: GeneralStyle.labelStyle1(true, 18, ColorsTheme.black),
        colorBuilder: FixedColorBuilder(ColorsTheme.black),
        lineHeight: 2.h,
      );

  @override
  void initState() {
    super.initState();

    initConstructor();
    initData();
  }

  initConstructor() {
    inputTextController = TextEditingController();
    verificationId = "";
  }

  initData() async {
    verificationId = ref.read(_verificationCode.notifier).state;
    await SmsAutoFill().listenForCode();
  }

  /////////////////////
  ///ACTION FUNCTION///
  /////////////////////

  formFieldAction(code) => setState(() {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId!,
          smsCode: code,
        );

        FirebaseAuth.instance.signInWithCredential(credential);
        FocusManager.instance.primaryFocus?.unfocus();
      });

  @override
  Widget build(context) {
    titleApps() => Center(
          child: Text(
            "Verifikasi Kode OTP",
            style: GeneralStyle.labelStyle1(true, 18, ColorsTheme.black),
          ),
        );

    formField() => PinFieldAutoFill(
          controller: inputTextController,
          decoration: pinFieldDecoration(),
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.done,
          codeLength: 6,
          autoFocus: true,
          onCodeSubmitted: (code) => formFieldAction(code),
        );

    verifyBtn() => Card(
          color: ColorsTheme.yellow,
          child: InkWell(
            onTap: () => formFieldAction(inputTextController!.text),
            borderRadius: BorderRadius.circular(5.r),
            child: Container(
              width: ScreenUtil().screenWidth,
              height: 39.h,
              padding: GeneralUtils.allAroundPadding(11, 0),
              child: Center(
                child: Text(
                  "Lanjut",
                  style: GeneralStyle.labelStyle1(true, 14, ColorsTheme.black),
                ),
              ),
            ),
          ),
        );

    contentWrapBody() => Padding(
          padding:
              EdgeInsets.only(left: 15.w, right: 15.w, bottom: 10.h, top: 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              titleApps(),
              formField(),
              verifyBtn(),
            ],
          ),
        );

    contentBody() => SafeArea(
          child: Scaffold(
              body: Padding(
            padding: GeneralUtils.allAroundPadding(15, 18),
            child: contentWrapBody(),
          )),
        );

    return Container(
      color: ColorsTheme.barStatusColor,
      child: contentBody(),
    );
  }
}
