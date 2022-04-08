import 'dart:io';
import 'package:asmaaadmin/Api/api.dart';
import 'package:asmaaadmin/Modules/products_model.dart';
import 'package:asmaaadmin/Pdf/PdfOperations.dart';
import 'package:asmaaadmin/core/size_config.dart';
import 'package:asmaaadmin/view/dasboard_screen/widgets/add_screen.dart';
import 'package:asmaaadmin/view/dasboard_screen/widgets/invoice_header.dart';
import 'package:asmaaadmin/view/dasboard_screen/widgets/itemList.dart';
import 'package:asmaaadmin/view/widgets/custom_button.dart';
import 'package:asmaaadmin/view/widgets/custom_text.dart';
import 'package:asmaaadmin/view/widgets/custom_text_form_field.dart';
import 'package:asmaaadmin/view/widgets/primary_color.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<int> qty = [], qty2 = [];

  List ids = [];

  List<double> price = [], price2 = [];

  List<Products> product = [], product2 = [];

  TextEditingController controllerName = TextEditingController();

  TextEditingController controllerPhone = TextEditingController();

  TextEditingController controllerNameGuarantor = TextEditingController();

  TextEditingController controllerPhoneGuarantor = TextEditingController();

  TextEditingController controllerAmountPaid = TextEditingController();

  TextEditingController controllerDiscount = TextEditingController();

  String invoiceType = 'كاش';
  String invoices = 'بيع';
  double total = 0;
  int productCount = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Row(children: [
              CustomText(
                text: 'اسماء',
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 23,
              ),
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.asset('assets/logo.jpg'),
              )
            ]),
          ),
          body: Column(
            children: [
              AddScreen(
                getType: getInvoiceType,
                getInvoice: getInvoice,
                invoiceType: invoiceType,
                ids: ids,
                getData: getProducts,
                products: product2,
                qty: qty2,
                price: price2,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: controllerName,
                        decoration: const InputDecoration(
                            labelText: 'إسم العميل',
                            border: OutlineInputBorder()),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: controllerPhone,
                        decoration: const InputDecoration(
                            labelText: 'رقم هاتف العميل',
                            border: OutlineInputBorder()),
                      ),
                    ),
                  )
                ],
              ),
              Visibility(
                visible: invoiceType=='قسط',
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: controllerNameGuarantor,
                          decoration: const InputDecoration(
                              labelText: 'إسم الضامن',
                              border: OutlineInputBorder()),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: controllerPhoneGuarantor,
                          decoration: const InputDecoration(
                              labelText: 'رقم هاتف الضامن',
                              border: OutlineInputBorder()),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              InvoiceHeader(
                invoiceType: invoiceType,
              ),
              ItemList(
                ids: ids,
                products: product2,
                qtys: qty2,
                prices: price2,
                updateTotal: updateTotal,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomButton(
                                text: CustomText(
                                  text: invoices=='بيع'? 'دفع' : 'إرجاع المنتجات',
                                  fontSize: 17,
                                ),
                                icon: Icon(invoices=='بيع'?Icons.payment: Icons.recycling),
                                onPress: () => invoices=='بيع'?onTapToSells() : onTapToReturn(),
                              ),
                            ),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: controllerDiscount,
                                decoration: const InputDecoration(
                                    labelText: 'الخصم',
                                    border: OutlineInputBorder()),
                              ),
                            )),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: controllerAmountPaid,
                          decoration: const InputDecoration(
                              labelText: 'المبلغ المدفوع',
                              border: OutlineInputBorder()),
                        ),
                      ),
                      Expanded(
                        child: CustomText(
                          text: 'المجموع : $total',
                          fontSize: 25,
                        ),
                      ),
                      Expanded(
                        child: CustomText(
                          text: 'مجموع الاصناف : $productCount',
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  List<Products> getProducts(List<Products> products, List<int> qtys, List<double> prices) {
    setState(() {
      product = products;
      product2 = product;

      qty = qtys;
      qty2 = qty;
      price = prices;
      price2 = price;
      getTotal();
    });

    return products;
  }

  getInvoiceType(String type) {
    setState(() {
      invoiceType = type;
    });
  }
  getInvoice(String invoice) {
    setState(() {
      invoices = invoice;
    });
  }

  getTotal() {
    total = 0.0;
    for (int x = 0; x < price2.length; x++) {
      setState(() {
        total += (price2[x] * qty2[x]);
        productCount = product.length;
      });
    }
  }

  updateTotal() {
    total = 0.0;
    productCount = 0;
    if (product2.length == 0) {
      setState(() {
        total = 0.0;
        productCount = 0;
      });
    } else {
      for (int x = 0; x < price2.length; x++) {
        setState(() {
          total += (price2[x] * qty2[x]);
          productCount = product2.length;
        });
      }
    }
  }

  onTapToSells() {
    if (invoiceType == 'كاش' || invoiceType == 'جملة') {
      setState(() {
        if(controllerDiscount.text.isNotEmpty){
          controllerAmountPaid.text = '${(total * (double.parse(controllerDiscount.text)))}';
        }else{
          controllerAmountPaid.text = '$total';
        }
      });
      if (controllerName.text.isNotEmpty &&
          product2.isNotEmpty &&
          controllerPhone.text.isEmpty &&
          controllerAmountPaid.text.isNotEmpty) {
        ServData.SendOrder(
            name: controllerName.text,
            phone: '',
            invoiceType: invoiceType,
            amountPaid: controllerAmountPaid.text,
            productNum: productCount,
            total: total,
            products: ids,
            qty: qty,
            prices: price2,
            discount: controllerDiscount.text)
            .then((value) {
          print(value);
          if (value == 'Send Order Success') {
            _createPDF().whenComplete(() {
              _showSuccessDialog(context);
            });
          } else {
            _showErrorDialog('حدث خطأ لم يتم إتمام الدفع الرجاء مراجعة الدعم',
                'فاتورة $invoiceType', context);
          }
        });
      } else if (controllerName.text.isNotEmpty &&
          product2.isNotEmpty &&
          controllerPhone.text.isNotEmpty &&
          controllerAmountPaid.text.isNotEmpty) {
        setState(() {
          if(controllerDiscount.text.isNotEmpty){
            total = total * double.parse(controllerDiscount.text);
          }
        });
        ServData.SendOrder(
            name: controllerName.text,
            phone: controllerPhone.text,
            invoiceType: invoiceType,
            amountPaid: controllerAmountPaid.text,
            productNum: productCount,
            total: total,
            products: ids,
            qty: qty,
            prices: price2,
            discount: controllerDiscount.text)
            .then((value) {
              print(value);
          if (value == 'Send Order Success') {
            _createPDF().whenComplete(() {
              _showSuccessDialog(context);
            });
          } else {
            _showErrorDialog('حدث خطأ لم يتم إتمام الدفع الرجاء مراجعة الدعم',
                'فاتورة $invoiceType', context);
          }
        });
      } else if (controllerName.text.isEmpty) {
        _showErrorDialog(
            'لا يمكن إتمام الدفع بدون إدخال إسم العميل', 'نظام الكاش', context);
      } else if (controllerAmountPaid.text.isEmpty) {
        _showErrorDialog('لا يمكن إتمام الدفع بدون إدخال المبلغ المدفوع',
            'نظام الكاش', context);
      } else if (product2.isEmpty) {
        _showErrorDialog('لا يمكن إتمام الدفع بدون إضافة منتجات للفاتورة',
            'نظام الكاش', context);
      }
    } else {
      if (controllerName.text.isNotEmpty &&
          product2.isNotEmpty &&
          controllerPhone.text.isNotEmpty &&
          controllerAmountPaid.text.isNotEmpty) {
        ServData.SendOrder(
            name: controllerName.text,
            phone: controllerPhone.text,
            invoiceType: invoiceType,
            amountPaid: controllerAmountPaid.text,
            productNum: productCount,
            total: total,
            products: ids,
            qty: qty,
            prices: price2,
            discount: controllerDiscount.text)
            .then((value) {
          if (value == 'Send Order Success') {
            _createPDF().whenComplete(() {
              _showSuccessDialog(context);
            });
          } else {
            _showErrorDialog('حدث خطأ لم يتم إتمام الدفع الرجاء مراجعة الدعم',
                'فاتورة $invoiceType', context);
          }
        });
      } else if (controllerName.text.isEmpty) {
        _showErrorDialog(
            'لا يمكن إتمام الدفع بدون إدخال إسم العميل', 'نظام القسط', context);
      } else if (controllerPhone.text.isEmpty) {
        _showErrorDialog('لا يمكن إتمام الدفع بدون إدخال رقم هاتف العميل',
            'نظام القسط', context);
      } else if (product2.isEmpty) {
        _showErrorDialog('لا يمكن إتمام الدفع بدون إضافة منتجات للفاتورة',
            'نظام القسط', context);
      } else if (controllerAmountPaid.text.isEmpty) {
        _showErrorDialog('لا يمكن إتمام الدفع بدون إدخال المبلغ المدفوع',
            'نظام الكاش', context);
      }
    }
  }

  onTapToReturn() {
    if (invoiceType == 'كاش' || invoiceType == 'جملة') {
      setState(() {
        if(controllerDiscount.text.isNotEmpty){
          controllerAmountPaid.text = '${(total * (double.parse(controllerDiscount.text)))}';
        }else{
          controllerAmountPaid.text = '$total';
        }
      });
      if (controllerName.text.isNotEmpty &&
          product2.isNotEmpty &&
          controllerPhone.text.isEmpty &&
          controllerAmountPaid.text.isNotEmpty) {
        ServData.ReturnOrder(
            name: controllerName.text,
            phone: '',
            invoiceType: invoiceType,
            amountPaid: controllerAmountPaid.text,
            productNum: productCount,
            total: total,
            products: ids,
            qty: qty,
            prices: price2,
            discount: controllerDiscount.text)
            .then((value) {
          if (value == 'Return Order Success') {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const DashboardScreen()));
          } else {
            _showErrorDialog('حدث خطأ لم يتم إتمام الدفع الرجاء مراجعة الدعم',
                'فاتورة $invoiceType', context);
          }
        });
      } else if (controllerName.text.isNotEmpty &&
          product2.isNotEmpty &&
          controllerPhone.text.isNotEmpty &&
          controllerAmountPaid.text.isNotEmpty) {
        setState(() {
          if(controllerDiscount.text.isNotEmpty){
            total = total * double.parse(controllerDiscount.text);
          }
        });
        ServData.ReturnOrder(
            name: controllerName.text,
            phone: controllerPhone.text,
            invoiceType: invoiceType,
            amountPaid: controllerAmountPaid.text,
            productNum: productCount,
            total: total,
            products: ids,
            qty: qty,
            prices: price2,
            discount: controllerDiscount.text)
            .then((value) {
          if (value == 'Return Order Success') {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                builder: (context) => const DashboardScreen()));
          } else {
            _showErrorDialog('حدث خطأ لم يتم إتمام الدفع الرجاء مراجعة الدعم',
                'فاتورة $invoiceType', context);
          }
        });
      } else if (controllerName.text.isEmpty) {
        _showErrorDialog(
            'لا يمكن إتمام الدفع بدون إدخال إسم العميل', 'نظام الكاش', context);
      } else if (controllerAmountPaid.text.isEmpty) {
        _showErrorDialog('لا يمكن إتمام الدفع بدون إدخال المبلغ المدفوع',
            'نظام الكاش', context);
      } else if (product2.isEmpty) {
        _showErrorDialog('لا يمكن إتمام الدفع بدون إضافة منتجات للفاتورة',
            'نظام الكاش', context);
      }
    } else {
      if (controllerName.text.isNotEmpty &&
          product2.isNotEmpty &&
          controllerPhone.text.isNotEmpty &&
          controllerAmountPaid.text.isNotEmpty) {
        ServData.ReturnOrder(
            name: controllerName.text,
            phone: controllerPhone.text,
            invoiceType: invoiceType,
            amountPaid: controllerAmountPaid.text,
            productNum: productCount,
            total: total,
            products: ids,
            qty: qty,
            prices: price2,
            discount: controllerDiscount.text)
            .then((value) {
          if (value == 'Return Order Success') {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                builder: (context) => const DashboardScreen()));
          } else {
            _showErrorDialog('حدث خطأ لم يتم إتمام الدفع الرجاء مراجعة الدعم',
                'فاتورة $invoiceType', context);
          }
        });
      } else if (controllerName.text.isEmpty) {
        _showErrorDialog(
            'لا يمكن إتمام الدفع بدون إدخال إسم العميل', 'نظام القسط', context);
      } else if (controllerPhone.text.isEmpty) {
        _showErrorDialog('لا يمكن إتمام الدفع بدون إدخال رقم هاتف العميل',
            'نظام القسط', context);
      } else if (product2.isEmpty) {
        _showErrorDialog('لا يمكن إتمام الدفع بدون إضافة منتجات للفاتورة',
            'نظام القسط', context);
      } else if (controllerAmountPaid.text.isEmpty) {
        _showErrorDialog('لا يمكن إتمام الدفع بدون إدخال المبلغ المدفوع',
            'نظام الكاش', context);
      }
    }
  }

  void clearAllViews() {
    setState(() {
      product = [];
      product2 = [];

      qty = [];
      qty2 = [];
      price = [];
      price2 = [];

      total = 0.0;
      productCount = 0;
      controllerName.clear();
      controllerPhone.clear();
      controllerAmountPaid.clear();
      controllerDiscount.clear();
    });
  }

