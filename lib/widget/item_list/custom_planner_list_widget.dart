part of 'package:catat_uang/import_url_file.dart';

class CustomPlannerListWidget extends StatelessWidget {

  late BooksItem book;
  
  CustomPlannerListWidget({required this.book});

  @override
  Widget build(BuildContext context) {
    itemBookList() => Card(
          shape: GeneralUtils().customDecoration(),
          color: ColorsTheme.yellowSoft,
          child: InkWell(
              onTap: () {},
              splashColor: ColorsTheme.grey,
              borderRadius: BorderRadius.circular(10.r),
              child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(book.name!,
                            style: FontTheme.labelStyle1(
                                status: "bold",
                                fontSize: 16,
                                color: ColorsTheme.black)),
                        GeneralUtils().verticalSpacer(5.h),
                        Row(children: [
                          Text("Tanggal Pembuatan : ",
                              style: FontTheme.labelStyle1(
                                  status: "bold",
                                  fontSize: 12,
                                  color: ColorsTheme.black)),
                          Text(FormatUtils().dateTimeFormat(book.targetStart!),
                              style: FontTheme.labelStyle1(
                                  status: "thin",
                                  fontSize: 12,
                                  color: ColorsTheme.black)),
                        ])
                      ]))));

    return Column(children: [
              itemBookList(),
              GeneralUtils().verticalSpacer(3.h)
            ]);
  }
}