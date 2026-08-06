part of 'package:catat_uang/import_url_file.dart';

class DashboardController extends BaseController {
  LocalManager? localManager;
  DashboardServiceInterface? dashboardService;

  late RxString resultMsg;
  late RxString resultStatus;
  late RxMap<dynamic, dynamic> dashboardData;
  late RxMap<dynamic, dynamic> transactionData;
  late RxMap<dynamic, dynamic> categoriesData;
  late Rx<Uint8List>? profileImage;
  var balanceAmount;

  DashboardController({
    required this.localManager,
    required this.dashboardService,
  }) {
    resultMsg = "".obs;
    resultStatus = "".obs;
    dashboardData = {}.obs;
    balanceAmount = 0.obs;
    transactionData = {}.obs;
    categoriesData = {}.obs;
    profileImage = Uint8List(0).obs;
  }

  @override
  void resetResponse() {
    resultMsg.value = "";
    resultStatus.value = "";
  }

  Future resetAccountCtrl() async {
    await localManager!.storedTokenAndUserIdAccount(map: {});
    await localManager!.storedLoginStatusAccount(false);
  }

  Future getDashboardDataCtrl(bool isNeedLoadBalance) async {
    Map<String, dynamic>? temporaryData =
        await localManager!.retrieveTokenAndUserIdAccount();

    HttpModel response = await dashboardService!
        .getDashboardData(token: temporaryData!["token"]);

    var responseBody = json.decode(response.body!);

    if (response.code == 200) {
      dashboardData.value = responseBody;
      profileImage!.value = await dashboardService!
          .getProfileImage(token: temporaryData["token"]);

      if (isNeedLoadBalance) {
        await getBalanceAmountCtrl(false, token: temporaryData["token"]);
      } else {
        resultStatus.value = "dashboard_success";
      }
    } else {
      if (responseBody["message"] == "Token is Blocked" ||
          responseBody["message"] == "Token has expired, please login again") {
        resultStatus.value = "jwt_expired";
        resultMsg.value = "Sesi anda telah berakhir, silahkan login kembali";
      } else {
        resultStatus.value = "dashboard_failure";
        resultMsg.value = responseBody["message"];
      }
    }
  }

  Future getBalanceAmountCtrl(bool? isTransactionLoad, {String? token}) async {
    if (token == null) {
      Map<String, dynamic>? temporaryData =
          await localManager!.retrieveTokenAndUserIdAccount();
      token = temporaryData!["token"];
    }

    HttpModel response =
        await dashboardService!.getBalanceAmount(token: token!);

    var responseBody = json.decode(response.body!);

    if (response.code == 200) {
      BalanceModel balanceModel = BalanceModel.fromJson(responseBody);
      balanceAmount.value = balanceModel.balancesAmount;

      localManager!.storedBalanceId(balanceId: balanceModel.id.toString());

      if (isTransactionLoad!) {
        await getAllCategoriesCtrl();
      } else {
        resultStatus.value = "dashboard_success";
      }
    } else {
      if (responseBody["message"] == "Token is Blocked" ||
          responseBody["message"] == "Token has expired, please login again") {
        resultStatus.value = "jwt_expired";
        resultMsg.value = "Sesi anda telah berakhir, silahkan login kembali";
      } else if (responseBody["message"] == "Saldo tidak ditemukan") {
        balanceAmount.value = 0;
        resultStatus.value = "dashboard_success";
      } else {
        resultStatus.value = "dashboard_failure";
        resultMsg.value = responseBody["message"];
      }
    }
  }

  Future getTransactionDataCtrl({int? page, int? categoryId}) async {
    Map<String, dynamic>? temporaryData =
        await localManager!.retrieveTokenAndUserIdAccount();

    HttpModel response = await dashboardService!.getTransactionData(
        token: temporaryData!["token"], page: page, categoryId: categoryId);

    var responseBody = json.decode(response.body!);

    if (response.code == 200) {
      transactionData.value = responseBody;
      resultStatus.value = "transaction_success";
    } else {
      if (responseBody["message"] == "Token is Blocked" ||
          responseBody["message"] == "Token has expired, please login again") {
        resultStatus.value = "jwt_expired";
        resultMsg.value = "Sesi anda telah berakhir, silahkan login kembali";
      } else {
        resultStatus.value = "transaction_failure";
        transactionData.value = {};
        print("Error: ${responseBody["message"]}");
        resultMsg.value = responseBody["message"];
      }
    }
  }

  Future logoutCtrl() async {
    Map<String, dynamic>? temporaryData =
        await localManager!.retrieveTokenAndUserIdAccount();

    HttpModel response =
        await dashboardService!.postLogout(token: temporaryData!["token"]);

    var responseBody = json.decode(response.body!);

    if (response.code == 200) {
      resultStatus.value = "logout_success";
      resultMsg.value = responseBody["message"];
      await resetAccountCtrl();
    } else {
      if (responseBody["message"] == "Token is Blocked" ||
          responseBody["message"] == "Token has expired, please login again") {
        resultStatus.value = "jwt_expired";
        resultMsg.value = "Sesi anda telah berakhir, silahkan login kembali";
      } else {
        resultStatus.value = "transaction_failure";
        transactionData.value = {};
        print("Error: ${responseBody["message"]}");
        resultMsg.value = responseBody["message"];
      }
    }
  }

