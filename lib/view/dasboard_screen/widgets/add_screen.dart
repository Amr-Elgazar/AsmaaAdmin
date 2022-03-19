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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  List<Products> product = [], product2 = [];

  String dropdownValue = 'كاش';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ServData.getProducts().then((value) {
      print(value[0]);
      setState(() {
        product = value;
        product2 = value;
      });
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> _showMyDialog() async {
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
                title: Row(
                  children: [
                    Text('إضافة صنف إلي الفاتورة'),
                    TextButton(
                        onPressed: () {
                          ServData.getProducts().then((value) {
                            setState2(() {
                              product2 = value ;
                              product = value;
                            });
                          });
                        },
                        child: Text('تحديث'))
                  ],
                ),
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
                      ItemHeader(),
                      SizedBox(
                        height: SizeConfig.screenHeight! * 0.2,
                        width: SizeConfig.screenWidth!,
                        child: ListView.builder(
                            itemCount: product.isEmpty ? 0 : product.length,
                            itemBuilder: (context, index) => ItemDetails(
                                name: product[index].name,
                                id: product[index].productCode,
                                installmentPrice:
                                    product[index].installmentPrice,
                                selling: product[index].sellingPrice,
                                wholesale: product[index].wholesalePrice)),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
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
                    icon: Icon(Icons.payment_outlined),
                    onPress: () => _showMyDialog(),
                  ),
                  CustomButton(
                    text: CustomText(
                      text: 'تسديد أقساط',
                    ),
                    icon: Icon(Icons.payment_outlined),
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
                    icon: Icon(Icons.payment_outlined),
                    onPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const installmentPayment()),
                      );
                    },
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    width: 200,
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: primaryColor, fontSize: 15),
                      underline: Container(
                        height: 2,
                        color: primaryColor,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>[
                        'كاش',
                        'قسط',
                        'جمله',
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
}
