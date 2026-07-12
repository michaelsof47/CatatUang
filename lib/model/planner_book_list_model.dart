part of 'package:catat_uang/import_url_file.dart';

class PlannerBookListModel {
  int? count;
  List<BooksItem>? booksItem;

  PlannerBookListModel({
    required this.count,
    required this.booksItem,
  });

  factory PlannerBookListModel.fromJson(Map<String, dynamic> json) =>
      PlannerBookListModel(
        count: json["count"] ?? 0,
        booksItem: json["books_item"] != null
            ? List<BooksItem>.from(
                json["books_item"].map((x) => BooksItem.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "books_item": List<dynamic>.from(booksItem!.map((x) => x.toJson())),
      };
}

class BooksItem {
  int? id;
  String? name;
  String? targetStart;
  String? targetEnd;
  int? targetAmount;
  int? userId;

  BooksItem({
    required this.id,
    required this.name,
    required this.targetStart,
    required this.targetEnd,
    required this.targetAmount,
    required this.userId,
  });

  factory BooksItem.fromJson(Map<String, dynamic> json) => BooksItem(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        targetStart: json["target_start"] ?? "",
        targetEnd: json["target_end"] ?? "",
        targetAmount: json["target_amount"] ?? 0,
        userId: json["user_id"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "target_start": targetStart,
        "target_end": targetEnd,
        "target_amount": targetAmount,
        "user_id": userId,
      };
}
