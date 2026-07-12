part of 'package:catat_uang/import_url_file.dart';

class UserService {
  Future<HttpModel> postLogin(
      {required String? email, required String? password}) async {
    var uri = Uri.parse("${GeneralUtils().baseUrl}/user/login");
    var request = http.MultipartRequest("POST", uri);

    request.fields['emailorphone'] = email!;
    request.fields['password'] = password!;

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    return HttpModel(code: response.statusCode, body: response.body);
  }

  Future<HttpModel> postRegister(
      {required Map<String, dynamic>? temporaryData}) async {
    var uri = Uri.parse("${GeneralUtils().baseUrl}/user/register");
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

    return HttpModel(code: response.statusCode, body: response.body);
  }

  Future<HttpModel> postCheckEmail({required String email}) async {
    var uri = Uri.parse("${GeneralUtils().baseUrl}/user/check_email");
    var request = http.MultipartRequest("POST", uri);

    request.fields['email'] = email;

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    return HttpModel(code: response.statusCode, body: response.body);
  }
}
