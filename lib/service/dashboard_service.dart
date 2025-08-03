part of 'package:catat_uang/import_url_file.dart';

class DashboardService {

  Future<Map<String,dynamic>> fetchDashboardData({required String token}) async {
    var uri = Uri.parse("${GeneralUtils().baseUrl}/user");

    var response = await http.get(uri, headers: {"Authorization": "Bearer $token"});

    print("status code: ${response.statusCode}");
    print("status body: ${response.body}");

    final Map<String, dynamic> data = {
      "status_code": response.statusCode,
      "data": json.decode(response.body),
    };

    return data;
  }

  Future<Map<String,dynamic>> fetchBalanceAmount({required String token}) async {
    var uri = Uri.parse("${GeneralUtils().baseUrl}/balance");

    var response = await http.get(uri, headers: {"Authorization": "Bearer $token"});

    print("status code: ${response.statusCode}");
    print("status body: ${response.body}");

    final Map<String, dynamic> data = {
      "status_code": response.statusCode,
      "data": json.decode(response.body),
    };

    return data;
  }

  Future<Map<String, dynamic>> fetchTransactionData({required String token}) async {
    var uri = Uri.parse("${GeneralUtils().baseUrl}/transactions/get_transactions");

    var response = await http.get(uri, headers: {"Authorization": "Bearer $token"});

    print("status code: ${response.statusCode}");
    print("status body: ${response.body}");

    final Map<String, dynamic> data = {
      "status_code": response.statusCode,
      "data": json.decode(response.body),
    };

    return data;
  }

  Future<Map<String,dynamic>> fetchLogout({required String token}) async {
    var uri = Uri.parse("${GeneralUtils().baseUrl}/user/logout");

    var response = await http.post(uri, headers: {"Authorization": "Bearer $token"});

    print("status code: ${response.statusCode}");
    print("status body: ${response.body}");

    final Map<String, dynamic> data = {
      "status_code": response.statusCode,
      "data": json.decode(response.body),
    };

    return data;
  }

  Future<Map<String,dynamic>> fetchTopup({required Map<String,dynamic> map}) async {
    var uri = Uri.parse("${GeneralUtils().baseUrl}/balance/add_more_balances");
    var request = http.MultipartRequest("POST", uri);

    request.headers.addAll({"Authorization": "Bearer ${map["token"]}"});

    request.fields['balances_amount'] = map["amount"];
    request.fields['user_id'] = map["user_id"].toString();

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    print("status code: ${response.statusCode}");
    print("status body: ${response.body}");

    final Map<String, dynamic> data = {
      "status_code": response.statusCode,
      "data": json.decode(response.body),
    };

    return data;
  }

  Future<Map<String,dynamic>>? fetchUpdateProfile({required String token, required Map<String,dynamic> map}) async {
    var uri = Uri.parse("${GeneralUtils().baseUrl}/user/update_profile");
    var request = http.MultipartRequest("POST", uri);

    request.headers.addAll({"Authorization": "Bearer $token"});

    request.fields['first_name'] = map['firstName'];
    request.fields['last_name'] = map['lastName'];
    request.fields['email'] = map['email'];
    request.fields['phone'] = map['phone'];

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    print("status code: ${response.statusCode}");
    print("status body: ${response.body}");

    final Map<String, dynamic> data = {
      "status_code": response.statusCode,
      "data": json.decode(response.body),
    };

    return data;
  }

  Future<Map<String,dynamic>>? fetchUpdateImageProfile({required String token, required File imageFile}) async {
    var uri = Uri.parse("${GeneralUtils().baseUrl}/user/update_photo_profile");
    var request = http.MultipartRequest("POST",uri);

    request.headers.addAll({"Authorization": "Bearer $token"});

    request.files.add(http.MultipartFile.fromBytes(
      "url_user_image",
      imageFile.readAsBytesSync(),
      filename: "foto_profil.jpg",
      contentType: MediaType('image', 'jpeg'),
    ));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    print("status code: ${response.statusCode}");
    print("status body: ${response.body}");

    final Map<String, dynamic> data = {
      "status_code": response.statusCode,
      "data": json.decode(response.body),
    };

    return data;
  }

  Future<Map<String,dynamic>>? fetchUpdatePassword({required String token, required String newPassword}) async {
    var uri = Uri.parse("${GeneralUtils().baseUrl}/user/update_password");
    var request = http.MultipartRequest("POST", uri);

    request.headers.addAll({"Authorization": "Bearer $token"});

    request.fields['password'] = newPassword;

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    print("status code: ${response.statusCode}");
    print("status body: ${response.body}");

    final Map<String, dynamic> data = {
      "status_code": response.statusCode,
      "data": json.decode(response.body),
    };

    return data;
  }
}