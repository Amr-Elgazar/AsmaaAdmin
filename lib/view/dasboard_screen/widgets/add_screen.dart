import 'package:asmaaadmin/Api/api.dart';
import 'package:asmaaadmin/Modules/products_model.dart';
import 'package:asmaaadmin/core/size_config.dart';
import 'package:asmaaadmin/view/dasboard_screen/widgets/itemDetails.dart';
import 'package:asmaaadmin/view/dasboard_screen/widgets/item_header.dart';
import 'package:asmaaadmin/view/installment_payment/installment_payment.dart';
import 'package:asmaaadmin/view/widgets/custom_button.dart';
import 'package:asmaaadmin/view/widgets/custom_text.dart';
import 'package:asmaaadmin/view/widgets/custom_text_form_field.dart';
import 'package:asmaaadmin/view/widgets/primary_color.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  final Function(List<Products> products, List<int> qtys, List<double> prices)getData;
 final Function(String type)getType;
  String invoiceType ;
  List<Products> products;
  List<int> qty;

  List ids;

  List<double> price;

  AddScreen(
      {Key? key,
      required this.getData,
      required this.products,
      required this.qty,
      required this.invoiceType,
      required this.ids,
      required this.price,
      required this.getType})
      : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  List<Products> product = [], product2 = [];

  String invoiceType = 'كاش';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ServData.getProducts().then((value) {
        setState(() {
          product = value;
          product2 = value;
        });

    }).catchError((e) {
      print(e);
    });
  }

  Future<void> _showMyDialogAdd() async {
    TextEditingController searchController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        SizeConfig().init(context);
        return StatefulBuilder(
          builder: (BuildContext context2, void Function(void Function()) setState2) {

            void filterSearch(String query) {
              List<Products> dummyData = product2;
              if (query.isNotEmpty) {
                List<Products> resultSearchProduct = [];
                for (int x = 0; x < dummyData.length; x++) {
                  if (dummyData[x]
                      .productCode
                      .replaceAll('"', '')
                      .toLowerCase()
                      .contains(query.toLowerCase())) {
                    resultSearchProduct.add(dummyData[x]);
                  }
                }
                setState2(() {
                  product = resultSearchProduct;
                });
                return;
              } else {
                setState2(() {
                  product = [];
                  product = product2;
                });
              }
            }

            return Directionality(
              textDirection: TextDirection.rtl,
              child: AlertDialog(
                title: const Text('إضافة صنف إلي الفاتورة'),
                content: SizedBox(
                  width: SizeConfig.screenWidth!,
                  height: SizeConfig.screenHeight! * 0.4,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: searchController,
                        onChanged: (value) {
                          filterSearch(value);
                        },
                        onFieldSubmitted: (v) {
                          filterSearch(v);
                        },
                        decoration: const InputDecoration(
                            labelText: 'إضافه رقم السلعه',
                            border: OutlineInputBorder()),
                      ),
                      //CustomTextFormField(text: 'أضافه رقم السلعه'),
                      ItemHeader(invoiceType: invoiceType,),
                      SizedBox(
                        height: SizeConfig.screenHeight! * 0.2,
                        width: SizeConfig.screenWidth!,
                        child: ListView.builder(
                            itemCount: product.isEmpty ? 0 : product.length,
                            itemBuilder: (context, index) => ItemDetails(
                                  invoiceType: invoiceType,
                                  products2: widget.products,
                                  qty: widget.qty,
                                  ids: widget.ids,
                                  price: widget.price,
                                  products: product[index],
                                  getData: widget.getData,
                                )
                        ),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        ServData.getProducts().then((value) {
                          setState2(() {
                            product2 = value;
                            product = value;
                          });
                        });
                      },
                      child: Text('تحديث')),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'إغلاق',
                        style: TextStyle(color: Colors.red),
                      ))
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _showMyDialogRemove() async {
    TextEditingController searchController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        SizeConfig().init(context);
        return StatefulBuilder(
          builder: (BuildContext context2,
              void Function(void Function()) setState2) {
            void filterSearch(String query) {
              List<Products> dummyData = product2;
              if (query.isNotEmpty) {
                List<Products> resultSearchProduct = [];
                for (int x = 0; x < dummyData.length; x++) {
                  if (dummyData[x]
                      .productCode
                      .replaceAll('"', '')
                      .toLowerCase()
                      .contains(query.toLowerCase())) {
                    resultSearchProduct.add(dummyData[x]);
                  }
                }
                setState2(() {
                  product = resultSearchProduct;
                });
                return;
              } else {
                setState2(() {
                  product = [];
                  product = product2;
                });
              }
            }

            return Directionality(
              textDirection: TextDirection.rtl,
              child: AlertDialog(
                title: Text('إضافة صنف إلي الفاتورة'),
                content: SizedBox(
                  width: SizeConfig.screenWidth!,
                  height: SizeConfig.screenHeight! * 0.4,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: searchController,
                        onChanged: (value) {
                          print('$value');
                          filterSearch(value);
                        },
                        onFieldSubmitted: (v) {
                          filterSearch(v);
                        },
                        decoration: const InputDecoration(
                            labelText: 'إضافه رقم السلعه',
                            border: OutlineInputBorder()),
                      ),
                      //CustomTextFormField(text: 'أضافه رقم السلعه'),
                      ItemHeader(invoiceType: invoiceType,),
                      SizedBox(
                        height: SizeConfig.screenHeight! * 0.2,
                        width: SizeConfig.screenWidth!,
                        child: ListView.builder(
                            itemCount: product.isEmpty ? 0 : product.length,
                            itemBuilder: (context, index) => ItemDetails(
                                  invoiceType: invoiceType,
                                  qty: widget.qty,
                                  price: widget.price,
                                  ids: widget.ids,
                                  products2: widget.products,
                                  products: product[index],
                                  getData: widget.getData,
                                )),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        ServData.getProducts().then((value) {
                          setState2(() {
                            product2 = value;
                            product = value;
                          });
                        });
                      },
                      child: Text('تحديث')),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'إغلاق',
                        style: TextStyle(color: Colors.red),
                      ))
                  /*
                  TextButton(
                      child: const Text('Confirm data'),
                      onPressed: () => _verifiedOnTaped(ctx: context2)
                  ),
                  */
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    text: CustomText(
                      text: 'إضافة صنف',
                    ),
                    icon: const Icon(Icons.payment_outlined),
                    onPress: () => _showMyDialogAdd(),
                  ),
                  CustomButton(
                    text: CustomText(
                      text: 'تسديد أقساط',
                    ),
                    icon: const Icon(Icons.payment_outlined),
                    onPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const installmentPayment()),
                      );
                    },
                  ),
                  CustomButton(
                    text: CustomText(
                      text: 'إرجاع صنف',
                    ),
                    icon: const Icon(Icons.payment_outlined),
                    onPress: () => _showMyDialogRemove(),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    width: 200,
                    child: DropdownButton<String>(
                      value: invoiceType,
                      icon: const Icon(Icons.arrow_downward),                      elevation: 16,
                      style: const TextStyle(color: primaryColor, fontSize: 15),
                      underline: Container(
                        height: 2,
                        color: primaryColor,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          if(newValue != invoiceType){
                            if(newValue == 'قسط'&& widget.products.isNotEmpty){
                              _showErrorDialog('عذرا لا يمكن تغيير نوع الفاتورة من فضلك قم بحذف جميع المنتجات أولا', 'الدعم فني', context);
                            }else if(newValue == 'كاش'&& widget.products.isNotEmpty){
                              _showErrorDialog('عذرا لا يمكن تغيير نوع الفاتورة من فضلك قم بحذف جميع المنتجات أولا', 'الدعم فني', context);
                            }else{
                              invoiceType = newValue!;
                              widget.getType(invoiceType);
                            }
                          }

                        });
                      },
                      items: <String>[
                        'كاش',
                        'قسط',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }


  void _showSuccessDialog(BuildContext context) {
    AwesomeDialog(
        context: context,
        animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        dialogType: DialogType.SUCCES,
        showCloseIcon: false,
        title: 'نظام الفاتورة',
        desc: 'تمت إضافة المنتج للفاتورة بنجاح',
        btnOkOnPress: () {
        },
        btnOkIcon: Icons.check_circle,
        onDissmissCallback: (type) {})
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
