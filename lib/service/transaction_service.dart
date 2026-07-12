part of 'package:catat_uang/import_url_file.dart';

class TransactionService {
  Future<HttpModel> postCreateCategory(
      {required Map<String, dynamic> map, String? token}) async {
    var uri = Uri.parse("${GeneralUtils().baseUrl}/transactions/categories");
    var request = http.MultipartRequest("POST", uri);

    request.headers.addAll({"Authorization": "Bearer $token"});

    request.files.add(http.MultipartFile.fromBytes(
      'cat_url_image',
      map["image_url"].readAsBytesSync(),
      filename: "category_image.jpg",
      contentType: MediaType('image', 'jpeg'),
    ));

    request.fields['cat_name'] = map["name"];
    request.fields['cat_desc'] = map["description"];

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    return HttpModel(code: response.statusCode, body: response.body);
  }

  Future<HttpModel> postCreateTransaction(
      {required Map<String, dynamic> map,
      String? token,
      String? balanceId}) async {
    var uri = Uri.parse("${GeneralUtils().baseUrl}/transactions/");
    var request = http.MultipartRequest("POST", uri);

    request.headers.addAll({"Authorization": "Bearer $token"});

    request.fields['trans_name'] = map["trans_name"];
    request.fields['trans_date'] = map["trans_date"];
    request.fields['trans_amount'] = map["trans_amount"];
    request.fields['outlet_name'] = map["trans_outlet"];
    request.fields['trans_price'] = map["trans_price"];
    request.fields['trans_total_price'] = map["trans_price"];
    request.fields['category_id'] = map["trans_category"];
    request.fields['balances_id'] = balanceId!;
    print(map["trans_price"]);

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    return HttpModel(code: response.statusCode, body: response.body);
  }
}
