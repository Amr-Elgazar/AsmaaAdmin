import 'dart:convert';

import 'package:asmaaadmin/Api/api.dart';
import 'package:asmaaadmin/view/installment_payment/itemList.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import '../../../Modules/order_model.dart';
import '../../../core/size_config.dart';
import '../dasboard_screen/widgets/invoice_header.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';

class OrderItem extends StatefulWidget {
  Order orders;

  OrderItem({Key? key, required this.orders}) : super(key: key);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool isTapped4 = true, isExpanded4 = false;

  TextEditingController controllerAmountPaid = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, right: 10.0, left: 10.0),
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        curve: Curves.fastLinearToSlowEaseIn,
        height: isTapped4
            ? isExpanded4
                ? 200
                : 200
            : isExpanded4
                ? 250
                : 350,
        decoration: BoxDecoration(
          border: Border.all(
              color: Colors.blue, // set border color
              width: 1.0), // set border width
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          // set rounded corner radius
        ),
        child: isTapped4
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            isTapped4 = !isTapped4;
                          });
                        },
                        icon: Icon(
                          isTapped4
                              ? Icons.keyboard_arrow_down
                              : Icons.keyboard_arrow_up,
                          color: Colors.blue,
                          size: 27,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text('الإسم : ' + widget.orders.name)),
                          Expanded(
                              child:
                                  Text('رقم الهاتف : ' + widget.orders.phone)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text('عدد المنتجات : ' +
                                  widget.orders.productNum)),
                          Expanded(
                              child: Text('نوع الفاتورة : ' +
                                  widget.orders.invoiceType)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text('المبلغ المدفوع : ' +
                                  widget.orders.amountPaid)),
                          Expanded(
                              child: Text('الخصم : ' + widget.orders.discount)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                              child:Text('إجمالي الفاتورة : ' + widget.orders.total)),
                          Expanded(
                              child: Text('المبلغ المتبقي  : ' + '${double.parse(widget.orders.total) - double.parse(widget.orders.amountPaid)}' )),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            isTapped4 = !isTapped4;
                          });
                        },
                        icon: Icon(
                          isTapped4
                              ? Icons.keyboard_arrow_down
                              : Icons.keyboard_arrow_up,
                          color: Colors.blue,
                          size: 27,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text('الإسم : ' + widget.orders.name)),
                          Expanded(
                              child:
                                  Text('رقم الهاتف : ' + widget.orders.phone)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text('عدد المنتجات : ' +
                                  widget.orders.productNum)),
                          Expanded(
                              child: Text('نوع الفاتورة : ' +
                                  widget.orders.invoiceType)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text('المبلغ المدفوع : ' +
                                  widget.orders.amountPaid)),
                          Expanded(
                              child: Text('الخصم : ' + widget.orders.discount)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                              child:Text('إجمالي الفاتورة : ' + widget.orders.total)),
                          Expanded(
                              child: Text('المبلغ المتبقي  : ' + '${double.parse(widget.orders.total) - double.parse(widget.orders.amountPaid)}' )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: TextFormField(
                        controller: controllerAmountPaid,
                        decoration: const InputDecoration(
                            labelText: 'المبلغ المدفوع',
                            border: OutlineInputBorder()),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child:
                          InvoiceHeader(invoiceType: widget.orders.invoiceType),
                    ),
                    SizedBox(
                        width: SizeConfig.screenWidth,
                        height: SizeConfig.screenHeight! * 0.2,
                        child: ItemListOrder(
                          products: widget.orders.products,
                          qtys: jsonDecode(widget.orders.qty),
                          prices: jsonDecode(widget.orders.prices),
                        )),
                    CustomButton(
                      text: CustomText(
                        text: 'دفع',
                        fontSize: 17,
                      ),
                      icon: Icon(Icons.print),
                      onPress: () => onTap(),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  onTap() {
    if (controllerAmountPaid.text.isNotEmpty  ) {
      if((double.parse(controllerAmountPaid.text) + double.parse(widget.orders.amountPaid)) <= (double.parse(widget.orders.total) )){
        ServData.paidINSTALLMENT(
            amountPaid: '${double.parse(controllerAmountPaid.text) + double.parse(widget.orders.amountPaid)}',
            id: int.parse(widget.orders.id),).then((value) {
              if(value == 'Updated'){
                _showSuccessDialog(context);

              }else{
                _showErrorDialog('خطأ لم يتم إتمام عملية الدفع',
                    'تسديد الأقساط', context);
              }
        });
      }else{
        _showErrorDialog('عذرا المبلغ المدفوع أكثر من المستحق',
            'تسديد الأقساط', context);
      }
    }else{
      _showErrorDialog('لا يمكن إتمام الدفع بدون إدخال القسط المدفوع',
          'تسديد الأقساط', context);
    }
  }

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
            desc: 'تم دفع قسط الفاتورة بنجاح',
            btnOkOnPress: () {
              Navigator.of(context).pop();
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
