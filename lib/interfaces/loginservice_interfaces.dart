part of 'package:catat_uang/import_url_file.dart';

abstract interface class LoginServiceInterfaces {
  Future<HttpModel> postLogin(
      {required String? email, required String? password});

  Future<HttpModel> postRegister(
      {required Map<String, dynamic>? temporaryData});

  Future<HttpModel> postCheckEmail({required String email});
}
