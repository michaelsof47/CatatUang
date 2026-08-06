part of 'package:catat_uang/import_url_file.dart';

@immutable
class BalanceModel {
    final int? id;
    final int? balancesAmount;

    BalanceModel({
        this.id,
        this.balancesAmount,
    });

    factory BalanceModel.fromJson(Map<String, dynamic> json) => BalanceModel(
        id: json["id"] ?? 0,
        balancesAmount: json["balances_amount"] ?? 0,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "balances_amount": balancesAmount,
    };
}
