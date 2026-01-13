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

  Future addCategoryCtrl({required Map<String,dynamic>? map}) async {

    Map<String,dynamic>? temporaryData = await localManager!.retrieveTokenAndUserIdAccount();

    Map<String,dynamic>? responseData = await service!.postCreateCategory(map: map!, token: temporaryData!["token"]);
    
    if(responseData!["status_code"] == 201) {
      resultStatus.value = "cetegories_success";
      resultMessage.value = "Kategori berhasil ditambahkan"; 
    } else {
      if (responseData["data"]["message"] == "Token is Blocked" || responseData["data"]["message"] == "Token has expired, please login again") {
        resultStatus.value = "jwt_expired";
        resultMessage.value = "Sesi anda telah berakhir, silahkan login kembali";
      } else {
        resultStatus.value = "categories_failure";
        resultMessage.value = responseData["data"]["message"];
      }
    }
  }

  Future addTransactionCtrl({required Map<String,dynamic>? map}) async {
    Map<String,dynamic>? temporaryData = await localManager!.retrieveTokenAndUserIdAccount();
    String? balanceId = await localManager!.retrieveBalanceId();

    Map<String,dynamic>? responseData = await service!.postCreateTransaction(map: map!, token: temporaryData!["token"],balanceId: balanceId!);

    print("${temporaryData!["token"]}, $map, $balanceId");

    if(responseData!["status_code"] == 201) {
      resultStatus.value = "transaction_success";
      resultMessage.value = "Transaksi berhasil ditambahkan"; 
    } else {
      if (responseData["data"]["message"] == "Token is Blocked" || responseData["data"]["message"] == "Token has expired, please login again") {
        resultStatus.value = "jwt_expired";
        resultMessage.value = "Sesi anda telah berakhir, silahkan login kembali";
      } else {
        resultStatus.value = "transaction_failure";
        resultMessage.value = responseData["data"]["message"];
      }
    }
  }
  
}