part of 'package:catat_uang/import_url_file.dart';

class DashboardService {
  Future<HttpModel> getDashboardData({required String token}) async {
    var uri = Uri.parse("${GeneralUtils().baseUrl}/user/profile");

    var response =
        await http.get(uri, headers: {"Authorization": "Bearer $token"});

    return HttpModel(code: response.statusCode, body: response.body);
  }

  Future<HttpModel> getBalanceAmount({required String token}) async {
    var uri = Uri.parse("${GeneralUtils().baseUrl}/balance");

    var response =
        await http.get(uri, headers: {"Authorization": "Bearer $token"});

    return HttpModel(code: response.statusCode, body: response.body);
  }

  Future<HttpModel> getTransactionData(
      {required String token, int? page, int? categoryId}) async {
    var uri;

    print("category id: $categoryId");

    if (categoryId == 0) {
      uri = Uri.parse(
          "${GeneralUtils().baseUrl}/transactions/?page=$page&limit=10");
    } else {
      uri = Uri.parse(
          "${GeneralUtils().baseUrl}/transactions/?page=$page&limit=10&categoryId=$categoryId");
    }

    var response =
        await http.get(uri, headers: {"Authorization": "Bearer $token"});

    return HttpModel(code: response.statusCode, body: response.body);
  }

  Future<Uint8List> getProfileImage({required String token}) async {
    var uri = Uri.parse("${GeneralUtils().baseUrl}/user/profile/picture");

    var response =
        await http.get(uri, headers: {"Authorization": "Bearer $token"});

    return response.bodyBytes;
  }

  Future<HttpModel> postLogout({required String token}) async {
    var uri = Uri.parse("${GeneralUtils().baseUrl}/user/logout");

    var response =
        await http.post(uri, headers: {"Authorization": "Bearer $token"});

    return HttpModel(code: response.statusCode, body: response.body);
  }

  Future<HttpModel> patchTopupBalance(
      {required Map<String, dynamic> map}) async {
    var uri = Uri.parse("${GeneralUtils().baseUrl}/balance/");
    var request = http.MultipartRequest("PATCH", uri);

    request.headers.addAll({"Authorization": "Bearer ${map["token"]}"});

    request.fields['balances_amount'] = map["amount"];
    request.fields['user_id'] = map["user_id"].toString();

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    return HttpModel(code: response.statusCode, body: response.body);
  }

  Future<HttpModel> putUpdateProfile(
      {required String token, required Map<String, dynamic> map}) async {
    var uri = Uri.parse("${GeneralUtils().baseUrl}/user/profile");
    var request = http.MultipartRequest("PUT", uri);

    request.headers.addAll({"Authorization": "Bearer $token"});

    request.fields['first_name'] = map['firstName'];
    request.fields['last_name'] = map['lastName'];
    request.fields['email'] = map['email'];
    request.fields['phone'] = map['phone'];

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    return HttpModel(code: response.statusCode, body: response.body);
  }

  Future<HttpModel> putUpdateImageProfile(
      {required String token, required File imageFile}) async {
    var uri = Uri.parse("${GeneralUtils().baseUrl}/user/profile/photo");
    var request = http.MultipartRequest("PUT", uri);

    request.headers.addAll({"Authorization": "Bearer $token"});

    request.files.add(http.MultipartFile.fromBytes(
      "url_user_image",
      imageFile.readAsBytesSync(),
      filename: "foto_profil.jpg",
      contentType: MediaType('image', 'jpeg'),
    ));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    return HttpModel(code: response.statusCode, body: response.body);
  }

  Future<HttpModel> putUpdatePassword(
      {required String token, required String newPassword}) async {
    var uri = Uri.parse("${GeneralUtils().baseUrl}/user/profile/password");
    var request = http.MultipartRequest("PUT", uri);

    request.headers.addAll({"Authorization": "Bearer $token"});

    request.fields['password'] = newPassword;

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    return HttpModel(code: response.statusCode, body: response.body);
  }

  Future<HttpModel> getAllCategories({String? token}) async {
    var uri = Uri.parse("${GeneralUtils().baseUrl}/transactions/categories");

    var response =
        await http.get(uri, headers: {"Authorization": "Bearer $token"});

    return HttpModel(code: response.statusCode, body: response.body);
  }

  Future<HttpModel> deleteCategory(
      {required int? categoryId, required String? token}) async {
    var uri = Uri.parse(
        "${GeneralUtils().baseUrl}/transactions/categories/$categoryId");
    var request = http.Request("DELETE", uri);

    request.headers.addAll({"Authorization": "Bearer $token"});

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    return HttpModel(code: response.statusCode, body: response.body);
  }
}
