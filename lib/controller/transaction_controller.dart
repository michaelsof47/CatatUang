part of 'package:catat_uang/import_url_file.dart';

class TransactionController extends GetxController {
  TransactionService? service;
  LocalManager? localManager;

  var resultMessage;
  var resultStatus;

  TransactionController() {
    service = Get.put(TransactionService());
    localManager = Get.put(LocalManager());
    resultMessage = "".obs;
    resultStatus = "".obs;
  }

  resetResponse() {
    resultMessage.value = "";
    resultStatus.value = "";
  }

  Future addCategoryCtrl({required Map<String, dynamic>? map}) async {
    Map<String, dynamic>? temporaryData =
        await localManager!.retrieveTokenAndUserIdAccount();

    HttpModel response = await service!
        .postCreateCategory(map: map!, token: temporaryData!["token"]);

    var responseBody = json.decode(response.body!);

    if (response.code == 201) {
      resultStatus.value = "cetegories_success";
      resultMessage.value = "Kategori berhasil ditambahkan";
    } else {
      if (responseBody["message"] == "Token is Blocked" ||
          responseBody["message"] == "Token has expired, please login again") {
        resultStatus.value = "jwt_expired";
        resultMessage.value =
            "Sesi anda telah berakhir, silahkan login kembali";
      } else {
        resultStatus.value = "categories_failure";
        resultMessage.value = responseBody["message"];
      }
    }
  }

  Future addTransactionCtrl({required Map<String, dynamic>? map}) async {
    Map<String, dynamic>? temporaryData =
        await localManager!.retrieveTokenAndUserIdAccount();
    String? balanceId = await localManager!.retrieveBalanceId();

    HttpModel response = await service!.postCreateTransaction(
        map: map!, token: temporaryData!["token"], balanceId: balanceId!);

    print("${temporaryData!["token"]}, $map, $balanceId");

    var responseBody = json.decode(response.body!);

    if (response.code == 201) {
      resultStatus.value = "transaction_success";
      resultMessage.value = "Transaksi berhasil ditambahkan";
    } else {
      if (responseBody["message"] == "Token is Blocked" ||
          responseBody["message"] == "Token has expired, please login again") {
        resultStatus.value = "jwt_expired";
        resultMessage.value =
            "Sesi anda telah berakhir, silahkan login kembali";
      } else {
        resultStatus.value = "transaction_failure";
        resultMessage.value = responseBody["message"];
      }
    }
  }
}
