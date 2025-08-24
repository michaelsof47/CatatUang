part of 'package:catat_uang/import_url_file.dart';

class TransactionModel {
    int? count;
    List<DetailsItem>? detailsItem;

    TransactionModel({
        this.count,
        this.detailsItem,
    });

    factory TransactionModel.fromJson(Map<dynamic, dynamic> json) => TransactionModel(
      count: json["count"] ?? 0,
      detailsItem: json["details_item"] == null
          ? []
          : List<DetailsItem>.from(
              (json["details_item"] as List<dynamic>).map((x) => DetailsItem.fromJson(x)),
            ),
  );

    Map<dynamic, dynamic> toJson() => {
        "count": count,
        "details_item": detailsItem == null ? [] : List<dynamic>.from(detailsItem!.map((x) => x.toJson())),
    };
}

class DetailsItem {
    int? id;
    String? name;
    int? amount;
    String? outletName;
    int? price;
    dynamic discPercent;
    dynamic discRp;
    int? totalPrice;
    String? createdAt;

    DetailsItem({
        this.id,
        this.name,
        this.amount,
        this.outletName,
        this.price,
        this.discPercent,
        this.discRp,
        this.totalPrice,
        this.createdAt,
    });

    factory DetailsItem.fromJson(Map<String, dynamic> json) => DetailsItem(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        amount: json["amount"] ?? 0,
        outletName: json["outlet_name"] ?? "",
        price: json["price"] ?? 0,
        discPercent: json["disc_percent"] ?? 0,
        discRp: json["disc_rp"] ?? 0,
        totalPrice: json["total_price"] ?? 0,
        createdAt: json["created_at"] ?? "",
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
        "create_at": createdAt,
    };
}
