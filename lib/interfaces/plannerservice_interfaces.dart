part of 'package:catat_uang/import_url_file.dart';

abstract interface class PlannerServiceInterface {
  Future<HttpModel> getBookList({required int currentPage, required String filter, required String token});
}