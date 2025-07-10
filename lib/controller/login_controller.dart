part of 'package:catat_uang/import_url_file.dart';

class LoginController extends GetxController {
  FirebaseAuth? firebaseAuth;
  LocalManager? localManager;
  UserService? userService;

  var resultMsg;
  var resultStatus;
  RxMap<dynamic,dynamic> dataMap = {}.obs;

  LoginController() {
    firebaseAuth = FirebaseAuth.instance;
    localManager = Get.put(LocalManager());
    userService = Get.put(UserService());

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
        Map<String,dynamic>? data = {
          "email": result.user!.email,
          "firstname": result.user!.displayName.toString().split(" ")[0],
          "lastname": result.user!.displayName.toString().split(" ")[1],
        };

        validateEmailFromDB(data);

      } else {
        resultStatus.value = "failure_google";
        resultMsg.value = "Akses Login dengan Google dibatalkan.";
      }
    } catch (e) {
      resultStatus.value = "failure_google";
      resultMsg.value = "Akses Login dengan Google dibatalkan.";
    }
  }

  Future validateEmailFromDB(Map<String,dynamic> data) async {
    Map<String,dynamic> responseData = await userService!.checkEmail(email: data['email']);

    if(responseData["status_code"] == 200) {
      if(responseData["data"]["message"] == "Silahkan Masuk") {
        resultStatus.value = "success_login";
      } else {
        resultStatus.value = "success_register";
        dataMap.value = data;
      }
    } else {
      resultStatus.value = "failure_google";
      resultMsg.value = "Gagal Login.";
    }
  }

  Future requestEmailPhoneSignIn({required String? email,required String? password}) async {
      Map<String,dynamic> responseData = await userService!.fetchLogin(email: email, password: password);

      if(responseData["status_code"] == 200) {
        LoginModel data = LoginModel.fromJson(responseData["data"]);
        print("data success : ${data.token}");
        resultStatus.value = "success";
        resultMsg.value = "Berhasil Login.";
      } else {
        print("data failure: ${responseData["data"]}");
        resultStatus.value = "failure";
        resultMsg.value = "Gagal Login.";
      }
  }

  Future requestRegisterData({required Map<String,dynamic>? data}) async {
    Map<String,dynamic> responseData = await userService!.fetchRegister(temporaryData: data);


    if(responseData["status_code"] == 201) {
      LoginModel dataModel = LoginModel.fromJson(responseData["data"]);
      print("data success : ${dataModel.token}");
      resultStatus.value = "success_register";
    } else {
      print("data failure: ${responseData["data"]}");
      resultStatus.value = "failure_register";
      resultMsg.value = responseData["data"]["error"];
    }
  }
}
