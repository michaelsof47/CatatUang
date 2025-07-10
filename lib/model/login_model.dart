part of 'package:catat_uang/import_url_file.dart';

class LoginModel {
    String? message;
    int? userId;
    String? token;

    LoginModel({
        required this.message,
        required this.userId,
        required this.token,
    });

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        message: json["message"] != null ? json["message"] : "",
        userId: json["userId"] != null ? json["userId"] : 0,
        token: json["token"] != null ? json["token"] : "",
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "userId": userId,
        "token": token,
    };
}
