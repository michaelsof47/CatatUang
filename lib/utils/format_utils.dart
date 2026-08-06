part of 'package:catat_uang/import_url_file.dart';

class FormatUtils {
  currencyFormat(int? value) => NumberFormat.currency(
        locale: 'id_ID',
        symbol: 'Rp. ',
        decimalDigits: 0,
      ).format(value);

  dateTimeFormat(String? date) =>
      DateFormat('dd MMM yyyy HH:mm', 'id_ID').format(DateTime.parse(date!));

  dateFormat(String? date) =>
      DateFormat('dd MMMM yyyy', 'id_ID').format(DateTime.parse(date!));

  dateAPIFormat(String? date) =>
      DateFormat('yyyy-MM-dd').format(DateTime.parse(date!));
}
