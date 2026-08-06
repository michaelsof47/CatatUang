part of 'package:catat_uang/import_url_file.dart';

abstract interface class DashboardServiceInterface {
  Future<HttpModel> getDashboardData({required String token});

  Future<HttpModel> getBalanceAmount({required String token});

  Future<HttpModel> getTransactionData(
      {required String token, int? page, int? categoryId});

  Future<Uint8List> getProfileImage({required String token});

  Future<HttpModel> postLogout({required String token});

  Future<HttpModel> patchTopupBalance({required Map<String, dynamic> map});

  Future<HttpModel> putUpdateProfile(
      {required String token, required Map<String, dynamic> map});

  Future<HttpModel> putUpdateImageProfile(
      {required String token, required File imageFile});

  Future<HttpModel> putUpdatePassword(
      {required String token, required String newPassword});

  Future<HttpModel> getAllCategories({String? token});

  Future<HttpModel> deleteCategory(
      {required int? categoryId, required String? token});
}
