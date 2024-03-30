part of 'package:catat_uang/import_url_file.dart';

class LoginController extends GetxController {
  FirebaseAuth? firebaseAuth;
  LocalManager? localManager;

  var resultMsg;
  var resultStatus;

  LoginController() {
    firebaseAuth = FirebaseAuth.instance;
    localManager = Get.put(LocalManager());

    resultMsg = "".obs;
    resultStatus = "".obs;
  }

  void resetResponse() {
    resultMsg.value = "";
    resultStatus.value = "";
  }

  storeLoginStatusController(loginStatus) async =>
      await localManager!.storedLoginStatusAccount(loginStatus);

  retrieveLoginStatusController() async =>
      await localManager!.retrieveLoginStatus();

  storeDevelopmentRoleStatusController(roleStatus) async {}
  //=> await localManager!.storedDevelopmentRoleStatus(roleStatus);

  retrieveDevelopmentRoleStatusController() async {}
  //=> await localManager!.retrieveDevelopmentRoleStatus();

  clearDataController() async {} //=> await localManager!.clearData();

  //BUSINESS LOGIC SOCIAL MEDIA LOGIN//
  Future requestGoogleSignIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    try {
      final googleAuth = await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      var result = await firebaseAuth!.signInWithCredential(credential);
      print("data user : ${result.user!}");
      if (result.user!.emailVerified) {
        resultStatus.value = "success";
        resultMsg.value = "";
      } else {
        resultStatus.value = "failure";
        resultMsg.value = "Akses Login dengan Google dibatalkan.";
      }
    } catch (e) {
      resultStatus.value = "failure";
      resultMsg.value = "Akses Login dengan Google dibatalkan.";
    }
  }

  Future requestFacebookSignIn() async {
    var result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
        loginBehavior: LoginBehavior.katanaOnly);

    switch (result.status) {
      case LoginStatus.success:
        var profileData =
            await FacebookAuth.instance.getUserData(fields: "name,email");
        resultStatus.value = "success";
        resultMsg.value = "";
        break;
      case LoginStatus.cancelled || LoginStatus.failed:
        resultStatus.value = "failure";
        resultMsg.value = result.message;
        break;
      case LoginStatus.operationInProgress:
        break;
    }
  }

  Future requestEmailPhoneSignIn({required String? phonenumber}) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+62 $phonenumber',
      verificationCompleted: (credential) {},
      verificationFailed: (e) {
        resultStatus.value = "failure";
        resultMsg.value = e.message;
      },
      codeSent: (verificationId, resendToken) {
        resultStatus.value = "success";
        resultMsg.value = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) => {},
    );
  }
}