// //to Create pdf and save to phone
  Future<void> _createPDF() async {
    var name = controllerName.text;

    // var arabicFont = Font.ttf(await rootBundle.load("assets/fonts/arabic.ttf"));
    //Create a PDF document.

    final PdfDocument document = PdfDocument();
    //Add page to the PDF
    final PdfPage page = document.pages.add();
    //Get page client size
    final Size pageSize = page.getClientSize();
    //Draw rectangle
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
        pen: PdfPen(PdfColor(142, 170, 219, 255)));
    //Generate PDF grid.

    final PdfGrid grid = getGrid();
    //Draw the header section by creating text element
    drawHeader(page, pageSize, grid).then((value) {
      PdfLayoutResult result = value!;
      //Draw grid
      drawGrid(page, grid, result);
      //Add invoice footer
      //drawFooter(page, pageSize);
    }).whenComplete(() {
      //Save and launch the document
      final List<int> bytes = document.save();

      //Dispose the document.
      document.dispose();
      //Save and launch file.
      savedAndLaunchFile(bytes, '$name.pdf');
    });
  }

  //to draw Header on pdf
  Future<PdfLayoutResult?> drawHeader(
      PdfPage page, Size pageSize, PdfGrid grid) async {
    var name = controllerName.text;
    var phone = controllerPhone.text;
    var nameG = controllerNameGuarantor.text ;
    var phoneG = controllerPhoneGuarantor.text;
    var amountPaid = controllerAmountPaid.text;
    var discount = controllerDiscount.text;
    //Draw rectangle
    List<int> dataFont = File('assets/fonts/Arial.ttf').readAsBytesSync();

    final PdfFont contentFont2 =
        PdfTrueTypeFont(File('assets/fonts/Arial.ttf').readAsBytesSync(), 18);
    final PdfFont contentFont =
        PdfTrueTypeFont(File('assets/fonts/Arial.ttf').readAsBytesSync(), 12);

    //Draw string

    page.graphics.drawString('أسماء', contentFont2,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(
          400,
          50,
          pageSize.width - 400,
          33,
        ),
        format: PdfStringFormat(
            textDirection: PdfTextDirection.rightToLeft,
            alignment: PdfTextAlignment.right,
            paragraphIndent: 35));

    //Create data format and convert it to text.
    final String invoiceNumber = 'Customer Information';
    final Size contentSize = contentFont.measureString(invoiceNumber);
    String address = '\n\n الإسم : $name \n\n رقم الهاتف : $phone \n\n  إسم الضامن : $nameG \n\n رقم هاتف الضامن : $phoneG \n\n الخصم : $discount \n\n المبلغ المدفوع : $amountPaid \n\n الإجمالي : $total ';

    PdfTextElement(
            text: invoiceType,
            font: PdfTrueTypeFont(
                File('assets/fonts/Arial.ttf').readAsBytesSync(), 14),
            brush: PdfBrushes.white,
            format: PdfStringFormat(
                textDirection: PdfTextDirection.rightToLeft,
                alignment: PdfTextAlignment.right,
                paragraphIndent: 35))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
              390,
              40,
              pageSize.width - 400,
              33,
            ));

    PdfTextElement(
            text: '\nبيانات الفاتورة\n',
            font: PdfTrueTypeFont(
                File('assets/fonts/Arial.ttf').readAsBytesSync(), 15,
                style: PdfFontStyle.bold),
            brush: PdfBrushes.darkBlue,
            format: PdfStringFormat(
                textDirection: PdfTextDirection.rightToLeft,
                alignment: PdfTextAlignment.right,
                paragraphIndent: 35))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                170,
                90,
                pageSize.width - (contentSize.width + 30),
                pageSize.height - 120));

    return PdfTextElement(
            text: address,
            font: PdfTrueTypeFont(
                File('assets/fonts/Arial.ttf').readAsBytesSync(), 10),
            format: PdfStringFormat(
                textDirection: PdfTextDirection.rightToLeft,
                alignment: PdfTextAlignment.right,
                paragraphIndent: 15))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                150,
                120,
                pageSize.width - (contentSize.width + 30),
                pageSize.height - 120));
  }

  //Create PDF Table and return
  PdfGrid getGrid() {
    //Create a PDF grid
    final PdfGrid grid = PdfGrid();
    //Secify the columns count to the grid.

    grid.columns.add(count: 4);
    //Create the header row of the grid.
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    //Set style

    headerRow.style.font =
        PdfTrueTypeFont(File('assets/fonts/Arial.ttf').readAsBytesSync(), 10);
    headerRow.style.textBrush = PdfBrushes.black;
    headerRow.cells[0].value = 'الإجمالي';
    headerRow.cells[0].stringFormat = PdfStringFormat(
        textDirection: PdfTextDirection.rightToLeft,
        alignment: PdfTextAlignment.right,
        paragraphIndent: 35);
    headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.right;
    headerRow.cells[1].value = 'الكمية';
    headerRow.cells[1].stringFormat = PdfStringFormat(
        textDirection: PdfTextDirection.rightToLeft,
        alignment: PdfTextAlignment.right,
        paragraphIndent: 35);
    headerRow.cells[2].value = 'سعر السلعة';
    headerRow.cells[2].stringFormat = PdfStringFormat(
        textDirection: PdfTextDirection.rightToLeft,
        alignment: PdfTextAlignment.right,
        paragraphIndent: 35);
    headerRow.cells[3].value = 'إسم السلعة';
    headerRow.cells[3].stringFormat = PdfStringFormat(
        textDirection: PdfTextDirection.rightToLeft,
        alignment: PdfTextAlignment.right,
        paragraphIndent: 35);
    for (int x = 0; x < product2.length; x++) {
      var item = product2;
      addProducts(item[x].name, '\EGP ' + '${price2[x]}', '       ${qty2[x]}',
          '\EGP ' + '${price2[x] * qty[x]}', grid);
    }
    //Apply the grid built-in style.
    grid.applyBuiltInStyle(PdfGridBuiltInStyle.gridTable1LightAccent1);
    grid.columns[0].width = 200;
    for (int i = 0; i < headerRow.cells.count; i++) {
      headerRow.cells[i].style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    }
    for (int i = 0; i < grid.rows.count; i++) {
      final PdfGridRow row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        final PdfGridCell cell = row.cells[j];
        if (j == 0) {
          cell.stringFormat = PdfStringFormat(
              textDirection: PdfTextDirection.rightToLeft,
              alignment: PdfTextAlignment.right,
              paragraphIndent: 35);
          cell.stringFormat.alignment = PdfTextAlignment.center;
        }
        cell.style.cellPadding =
            PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
      }
    }
    return grid;
  }

  void drawGrid(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
    Rect totalPriceCellBounds;
    Rect quantityCellBounds;
    //Invoke the beginCellLayout event.
    grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
      final PdfGrid grid = sender as PdfGrid;
      if (args.cellIndex == grid.columns.count - 1) {
        totalPriceCellBounds = args.bounds;
      } else if (args.cellIndex == grid.columns.count - 2) {
        quantityCellBounds = args.bounds;
      }
    };
    //Draw the PDF grid and get the result.
    result = grid.draw(
        page: page, bounds: Rect.fromLTWH(0, result.bounds.bottom + 40, 0, 0))!;
  }

