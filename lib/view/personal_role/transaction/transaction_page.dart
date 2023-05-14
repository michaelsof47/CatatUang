part of 'package:catat_uang/import_url_file.dart';

class TransactionPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<TransactionPage> createState() => TransactionPageState();
}

class TransactionPageState extends ConsumerState<TransactionPage> {
  List<String>? itemMenuLabel;
  List<String>? itemMenuLabelFilter;

  ///////////////////////
  ///CUSTOM DECORATION///
  ///////////////////////

  customBoxStyle1() => BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: ColorsTheme.white,
      );

  @override
  void initState() {
    super.initState();

    initConstructor();
    //initData();
  }

  initConstructor() {
    itemMenuLabel = ["Sembako", "PLN", "Pendidikan", "Tabungan KPR"];
    itemMenuLabelFilter = [
      "Semua",
      "Sembako",
      "PLN",
      "Pendidikan",
      "Tabungan KPR"
    ];
  }

  @override
  Widget build(BuildContext context) {
    //////////////////
    ///CUSTOM UTILS///
    //////////////////

    singleLineLabel({label, color, size}) => Text(
          label,
          style: GeneralStyle.labelStyle1(true, size, color),
        );

    /////////////////////
    ///FILTER SHORTCUT///
    /////////////////////

    categoryHeaderLabel() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            singleLineLabel(
              label: "Apa yang mau dicatat ?",
              size: 12,
              color: ColorsTheme.black,
            ),
            singleLineLabel(
              label: "Tambah Pintasan",
              size: 12,
              color: ColorsTheme.green,
            ),
          ],
        );

    categoryItemList() => SizedBox(
          height: 80.h,
          child: ListView.builder(
            itemCount: itemMenuLabel!.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: CustomMenuButton(
                menuLabel: itemMenuLabel![index],
                isRoundedShape: true,
                width: 80,
                height: 60,
              ),
            ),
          ),
        );

    contentCategoryComponent() => Column(
          children: [
            categoryHeaderLabel(),
            GeneralUtils.verticalSpacer(11),
            categoryItemList(),
          ],
        );

    categoryShortcutComponentCard() => Card(
          shape: GeneralUtils.customDecoration(),
          color: ColorsTheme.yellowSoft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 9.h),
            child: contentCategoryComponent(),
          ),
        );

    /////////////////////

    /////////////////////
    ///DROPDOWN FILTER///
    /////////////////////

    dropdownFilter() => DropdownButtonHideUnderline(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 8.w),
            child: CustomDropdownWidget(
              itemMenuLabelFilter: itemMenuLabelFilter,
              callback: (value) => print(value!),
            ),
            decoration: customBoxStyle1(),
          ),
        );

    contentCategoryFilter() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            singleLineLabel(
              label: "Filter Kategori",
              color: ColorsTheme.white,
              size: 14,
            ),
            dropdownFilter(),
          ],
        );

    categoryFilterCardComponent() => Card(
          shape: GeneralUtils.customDecoration(),
          color: ColorsTheme.green,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 9.w),
            child: contentCategoryFilter(),
          ),
        );

    /////////////////////

    //////////////////////
    ///TRANSACTION LIST///
    //////////////////////

    itemList() => ListView.builder(
          itemCount: 5,
          shrinkWrap: true,
          padding: EdgeInsets.only(bottom: 75.h),
          itemBuilder: (context, index) => CustomTransactionListWidget(
            totalData: 5,
            lastIndex: index + 1,
          ),
        );

    transactionListComponent() => Card(
        shape: GeneralUtils.customDecoration(),
        color: ColorsTheme.yellowSoft,
        child: Container(
          width: ScreenUtil().screenWidth,
          height: 270.h,
          padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 12.h),
          child: itemList(),
        ));

    //////////////////////

    appbar() => PreferredSize(
          preferredSize: Size.fromHeight(61.h),
          child: CustomAppBar(appLabel: "Transaksi"),
        );

    contentBody() => Column(
          children: [
            categoryShortcutComponentCard(),
            GeneralUtils.verticalSpacer(23),
            categoryFilterCardComponent(),
            GeneralUtils.verticalSpacer(22),
            transactionListComponent(),
          ],
        );

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(left: 17.w, right: 17.w, top: 29.h),
          child: contentBody(),
        ),
        appBar: appbar(),
      ),
    );
  }
}
