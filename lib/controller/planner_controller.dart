part of 'package:catat_uang/import_url_file.dart';

class PlannerController extends GetxController {
  PlannerService? service;
  LocalManager? localManager;

  RxMap<dynamic, dynamic>? bookList;

  var resultMessage;
  var resultStatus;

  PlannerController() {
    service = Get.put(PlannerService());
    localManager = Get.put(LocalManager());
    resultMessage = "".obs;
    resultStatus = "".obs;
    bookList = {}.obs;
  }

  resetResponse() {
    resultMessage.value = "";
    resultStatus.value = "";
  }

  Future retrieveBookList() async {
    Map<String, dynamic> temporaryData =
        await localManager!.retrieveTokenAndUserIdAccount();

    HttpModel response =
        await service!.getBookList(token: temporaryData["token"]);

    var responseBody = json.decode(response.body!);

    if (response.code == 200) {
      bookList!.value = responseBody;
      resultStatus.value = "retrieve_book_success";
    } else {
      if (responseBody["message"] == "Token is Blocked" ||
          responseBody["message"] == "Token has expired, please login again") {
        resultStatus.value = "jwt_expired";
        resultMessage.value =
            "Sesi anda telah berakhir, silahkan login kembali";
      } else {
        resultStatus.value = "retrieve_book_failure";
        resultMessage.value = responseBody["message"];
      }
    }
  }
}