  Future topupBalanceCtrl(String amount) async {
    Map<String, dynamic>? temporaryData =
        await localManager!.retrieveTokenAndUserIdAccount();

    Map<String, dynamic> requestParams = {
      "amount": amount,
      "user_id": temporaryData!["user_id"],
      "token": temporaryData["token"]
    };

    HttpModel response =
        await dashboardService!.patchTopupBalance(map: requestParams);

    var responseBody = json.decode(response.body!);

    if (response.code == 200) {
      resultStatus.value = "topup_success";
      resultMsg.value = responseBody["message"];
    } else {
      if (responseBody["message"] == "Token is Blocked" ||
          responseBody["message"] == "Token has expired, please login again") {
        resultStatus.value = "jwt_expired";
        resultMsg.value = "Sesi anda telah berakhir, silahkan login kembali";
      } else {
        resultStatus.value = "transaction_failure";
        transactionData.value = {};
        print("Error: ${responseBody["message"]}");
        resultMsg.value = responseBody["message"];
      }
    }
  }

  Future updateProfileCtrl(Map<String, dynamic> map) async {
    Map<String, dynamic>? temporaryData =
        await localManager!.retrieveTokenAndUserIdAccount();

    HttpModel response = await dashboardService!
        .putUpdateProfile(token: temporaryData!["token"], map: map);

    var responseBody = json.decode(response.body!);

    if (response.code == 200) {
      resultStatus.value = "success_profile";
      resultMsg.value = responseBody["message"];
    } else {
      if (responseBody["message"] == "Token is Blocked" ||
          responseBody["message"] == "Token has expired, please login again") {
        resultStatus.value = "jwt_expired";
        resultMsg.value = "Sesi anda telah berakhir, silahkan login kembali";
      } else {
        resultStatus.value = "transaction_failure";
        transactionData.value = {};
        print("Error: ${responseBody["message"]}");
        resultMsg.value = responseBody["message"];
      }
    }
  }

  Future updateImageProfileCtrl(File imageFile) async {
    Map<String, dynamic>? temporaryData =
        await localManager!.retrieveTokenAndUserIdAccount();

    HttpModel response = await dashboardService!.putUpdateImageProfile(
        token: temporaryData!["token"], imageFile: imageFile);

    var responseBody = json.decode(response.body!);

    if (response.code == 200) {
      resultStatus.value = "success_image_profile";
      resultMsg.value = responseBody["message"];
    } else {
      if (responseBody["message"] == "Token is Blocked" ||
          responseBody["message"] == "Token has expired, please login again") {
        resultStatus.value = "jwt_expired";
        resultMsg.value = "Sesi anda telah berakhir, silahkan login kembali";
      } else {
        resultStatus.value = "transaction_failure";
        transactionData.value = {};
        print("Error: ${responseBody["message"]}");
        resultMsg.value = responseBody["message"];
      }
    }
  }

  Future updatePasswordCtrl(String newPassword) async {
    Map<String, dynamic>? temporaryData =
        await localManager!.retrieveTokenAndUserIdAccount();

    HttpModel response = await dashboardService!.putUpdatePassword(
        token: temporaryData!["token"], newPassword: newPassword);

    var responseBody = json.decode(response.body!);

    if (response.code == 200) {
      resultStatus.value = "success_password";
      resultMsg.value = responseBody["message"];
    } else {
      if (responseBody["message"] == "Token is Blocked" ||
          responseBody["message"] == "Token has expired, please login again") {
        resultStatus.value = "jwt_expired";
        resultMsg.value = "Sesi anda telah berakhir, silahkan login kembali";
      } else {
        resultStatus.value = "transaction_failure";
        transactionData.value = {};
        print("Error: ${responseBody["message"]}");
        resultMsg.value = responseBody["message"];
      }
    }
  }

  Future getAllCategoriesCtrl() async {
    Map<String, dynamic>? temporaryData =
        await localManager!.retrieveTokenAndUserIdAccount();

    HttpModel response = await dashboardService!
        .getAllCategories(token: temporaryData!["token"]);

    var responseBody = json.decode(response.body!);

    if (response.code == 200) {
      categoriesData.value = responseBody;
      await getTransactionDataCtrl(page: 1, categoryId: 0);
    } else {
      if (responseBody["message"] == "Token is Blocked" ||
          responseBody["message"] == "Token has expired, please login again") {
        resultStatus.value = "jwt_expired";
        resultMsg.value = "Sesi anda telah berakhir, silahkan login kembali";
      } else {
        resultStatus.value = "categories_failure";
        print("Error: ${responseBody["message"]}");
        resultMsg.value = responseBody["message"];
      }
    }
  }

  Future removeCategoryCtrl({required int? categoryId}) async {
    Map<String, dynamic>? temporaryData =
        await localManager!.retrieveTokenAndUserIdAccount();

    HttpModel response = await dashboardService!
        .deleteCategory(categoryId: categoryId, token: temporaryData!["token"]);

    var responseBody = json.decode(response.body!);

    if (response.code == 200) {
      resultStatus.value = "categories_remove_success";
      resultMsg.value = "Kategori berhasil dihapus";
    } else {
      if (responseBody["message"] == "Token is Blocked" ||
          responseBody["message"] == "Token has expired, please login again") {
        resultStatus.value = "jwt_expired";
        resultMsg.value = "Sesi anda telah berakhir, silahkan login kembali";
      } else {
        resultStatus.value = "categories_remove_failure";
        resultMsg.value = responseBody["message"];
      }
    }
  }
}
