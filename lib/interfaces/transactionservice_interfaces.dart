part of 'package:catat_uang/import_url_file.dart';

abstract interface class TransactionServiceInterface {
  Future<HttpModel> postCreateCategory({required Map<String, dynamic> map, String? token});

  Future<HttpModel> postCreateTransaction({required Map<String, dynamic> map,String? token,String? balanceId});
}
