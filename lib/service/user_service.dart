part of 'package:catat_uang/import_url_file.dart';

class UserService {
  String baseUrl = "https://6435a3418221.ngrok-free.app/user";

  Future<Map<String, dynamic>> fetchLogin(
      {required String? email, required String? password}) async {
    var uri = Uri.parse("$baseUrl/login");
    var request = http.MultipartRequest("POST", uri);

    request.fields['emailorphone'] = email!;
    request.fields['password'] = password!;

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

  Future<Map<String, dynamic>> fetchRegister(
      {required Map<String, dynamic>? temporaryData}) async {
    var uri = Uri.parse("$baseUrl/register");
    var request = http.MultipartRequest("POST", uri);

    request.fields['first_name'] = temporaryData!['firstname'];
    request.fields['last_name'] = temporaryData['lastname'];
    request.files.add(http.MultipartFile.fromBytes(
      "url_user_image",
      temporaryData["url_image"].readAsBytesSync(),
      filename: "foto_profil.jpg",
      contentType: MediaType('image', 'jpeg'),
    ));
    request.fields['email'] = temporaryData['email'];
    request.fields['phone'] = temporaryData['phone'];
    request.fields['password'] = temporaryData['password'];

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

  Future<Map<String, dynamic>> checkEmail({required String email}) async {
    var uri = Uri.parse("$baseUrl/check_email");
    var request = http.MultipartRequest("POST", uri);

    request.fields['email'] = email;

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
