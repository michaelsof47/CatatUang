part of 'package:catat_uang/import_url_file.dart';

class PlannerService extends BaseService implements PlannerServiceInterface {
  
  @override
  Future<HttpModel> getBookList({required int currentPage, required String filter, required String token}) async {
    var uri = Uri.parse("$baseUrl/planner_books/?page=$currentPage&limit=10&book_name=$filter");

    var response =
        await http.get(uri, headers: {"Authorization": "Bearer $token"});

    return HttpModel(code: response.statusCode, body: response.body);
  }

  @override
  Future<HttpModel> createBook({required CreatePlannerBookModel model, required String token}) async {
    return HttpModel(code: 0, body: "");
  }

}
