part of 'package:catat_uang/import_url_file.dart';

class DashboardController extends GetxController {
  LocalManager? localManager;
  DashboardService? dashboardService;

  var resultMsg;
  var resultStatus;
  RxMap<dynamic, dynamic>? dashboardData;
  RxMap<dynamic, dynamic>? transactionData;
  var balanceAmount;

  DashboardController() {
    localManager = Get.put(LocalManager());
    dashboardService = Get.put(DashboardService());

    resultMsg = "".obs;
    resultStatus = "".obs;
    dashboardData = {}.obs;
    balanceAmount = 0.obs;
    transactionData = {}.obs;
  }

  void resetResponse() {
    resultMsg.value = "";
    resultStatus.value = "";
  }

  Future resetAccountCtrl() async {
    await localManager!.storedTokenAndUserIdAccount(map: {});
    await localManager!.storedLoginStatusAccount(false);
  }

  Future fetchDashboardDataCtrl(bool isNeedLoadBalance) async {
    Map<String, dynamic>? temporaryData =
        await localManager!.retrieveTokenAndUserIdAccount();

    Map<String, dynamic>? responseData = await dashboardService!
        .fetchDashboardData(token: temporaryData!["token"]);

    if (responseData["status_code"] == 200) {
      dashboardData!.value = responseData["data"];
      print(responseData["data"]);
      if(isNeedLoadBalance) {
        await fetchBalanceAmountCtrl(temporaryData["token"]);
      } else {
        resultStatus.value = "dashboard_success";
      }
    } else {
      if (responseData["data"]["message"] == "jwt expired" ||
          responseData["data"]["message"] == "Token is Blocked") {
        resultStatus.value = "jwt_expired";
        resultMsg.value = "Sesi anda telah berakhir, silahkan login kembali";
      } else {
        resultStatus.value = "dashboard_failure";
        resultMsg.value = responseData["data"]["error"];
      }
    }
  }

  Future fetchBalanceAmountCtrl(String token) async {
    Map<String, dynamic>? responseData =
        await dashboardService!.fetchBalanceAmount(token: token);

    if (responseData["status_code"] == 200) {
      BalanceModel balanceModel = BalanceModel.fromJson(responseData["data"]);
      balanceAmount.value = balanceModel.balancesAmount;
      resultStatus.value = "dashboard_success";
    } else {
      if (responseData["data"]["message"] == "jwt expired" ||
          responseData["data"]["message"] == "Token is Blocked") {
        resultStatus.value = "jwt_expired";
        resultMsg.value = "Sesi anda telah berakhir, silahkan login kembali";
      } else if(responseData["data"]["error"] == "Saldo tidak ditemukan") {
        balanceAmount.value = 0;
        resultStatus.value = "dashboard_success";
      } else {
        resultStatus.value = "dashboard_failure";
        resultMsg.value = responseData["data"]["error"];
      }
    }
  }

  Future fetchTransactionDataCtrl() async {
    Map<String, dynamic>? temporaryData =
        await localManager!.retrieveTokenAndUserIdAccount();

    Map<String, dynamic>? responseData = await dashboardService!
        .fetchTransactionData(token: temporaryData!["token"]);

    if (responseData["status_code"] == 200) {
      transactionData!.value = responseData["data"];
      resultStatus.value = "transaction_success";
    } else {
      if (responseData["data"]["message"] == "jwt expired" ||
          responseData["data"]["message"] == "Token is Blocked") {
        resultStatus.value = "jwt_expired";
        resultMsg.value = "Sesi anda telah berakhir, silahkan login kembali";
      } else {
        resultStatus.value = "transaction_failure";
        transactionData!.value = {};
        print("Error: ${responseData["data"]["error"]}");
        resultMsg.value = responseData["data"]["error"];
      }
    }
  }

  Future fetchLogoutCtrl() async {
    Map<String, dynamic>? temporaryData =
        await localManager!.retrieveTokenAndUserIdAccount();

    Map<String, dynamic>? responseData =
        await dashboardService!.fetchLogout(token: temporaryData!["token"]);

    if (responseData["status_code"] == 200) {
      resultStatus.value = "logout_success";
      resultMsg.value = responseData["data"]["message"];
      await resetAccountCtrl();
    } else {
      if (responseData["data"]["message"] == "jwt expired" ||
          responseData["data"]["message"] == "Token is Blocked") {
        resultStatus.value = "jwt_expired";
        resultMsg.value = "Sesi anda telah berakhir, silahkan login kembali";
      } else {
        resultStatus.value = "transaction_failure";
        transactionData!.value = {};
        print("Error: ${responseData["data"]["error"]}");
        resultMsg.value = responseData["data"]["error"];
      }
    }
  }

