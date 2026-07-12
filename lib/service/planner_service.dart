part of 'package:catat_uang/import_url_file.dart';

class PlannerService {
  Future<HttpModel> getBookList({required String token}) async {
    var uri = Uri.parse("${GeneralUtils().baseUrl}/planner_books/");

    var response =
        await http.get(uri, headers: {"Authorization": "Bearer $token"});

    return HttpModel(code: response.statusCode, body: response.body);
  }
}
