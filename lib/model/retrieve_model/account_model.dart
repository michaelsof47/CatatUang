part of 'package:catat_uang/import_url_file.dart';

class AccountModel {
    final int? id;
    final String? firstName;
    final String? lastName;
    final String? rewardStatus;
    final String? email;
    final String? phone;
    final String? profileImageUrl;

    const AccountModel({
        this.id,
        this.firstName,
        this.lastName,
        this.rewardStatus,
        this.email,
        this.phone,
        this.profileImageUrl,
    });

    factory AccountModel.fromJson(Map<dynamic, dynamic> json) => AccountModel(
        id: json["id"] ?? 0,
        firstName: json["first_name"] ?? "",
        lastName: json["last_name"] ?? "",
        rewardStatus: json["reward_status"] ?? "",
        email: json["email"] ?? "",
        phone: json["phone"] ?? "",
        profileImageUrl: json["profile_image_url"] ?? "",
    );

    Map<dynamic, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "reward_status": rewardStatus,
        "email": email,
        "phone": phone,
        "profile_image_url": profileImageUrl,
    };
}