//Create row for the Table.
  void addProducts(String productName, String price, String quantity,
      String total, PdfGrid grid) {
    PdfGridRow row = grid.rows.add();
    row.style.font =
        PdfTrueTypeFont(File('assets/fonts/Arial.ttf').readAsBytesSync(), 10);
    row.cells[3].value = productName;
    row.cells[3].stringFormat = PdfStringFormat(
        textDirection: PdfTextDirection.rightToLeft,
        alignment: PdfTextAlignment.right,
        paragraphIndent: 35);
    row.cells[2].value = price;
    row.cells[2].stringFormat = PdfStringFormat(
        textDirection: PdfTextDirection.rightToLeft,
        alignment: PdfTextAlignment.right,
        paragraphIndent: 35);
    row.cells[1].value = quantity;
    row.cells[1].stringFormat = PdfStringFormat(
        textDirection: PdfTextDirection.rightToLeft,
        alignment: PdfTextAlignment.right,
        paragraphIndent: 35);
    row.cells[0].value = total;
    row.cells[0].stringFormat = PdfStringFormat(
        textDirection: PdfTextDirection.rightToLeft,
        alignment: PdfTextAlignment.right,
        paragraphIndent: 35);
  }

  //create footer on pdf
// void drawFooter(PdfPage page, Size pageSize) async{
//   final PdfPen linePen = PdfPen(PdfColor(142, 170, 219, 255), dashStyle: PdfDashStyle.custom);
//   linePen.dashPattern = <double>[3, 3];
//   //Draw line

