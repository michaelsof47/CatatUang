part of 'package:catat_uang/import_url_file.dart';

class LoginController extends BaseController {
  FirebaseAuth? firebaseAuth;
  LocalManager? localManager;
  LoginServiceInterfaces? loginService;

  late RxString resultMsg;
  late RxString resultStatus;
  late RxMap<dynamic, dynamic> dataMap;

  LoginController({
    required this.firebaseAuth,
    required this.localManager,
    required this.loginService,
  }) {
    resultMsg = "".obs;
    resultStatus = "".obs;
    dataMap = {}.obs;
  }

  @override
  void resetResponse() {
    resultMsg.value = "";
    resultStatus.value = "";
  }

  retrieveLoginStatusController() async =>
      await localManager!.retrieveLoginStatus();

  //BUSINESS LOGIC SOCIAL MEDIA LOGIN//
  Future loginWithGoogleCtrl() async {
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
        Map<String, dynamic>? data = {
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

  Future validateEmailFromDB(Map<String, dynamic> data) async {
    HttpModel response =
        await loginService!.postCheckEmail(email: data['email']);

    var responseBody = json.decode(response.body!);

    if (response.code == 200) {
      if (responseBody["message"] == "Silahkan Masuk") {
        LoginModel dataModel = LoginModel.fromJson(responseBody);

        Map<String, dynamic>? dataUser = {
          "user_id": dataModel.userId,
          "token": dataModel.token,
        };

        localManager!.storedTokenAndUserIdAccount(map: dataUser);
        localManager!.storedLoginStatusAccount(true);
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

  Future loginWithEmailPhoneCtrl(
      {required String? email, required String? password}) async {
    HttpModel response =
        await loginService!.postLogin(email: email, password: password);

    var responseBody = json.decode(response.body!);

    if (response.code == 200) {
      LoginModel data = LoginModel.fromJson(responseBody);
      print("data success : ${data.token}, ${data.message}");

      Map<String, dynamic>? dataUser = {
        "user_id": data.userId,
        "token": data.token,
      };

      localManager!.storedTokenAndUserIdAccount(map: dataUser);
      localManager!.storedLoginStatusAccount(true);
      resultStatus.value = "success";
    } else {
      print("data failure: ${responseBody}");
      resultStatus.value = "failure";
      resultMsg.value = "Gagal Login.";
    }
  }

  Future registerUserCtrl({required Map<String, dynamic>? data}) async {
    HttpModel response = await loginService!.postRegister(temporaryData: data);

    var responseBody = json.decode(response.body!);

    if (response.body == 201) {
      LoginModel dataModel = LoginModel.fromJson(responseBody);
      print("data success : ${dataModel.token}");

      Map<String, dynamic>? dataUser = {
        "user_id": dataModel.userId,
        "token": dataModel.token,
      };

      localManager!.storedTokenAndUserIdAccount(map: dataUser);
      localManager!.storedLoginStatusAccount(true);
      resultStatus.value = "success_register";
    } else {
      print("data failure: ${responseBody}");
      resultStatus.value = "failure_register";
      resultMsg.value = responseBody["message"];
    }
  }
}
