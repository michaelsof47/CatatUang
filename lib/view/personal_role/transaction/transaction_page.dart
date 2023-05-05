part of 'package:catat_uang/import_url_file.dart';

class TransactionPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<TransactionPage> createState() => TransactionPageState();
}

class TransactionPageState extends ConsumerState<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(child: Text("Ini Halaman 2")),
      ),
    );
  }
}
