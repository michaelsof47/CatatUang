part of 'package:catat_uang/import_url_file.dart';

class HomeDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocalManager>(() => LocalManager());
    Get.lazyPut<DashboardServiceInterface>(() => DashboardService());

    Get.lazyPut<DashboardController>(() => DashboardController(
          localManager: Get.find<LocalManager>(),
          dashboardService: Get.find<DashboardServiceInterface>(),
        ));
  }
}

class HomeDashboardPage extends StatefulWidget {
  @override
  State<HomeDashboardPage> createState() => HomeDashboardPageState();
}

class HomeDashboardPageState extends State<HomeDashboardPage> {
  //Global Datasets
  List<String>? itemMenuLabelList;
  List<String>? itemMenuActionList;

  //Global Variable
  DashboardController? controller;
  TransactionModel? transactionModel;
  TextEditingController? inputController;
  var locationLabel;
  var fullName;
  var balanceAmount;
  var transactionCount;
  var isLoading;
  var profileImage;

  //Global Props
  showAlertSnackbar(String? label, bool? isSuccessful) =>
      ScaffoldMessenger.of(context).showSnackBar(GeneralUtils().alertSnackbar(
          label: label,
          color: isSuccessful! ? ColorsTheme.green : ColorsTheme.redSoft));

  showTopupBottomSheet() => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: ColorsTheme.greenNature,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r))),
        builder: (buildContext) => CustomBottomSheetInputFieldWidget(
            inputController: inputController,
            callback: (String value) {
              Navigator.pop(context);
              isLoading.value = true;
              inputController!.text = "";

              String formattedData = value.replaceAll("Rp. ", "");
              String formattedData2 = formattedData.replaceAll(".", "");

              controller!.topupBalanceCtrl(formattedData2);
              initData();
            },
            headerLabel: "Tambah Saldo",
            hintLabel: "Jumlah Saldo",
            isNumber: true),
      );

  @override
  initState() {
    super.initState();

    initConstructor();
    initData();
  }

  @override
  dispose() {
    super.dispose();
    //Get.delete<DashboardController>();
  }

  initConstructor() {
    itemMenuLabelList = ["Atur Rencana", "Analisa Keuangan", "Top Up"];
    itemMenuActionList = ["/planner_form", "", "topup"];

    controller = Get.find<DashboardController>();
    locationLabel = "".obs;
    fullName = "".obs;
    balanceAmount = 0.obs;
    transactionCount = 0.obs;
    isLoading = true.obs;
    profileImage = Uint8List(0).obs;
    inputController = TextEditingController();
  }

  initData() async {
    await controller!.getDashboardDataCtrl(true);
    await controller!.getTransactionDataCtrl(page: 1, categoryId: 0);
    getLocationData();
  }

  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      showAlertSnackbar("Layanan lokasi tidak aktif", false);
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showAlertSnackbar("Izin lokasi ditolak", false);
        return null;
      }
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  getLocationData() async {
    Position? position = await getCurrentLocation();
    if (position != null) {
      print("Latitude: ${position.latitude}, Longitude: ${position.longitude}");
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
        localeIdentifier: "id_ID",
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        locationLabel.value =
            "${place.subAdministrativeArea}, ${place.administrativeArea}";
      }
    } else {
      showAlertSnackbar("Gagal mendapatkan lokasi", false);
    }
  }

  String? getGreeting() {
    var now = DateTime.now();

    if (now.hour >= 5 && now.hour < 11) {
      return "Selamat Pagi";
    } else if (now.hour >= 11 && now.hour < 15) {
      return "Selamat Siang";
    } else if (now.hour >= 15 && now.hour < 18) {
      return "Selamat Sore";
    } else {
      return "Selamat Malam";
    }
  }

  Future<void> onLoadData() async {
    isLoading.value = true;
    await controller!.getDashboardDataCtrl(true);
    await controller!.getTransactionDataCtrl();
  }

  Widget? handlingError() {
    var alertStatus = "".obs;
    alertStatus.value = controller!.resultStatus.value;
    var alertMessage = controller!.resultMsg.value;
    var dataMap = controller!.dashboardData!;
    var transactionMap = controller!.transactionData!;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      switch (alertStatus.value) {
        case "jwt_expired":
          showAlertSnackbar(alertMessage, false);
          controller!.resetAccountCtrl();
          Navigator.pushReplacementNamed(context, "/onboarding");
          break;
        case "dashboard_failure":
          showAlertSnackbar(alertMessage, false);
          break;
        case "dashboard_success":
          AccountModel accountModel = AccountModel.fromJson(dataMap);
          profileImage.value = controller!.profileImage!.value;
          fullName.value = "${accountModel.firstName} ${accountModel.lastName}";
          print("Balance Amount: ${controller!.balanceAmount.value}");
          balanceAmount.value = controller!.balanceAmount.value;
          break;
        case "transaction_success":
          isLoading.value = false;
          transactionModel = TransactionModel.fromJson(transactionMap);
          transactionCount.value = transactionModel!.pagination!.totalItems!;
          break;
        case "transaction_failure":
          isLoading.value = false;
          transactionCount.value = 0;
          break;
        case "topup_success":
          showAlertSnackbar(alertMessage, true);
          break;
      }

      controller!.resetResponse();
    });

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    ///CUSTOM SHORCUT MENU + SUMMARY BALANCES///

    balancesInformation() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total Saldo Hari Ini",
              style: FontTheme.labelStyle1(
                  status: "bold", fontSize: 13, color: ColorsTheme.black),
            ),
            GeneralUtils().verticalSpacer(6),
            Text(
              FormatUtils().currencyFormat(balanceAmount.value),
              style: FontTheme.labelStyle1(
                  status: "bold", fontSize: 24, color: ColorsTheme.black),
            ),
          ],
        );

    userTransactionLabel() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Rangkuman Transaksi Terbaru",
              style: FontTheme.labelStyle1(
                  status: "bold", fontSize: 10, color: ColorsTheme.black),
            ),
            Text(
              "${transactionCount.value} Transaksi/Bulan",
              style: FontTheme.labelStyle1(
                  status: "bold", fontSize: 10, color: ColorsTheme.black),
            ),
          ],
        );

    userInformation() => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [balancesInformation()],
            ),
            GeneralUtils().verticalSpacer(11),
            userTransactionLabel(),
          ],
        );

    ///CUSTOM LATEST TRANSACTION///

    headerLabel() => Text("Transaksi Terbaru Saat Ini",
        style: FontTheme.labelStyle1(
            status: "bold", fontSize: 14, color: ColorsTheme.white));

    iconTransaction() => Container(
          width: 70.w,
          height: 48.h,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/image/ic_dummy_outlet.png'),
              fit: BoxFit.fill,
            ),
            border: Border.all(color: ColorsTheme.white, width: 3.w),
            borderRadius: BorderRadius.circular(10.r),
          ),
        );

    itemRowLabel(label1, label2) => Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 110.w,
              child: Text(
                label1,
                style: FontTheme.labelStyle1(
                    status: "bold", fontSize: 11, color: ColorsTheme.white),
              ),
            ),
            GeneralUtils().horizontalSpacer(4),
            Text(
              ":",
              style: FontTheme.labelStyle1(
                  status: "thin", fontSize: 11, color: ColorsTheme.white),
            ),
            GeneralUtils().horizontalSpacer(2),
            SizedBox(
              width: 115.w,
              child: Text(
                label2,
                style: FontTheme.labelStyle1(
                    status: "thin", fontSize: 11, color: ColorsTheme.white),
              ),
            ),
          ],
        );

    contentDescriptionInformation() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            itemRowLabel(
              "Tgl Transaksi",
              FormatUtils()
                  .dateTimeFormat(transactionModel!.data![0].createdAt),
            ),
            GeneralUtils().verticalSpacer(1),
            itemRowLabel(
              "Nama Outlet",
              transactionModel!.data![0].outletName,
            ),
            GeneralUtils().verticalSpacer(1),
            itemRowLabel(
                "Total Outcome",
                FormatUtils()
                    .currencyFormat(transactionModel!.data![0].totalPrice)),
          ],
        );

    transactionInformationRow() => Row(
          children: [
            iconTransaction(),
            GeneralUtils().horizontalSpacer(8),
            contentDescriptionInformation(),
          ],
        );

    contentLastestTransaction() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerLabel(),
            GeneralUtils().customCardLiner(
              color: ColorsTheme.white,
              horizontalPad: 0.w,
              verticalPad: 3.h,
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: transactionCount.value > 0 ? 3.h : 10.h),
                child: transactionCount.value > 0
                    ? transactionInformationRow()
                    : Center(
                        child: Text(
                        "Tidak ada transaksi yang ditemukan",
                        style: FontTheme.labelStyle1(
                            status: "bold",
                            fontSize: 12,
                            color: ColorsTheme.white),
                      )))
          ],
        );

    lastestTransactionCardComponent() => Card(
          shape: GeneralUtils().customDecoration(),
          color: ColorsTheme.green,
          child: Container(
            width: ScreenUtil().screenWidth,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            child: contentLastestTransaction(),
          ),
        );

    ///CUSTOM TIPS TRANSACTION///

    headerLabel1() => Text("Financial Tips",
        style: FontTheme.labelStyle1(
            status: "bold", fontSize: 14, color: ColorsTheme.black));

    iconFinancial() => Container(
          width: 70.w,
          height: 48.h,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/image/ic_dummy_outlet.png'),
              fit: BoxFit.fill,
            ),
            border: Border.all(color: ColorsTheme.white, width: 3.w),
            borderRadius: BorderRadius.circular(10.r),
          ),
        );

    contentHeaderInformation() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 180.w,
              child: Text(
                "Tips untuk mengelola keuangan secara efektif ? ",
                style: FontTheme.labelStyle1(
                    status: "bold", fontSize: 12, color: ColorsTheme.black),
              ),
            )
          ],
        );

    tipsInformationRow() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            contentHeaderInformation(),
            iconFinancial(),
          ],
        );

    contentLastestFinancialTips() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerLabel1(),
            GeneralUtils().customCardLiner(
              color: ColorsTheme.green,
              horizontalPad: 0.w,
              verticalPad: 3.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 3.h),
              child: tipsInformationRow(),
            )
          ],
        );

    lastestFinancialTipsCardComponent() => Card(
          shape: GeneralUtils().customDecoration(),
          color: ColorsTheme.yellowSoft,
          child: Container(
            width: ScreenUtil().screenWidth,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            child: contentLastestFinancialTips(),
          ),
        );

    ////////////////////////////////

    bodyContent() =>
        CustomScrollView(physics: AlwaysScrollableScrollPhysics(), slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                isLoading.value
                    ? CustomShimmerCardWidget(height: 100.h)
                    : CustomShortcutMenuWidget(
                        userInformation: userInformation(),
                        itemMenuLabelList: itemMenuLabelList,
                        itemMenuActionList: itemMenuActionList,
                        itemMenuHeight: 100,
                        callback: (index) => itemMenuActionList![index] != "" &&
                                itemMenuActionList![index] != "topup"
                            ? Navigator.pushNamed(
                                context,
                                itemMenuActionList![index],
                              )
                            : itemMenuActionList![index] == "topup"
                                ? showTopupBottomSheet()
                                : showAlertSnackbar("Coming Soon", true),
                      ),
                GeneralUtils().verticalSpacer(10),
                isLoading.value
                    ? CustomShimmerCardWidget(height: 50.h)
                    : lastestTransactionCardComponent(),
                GeneralUtils().verticalSpacer(15),
                //lastestFinancialTipsCardComponent(),
              ],
            ),
          )
        ]);

    headerAndBodyWidget() => Column(
          children: [
            isLoading.value
                ? CustomShimmerProfileWidget()
                : CustomHeaderWidget(
                    fullName: fullName.value,
                    profileImageUrl: profileImage.value,
                    location: locationLabel.value,
                    greeting: getGreeting()!),
            GeneralUtils().verticalSpacer(15),
            Expanded(
              child:
                  RefreshIndicator(onRefresh: onLoadData, child: bodyContent()),
            )
          ],
        );

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorsTheme.transparent,
        body: Padding(
          padding: EdgeInsets.all(10.w),
          child: Obx(
              () => Stack(children: [headerAndBodyWidget(), handlingError()!])),
        ),
      ),
    );
  }
}
