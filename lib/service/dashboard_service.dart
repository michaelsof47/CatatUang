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
}