//   page.graphics.drawLine(linePen, Offset(0, pageSize.height - 100),
//       Offset(pageSize.width, pageSize.height - 100));

//   const String footerContent = '';
//   List<int>dataFont = File('assets/fonts/Arial.ttf').readAsBytesSync();
//   PdfFont font = PdfTrueTypeFont(File('assets/fonts/Arial.ttf').readAsBytesSync(), 12);
//   //Added 30 as a margin for the layout.

//   page.graphics.drawString(footerContent,
//       font,
//       brush: PdfBrushes.darkBlue,
//       format: PdfStringFormat(alignment: PdfTextAlignment.center),
//       bounds:
//       Rect.fromLTWH(pageSize.width - 270, pageSize.height - 60, 0, 0));
// }

// Future<List<int>> _readFontData() async {
//   final ByteData bytes = await rootBundle.load('assets/fonts/Arial.ttf');
//   return bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
// }

  void _showSuccessDialog(BuildContext context) {
    AwesomeDialog(
            context: context,
            animType: AnimType.LEFTSLIDE,
            headerAnimationLoop: false,
            dismissOnTouchOutside: false,
            dismissOnBackKeyPress: false,
            dialogType: DialogType.SUCCES,
            showCloseIcon: false,
            title: 'نظام الفاتورة',
            desc: 'تم دفع الفاتورة بنجاح',
            btnOkOnPress: () => clearAllViews(),
            btnOkIcon: Icons.check_circle,
            onDissmissCallback: (type) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const DashboardScreen()),
              );
            })
        .show();
  }

  void _showErrorDialog(String message, String title, BuildContext context) {
    AwesomeDialog(
            context: context,
            width: SizeConfig.screenWidth! * 0.4,
            dialogType: DialogType.ERROR,
            animType: AnimType.RIGHSLIDE,
            headerAnimationLoop: true,
            title: title,
            desc: message,
            btnOkText: 'إغلاق',
            btnOkOnPress: () {},
            btnOkIcon: Icons.cancel,
            btnOkColor: Colors.red)
        .show();
  }
}
