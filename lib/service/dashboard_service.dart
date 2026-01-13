part of 'package:catat_uang/import_url_file.dart';

class DashboardService {
  Map<String, dynamic>? responseMap(response) {
    print("status code: ${response.statusCode}");
    print("status body: ${response.body}");

    return {
      "status_code": response.statusCode,
      "data": json.decode(response.body),
    };
  }

  Future<Map<String, dynamic>> getDashboardData(
      {required String token}) async {
    var uri = Uri.parse("${GeneralUtils().baseUrl}/user/profile");

    var response =
        await http.get(uri, headers: {"Authorization": "Bearer $token"});

    return responseMap(response)!;
  }

  Future<Map<String, dynamic>> getBalanceAmount(
      {required String token}) async {
    var uri = Uri.parse("${GeneralUtils().baseUrl}/balance");

    var response =
        await http.get(uri, headers: {"Authorization": "Bearer $token"});

    return responseMap(response)!;
  }

  Future<Map<String, dynamic>> getTransactionData(
      {required String token, int? page, int? pageSize}) async {
    var uri = Uri.parse("${GeneralUtils().baseUrl}/transactions/$page/$pageSize");
    
    var response =
        await http.get(uri, headers: {"Authorization": "Bearer $token"});

    return responseMap(response)!;
  }

  Future<Map<String, dynamic>> postLogout({required String token}) async {
    var uri = Uri.parse("${GeneralUtils().baseUrl}/user/logout");

    var response =
        await http.post(uri, headers: {"Authorization": "Bearer $token"});

    return responseMap(response)!;
  }

  Future<Map<String, dynamic>> patchTopupBalance(
      {required Map<String, dynamic> map}) async {
    var uri = Uri.parse("${GeneralUtils().baseUrl}/balance/");
    var request = http.MultipartRequest("PATCH", uri);

    request.headers.addAll({"Authorization": "Bearer ${map["token"]}"});

    request.fields['balances_amount'] = map["amount"];
    request.fields['user_id'] = map["user_id"].toString();

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    return responseMap(response)!;
  }

  Future<Map<String, dynamic>>? putUpdateProfile(
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

    return responseMap(response)!;
  }

  Future<Map<String, dynamic>>? putUpdateImageProfile(
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

    return responseMap(response)!;
  }

  Future<Map<String, dynamic>>? putUpdatePassword(
      {required String token, required String newPassword}) async {
    var uri = Uri.parse("${GeneralUtils().baseUrl}/user/profile/password");
    var request = http.MultipartRequest("PUT", uri);

    request.headers.addAll({"Authorization": "Bearer $token"});

    request.fields['password'] = newPassword;

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    return responseMap(response)!;
  }

  Future<Map<String, dynamic>> getAllCategories({String? token}) async {
    var uri = Uri.parse("${GeneralUtils().baseUrl}/transactions/categories");

    var response =
        await http.get(uri, headers: {"Authorization": "Bearer $token"});

    return responseMap(response)!;
  }

  Future<Map<String,dynamic>>? deleteCategory({required int? categoryId, required String? token}) async {
    var uri = Uri.parse("${GeneralUtils().baseUrl}/transactions/categories/$categoryId");
    var request = http.Request("DELETE", uri);

    request.headers.addAll({"Authorization": "Bearer $token"});

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    return responseMap(response)!;
  }
}
