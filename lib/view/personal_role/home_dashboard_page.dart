part of 'package:catat_uang/import_url_file.dart';

class HomeDashboardPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<HomeDashboardPage> createState() => HomeDashboardPageState();
}

class HomeDashboardPageState extends ConsumerState<HomeDashboardPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(child: Text("Ini Halaman 1")),
      ),
    );
  }
}
