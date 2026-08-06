part of 'package:catat_uang/import_url_file.dart';

@immutable
class TransactionModel {
    final Pagination? pagination;
    final List<DetailItems>? data;

    const TransactionModel({
        required this.pagination,
        required this.data,
    });

    factory TransactionModel.fromJson(Map<dynamic, dynamic> json) => TransactionModel(
        pagination: Pagination.fromJson(json["pagination"]),
        data: json ["data"] == null ? [] :List<DetailItems>.from(json["data"].map((x) => DetailItems.fromJson(x))),
    );

    Map<dynamic, dynamic> toJson() => {
        "pagination": pagination!.toJson(),
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class DetailItems {
    int? id;
    String? name;
    int? amount;
    String? outletName;
    int? price;
    int? discPercent;
    int? discRp;
    int? totalPrice;
    String? createdAt;
    String? transactionDate;

    DetailItems({
        required this.id,
        required this.name,
        required this.amount,
        required this.outletName,
        required this.price,
        required this.discPercent,
        required this.discRp,
        required this.totalPrice,
        required this.createdAt,
        required this.transactionDate,
    });

    factory DetailItems.fromJson(Map<String, dynamic> json) => DetailItems(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        amount: json["amount"] ?? 0,
        outletName: json["outlet_name"] ?? "",
        price: json["price"] ?? 0,
        discPercent: json["disc_percent"] ?? 0,
        discRp: json["disc_rp"] ?? 0,
        totalPrice: json["total_price"] ?? 0,
        createdAt: json["created_at"] ?? "",
        transactionDate: json["transaction_date"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "amount": amount,
        "outlet_name": outletName,
        "price": price,
        "disc_percent": discPercent,
        "disc_rp": discRp,
        "total_price": totalPrice,
        "created_at": createdAt,
        "transaction_date": transactionDate,
    };
}