  Future fetchTopupCtrl(String amount) async {
    Map<String, dynamic>? temporaryData =
        await localManager!.retrieveTokenAndUserIdAccount();

    Map<String, dynamic> requestParams = {
      "amount": amount,
      "user_id": temporaryData!["user_id"],
      "token": temporaryData["token"]
    };

    Map<String, dynamic>? responseData =
        await dashboardService!.fetchTopup(map: requestParams);

    if (responseData["status_code"] == 200) {
      resultStatus.value = "topup_success";
      resultMsg.value = responseData["data"]["message"];
    } else {
      if (responseData["data"]["message"] == "jwt expired" ||
          responseData["data"]["message"] == "Token is Blocked") {
        resultStatus.value = "jwt_expired";
        resultMsg.value = "Sesi anda telah berakhir, silahkan login kembali";
      } else {
        resultStatus.value = "transaction_failure";
        transactionData!.value = {};
        print("Error: ${responseData["data"]["error"]}");
        resultMsg.value = responseData["data"]["error"];
      }
    }
  }

  Future fetchUpdateProfileCtrl(Map<String, dynamic> map) async {
    Map<String, dynamic>? temporaryData =
        await localManager!.retrieveTokenAndUserIdAccount();

    Map<String, dynamic>? responseData = await dashboardService!
        .fetchUpdateProfile(token: temporaryData!["token"], map: map);

    if (responseData!["status_code"] == 200) {
      resultStatus.value = "success_profile";
      resultMsg.value = responseData["data"]["message"];
    } else {
      if (responseData["data"]["message"] == "jwt expired" ||
          responseData["data"]["message"] == "Token is Blocked") {
        resultStatus.value = "jwt_expired";
        resultMsg.value = "Sesi anda telah berakhir, silahkan login kembali";
      } else {
        resultStatus.value = "transaction_failure";
        transactionData!.value = {};
        print("Error: ${responseData["data"]["error"]}");
        resultMsg.value = responseData["data"]["error"];
      }
    }
  }

  Future fetchUpdateImageProfileCtrl(File imageFile) async {
    Map<String, dynamic>? temporaryData =
        await localManager!.retrieveTokenAndUserIdAccount();

    Map<String, dynamic>? responseData = await dashboardService!
        .fetchUpdateImageProfile(
            token: temporaryData!["token"], imageFile: imageFile);

    if (responseData!["status_code"] == 200) {
      resultStatus.value = "success_image_profile";
      resultMsg.value = responseData["data"]["message"];
    } else {
      if (responseData["data"]["message"] == "jwt expired" ||
          responseData["data"]["message"] == "Token is Blocked") {
        resultStatus.value = "jwt_expired";
        resultMsg.value = "Sesi anda telah berakhir, silahkan login kembali";
      } else {
        resultStatus.value = "transaction_failure";
        transactionData!.value = {};
        print("Error: ${responseData["data"]["error"]}");
        resultMsg.value = responseData["data"]["error"];
      }
    }
  }

  Future fetchUpdatePasswordCtrl(String newPassword) async {
    Map<String, dynamic>? temporaryData =
        await localManager!.retrieveTokenAndUserIdAccount();

    Map<String, dynamic>? responseData = await dashboardService!
        .fetchUpdatePassword(
            token: temporaryData!["token"], newPassword: newPassword);

    if(responseData!["status_code"] == 200) {
      resultStatus.value = "success_password";
      resultMsg.value = responseData["data"]["message"];
    } else {
      if (responseData["data"]["message"] == "jwt expired" ||
          responseData["data"]["message"] == "Token is Blocked") {
        resultStatus.value = "jwt_expired";
        resultMsg.value = "Sesi anda telah berakhir, silahkan login kembali";
      } else {
        resultStatus.value = "transaction_failure";
        transactionData!.value = {};
        print("Error: ${responseData["data"]["error"]}");
        resultMsg.value = responseData["data"]["error"];
      }
    }
  }
}
