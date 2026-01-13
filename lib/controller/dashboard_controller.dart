part of 'package:catat_uang/import_url_file.dart';

class DashboardController extends GetxController {
  LocalManager? localManager;
  DashboardService? dashboardService;

  var resultMsg;
  var resultStatus;
  RxMap<dynamic, dynamic>? dashboardData;
  RxMap<dynamic, dynamic>? transactionData;
  RxMap<dynamic, dynamic>? categoriesData;
  var balanceAmount;

  DashboardController() {
    localManager = Get.put(LocalManager());
    dashboardService = Get.put(DashboardService());

    resultMsg = "".obs;
    resultStatus = "".obs;
    dashboardData = {}.obs;
    balanceAmount = 0.obs;
    transactionData = {}.obs;
    categoriesData = {}.obs;
  }

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

    Map<String, dynamic>? responseData = await dashboardService!
        .getDashboardData(token: temporaryData!["token"]);
    
    if (responseData["status_code"] == 200) {
      dashboardData!.value = responseData["data"];
      print(responseData["data"]);
      if (isNeedLoadBalance) {
        await getBalanceAmountCtrl(false, token: temporaryData["token"]);
      } else {
        resultStatus.value = "dashboard_success";
      }
    } else {
      if (responseData["data"]["message"] == "Token is Blocked" ||
          responseData["data"]["message"] ==
              "Token has expired, please login again") {
        resultStatus.value = "jwt_expired";
        resultMsg.value = "Sesi anda telah berakhir, silahkan login kembali";
      } else {
        resultStatus.value = "dashboard_failure";
        resultMsg.value = responseData["data"]["message"];
      }
    }
  }

  Future getBalanceAmountCtrl(bool? isTransactionLoad,
      {String? token}) async {
    if (token == null) {
      Map<String, dynamic>? temporaryData =
          await localManager!.retrieveTokenAndUserIdAccount();
      token = temporaryData!["token"];
    }

    Map<String, dynamic>? responseData =
        await dashboardService!.getBalanceAmount(token: token!);

    if (responseData["status_code"] == 200) {
      BalanceModel balanceModel = BalanceModel.fromJson(responseData["data"]);
      balanceAmount.value = balanceModel.balancesAmount;

      localManager!.storedBalanceId(balanceId: balanceModel.id.toString());

      if (isTransactionLoad!) {
        await getAllCategoriesCtrl();
      } else {
        resultStatus.value = "dashboard_success";
      }
    } else {
      if (responseData["data"]["message"] == "Token is Blocked" ||
          responseData["data"]["message"] ==
              "Token has expired, please login again") {
        resultStatus.value = "jwt_expired";
        resultMsg.value = "Sesi anda telah berakhir, silahkan login kembali";
      } else if (responseData["data"]["message"] == "Saldo tidak ditemukan") {
        balanceAmount.value = 0;
        resultStatus.value = "dashboard_success";
      } else {
        resultStatus.value = "dashboard_failure";
        resultMsg.value = responseData["data"]["message"];
      }
    }
  }

  Future getTransactionDataCtrl({int page = 1, int pageSize = 10}) async {
    Map<String, dynamic>? temporaryData =
        await localManager!.retrieveTokenAndUserIdAccount();

    Map<String, dynamic>? responseData = await dashboardService!
        .getTransactionData(token: temporaryData!["token"], page: page, pageSize: pageSize);

    if (responseData["status_code"] == 200) {
      transactionData!.value = responseData["data"];
      resultStatus.value = "transaction_success";
    } else {
      if (responseData["data"]["message"] == "Token is Blocked" ||
          responseData["data"]["message"] ==
              "Token has expired, please login again") {
        resultStatus.value = "jwt_expired";
        resultMsg.value = "Sesi anda telah berakhir, silahkan login kembali";
      } else {
        resultStatus.value = "transaction_failure";
        transactionData!.value = {};
        print("Error: ${responseData["data"]["message"]}");
        resultMsg.value = responseData["data"]["message"];
      }
    }
  }

  Future logoutCtrl() async {
    Map<String, dynamic>? temporaryData =
        await localManager!.retrieveTokenAndUserIdAccount();

    Map<String, dynamic>? responseData =
        await dashboardService!.postLogout(token: temporaryData!["token"]);

    if (responseData["status_code"] == 200) {
      resultStatus.value = "logout_success";
      resultMsg.value = responseData["data"]["message"];
      await resetAccountCtrl();
    } else {
      if (responseData["data"]["message"] == "Token is Blocked" ||
          responseData["data"]["message"] ==
              "Token has expired, please login again") {
        resultStatus.value = "jwt_expired";
        resultMsg.value = "Sesi anda telah berakhir, silahkan login kembali";
      } else {
        resultStatus.value = "transaction_failure";
        transactionData!.value = {};
        print("Error: ${responseData["data"]["message"]}");
        resultMsg.value = responseData["data"]["message"];
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

    Map<String, dynamic>? responseData =
        await dashboardService!.patchTopupBalance(map: requestParams);

    if (responseData["status_code"] == 200) {
      resultStatus.value = "topup_success";
      resultMsg.value = responseData["data"]["message"];
    } else {
      if (responseData["data"]["message"] == "Token is Blocked" ||
          responseData["data"]["message"] ==
              "Token has expired, please login again") {
        resultStatus.value = "jwt_expired";
        resultMsg.value = "Sesi anda telah berakhir, silahkan login kembali";
      } else {
        resultStatus.value = "transaction_failure";
        transactionData!.value = {};
        print("Error: ${responseData["data"]["message"]}");
        resultMsg.value = responseData["data"]["message"];
      }
    }
  }

  Future updateProfileCtrl(Map<String, dynamic> map) async {
    Map<String, dynamic>? temporaryData =
        await localManager!.retrieveTokenAndUserIdAccount();

    Map<String, dynamic>? responseData = await dashboardService!
        .putUpdateProfile(token: temporaryData!["token"], map: map);

    if (responseData!["status_code"] == 200) {
      resultStatus.value = "success_profile";
      resultMsg.value = responseData["data"]["message"];
    } else {
      if (responseData["data"]["message"] == "Token is Blocked" ||
          responseData["data"]["message"] ==
              "Token has expired, please login again") {
        resultStatus.value = "jwt_expired";
        resultMsg.value = "Sesi anda telah berakhir, silahkan login kembali";
      } else {
        resultStatus.value = "transaction_failure";
        transactionData!.value = {};
        print("Error: ${responseData["data"]["message"]}");
        resultMsg.value = responseData["data"]["message"];
      }
    }
  }

  Future updateImageProfileCtrl(File imageFile) async {
    Map<String, dynamic>? temporaryData =
        await localManager!.retrieveTokenAndUserIdAccount();

    Map<String, dynamic>? responseData = await dashboardService!
        .putUpdateImageProfile(
            token: temporaryData!["token"], imageFile: imageFile);

    if (responseData!["status_code"] == 200) {
      resultStatus.value = "success_image_profile";
      resultMsg.value = responseData["data"]["message"];
    } else {
      if (responseData["data"]["message"] == "Token is Blocked" ||
          responseData["data"]["message"] ==
              "Token has expired, please login again") {
        resultStatus.value = "jwt_expired";
        resultMsg.value = "Sesi anda telah berakhir, silahkan login kembali";
      } else {
        resultStatus.value = "transaction_failure";
        transactionData!.value = {};
        print("Error: ${responseData["data"]["message"]}");
        resultMsg.value = responseData["data"]["message"];
      }
    }
  }

  Future updatePasswordCtrl(String newPassword) async {
    Map<String, dynamic>? temporaryData =
        await localManager!.retrieveTokenAndUserIdAccount();

    Map<String, dynamic>? responseData = await dashboardService!
        .putUpdatePassword(
            token: temporaryData!["token"], newPassword: newPassword);

    if (responseData!["status_code"] == 200) {
      resultStatus.value = "success_password";
      resultMsg.value = responseData["data"]["message"];
    } else {
      if (responseData["data"]["message"] == "Token is Blocked" ||
          responseData["data"]["message"] ==
              "Token has expired, please login again") {
        resultStatus.value = "jwt_expired";
        resultMsg.value = "Sesi anda telah berakhir, silahkan login kembali";
      } else {
        resultStatus.value = "transaction_failure";
        transactionData!.value = {};
        print("Error: ${responseData["data"]["message"]}");
        resultMsg.value = responseData["data"]["message"];
      }
    }
  }

  Future getAllCategoriesCtrl() async {
    Map<String, dynamic>? temporaryData =
        await localManager!.retrieveTokenAndUserIdAccount();

    Map<String, dynamic>? responseData = await dashboardService!
        .getAllCategories(token: temporaryData!["token"]);

    if (responseData["status_code"] == 200) {
      categoriesData!.value = responseData["data"];
      await getTransactionDataCtrl();
    } else {
      if (responseData["data"]["message"] == "Token is Blocked" ||
          responseData["data"]["message"] ==
              "Token has expired, please login again") {
        resultStatus.value = "jwt_expired";
        resultMsg.value = "Sesi anda telah berakhir, silahkan login kembali";
      } else {
        resultStatus.value = "categories_failure";
        print("Error: ${responseData["data"]["message"]}");
        resultMsg.value = responseData["data"]["message"];
      }
    }
  }

  Future removeCategoryCtrl({required int? categoryId}) async {
    Map<String,dynamic>? temporaryData = await localManager!.retrieveTokenAndUserIdAccount();

    Map<String,dynamic>? responseData = await dashboardService!.deleteCategory(categoryId: categoryId, token: temporaryData!["token"]);

    if(responseData!["status_code"] == 200) {
      resultStatus.value = "categories_remove_success";
      resultMsg.value = "Kategori berhasil dihapus";
    } else {
      if (responseData["data"]["message"] == "Token is Blocked" || responseData["data"]["message"] == "Token has expired, please login again") {
        resultStatus.value = "jwt_expired";
        resultMsg.value = "Sesi anda telah berakhir, silahkan login kembali";
      } else {
        resultStatus.value = "categories_remove_failure";
        resultMsg.value = responseData["data"]["message"];
      }
    }
  }
}
