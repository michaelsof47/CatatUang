part of 'package:catat_uang/import_url_file.dart';

class AccountModel {
    int? id;
    String? firstName;
    String? lastName;
    String? rewardStatus;
    String? email;
    String? phone;

    AccountModel({
        this.id,
        this.firstName,
        this.lastName,
        this.rewardStatus,
        this.email,
        this.phone,
    });

    factory AccountModel.fromJson(Map<dynamic, dynamic> json) => AccountModel(
        id: json["id"] != null ? json["id"] : 0,
        firstName: json["first_name"] != null ? json["first_name"] : "",
        lastName: json["last_name"] != null ? json["last_name"] : "",
        rewardStatus: json["reward_status"] != null ? json["reward_status"] : 
        "",
        email: json["email"] != null ? json["email"] : "",
        phone: json["phone"] != null ? json["phone"] : "",
    );

    Map<dynamic, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "reward_status": rewardStatus,
        "email": email,
        "phone": phone,
    };
}
