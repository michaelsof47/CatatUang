part of 'package:catat_uang/import_url_file.dart';

class PlannerController extends BaseController {
  PlannerServiceInterface? service;
  LocalManager? localManager;

  RxMap<dynamic, dynamic>? bookList;

  late RxString resultMessage;
  late RxString resultStatus;

  PlannerController({
    required this.service,
    required this.localManager,
  }) {
    resultMessage = "".obs;
    resultStatus = "".obs;
    bookList = {}.obs;
  }

  @override
  resetResponse() {
    resultMessage.value = "";
    resultStatus.value = "";
  }

  Future retrieveBookList({required int currentPage, required String filter}) async {
    Map<String, dynamic> temporaryData =
        await localManager!.retrieveTokenAndUserIdAccount();

    HttpModel response =
        await service!.getBookList(currentPage: currentPage,filter: filter, token: temporaryData["token"]);

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
