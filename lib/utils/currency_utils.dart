part of 'package:catat_uang/import_url_file.dart';

class CustomCurrencyFormat extends TextInputFormatter {

  CustomCurrencyFormat(){}

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if(newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if(newText.isEmpty) {
      return newValue.copyWith(text: '');
    }

    int value = int.tryParse(newText) ?? 0;

    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp. ',
      decimalDigits: 0,
    );

    String formattedText = formatCurrency.format(value);

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(
        offset: formattedText.length,
      )
    );
  }
  
}