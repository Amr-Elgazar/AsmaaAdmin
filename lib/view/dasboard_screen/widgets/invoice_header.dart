import 'package:asmaaadmin/Constants/const.dart';
import 'package:asmaaadmin/view/widgets/custom_text.dart';
import 'package:asmaaadmin/view/widgets/primary_color.dart';
import 'package:flutter/material.dart';

class InvoiceHeader extends StatefulWidget {
  String invoiceType ;
  InvoiceHeader({Key? key , required this.invoiceType}) : super(key: key);

  @override
  State<InvoiceHeader> createState() => _InvoiceHeaderState();
}

class _InvoiceHeaderState extends State<InvoiceHeader> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  const EdgeInsets.symmetric(horizontal:kMarginHorizontalHeader),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(child: Container(padding:const EdgeInsets.all(5.0) ,color: Colors.blue , child: CustomText(text: 'إسم السلعه',color: Colors.white,fontSize: 16,))),
                Expanded(child: Container(padding:const EdgeInsets.all(5.0) ,color: Colors.blue ,child: CustomText(text: 'المخزون',color: Colors.white,fontSize: 16,))),
                Expanded(child: Container(padding:const EdgeInsets.all(5.0) ,color: Colors.blue ,child: CustomText(text: widget.invoiceType.contains('جملة') ||  widget.invoiceType.contains('كاش') ? 'سعر البيع': 'سعر القسط',color: Colors.white,fontSize: 16,))),
              ],
            ),
          ),

          Expanded(
              child: Row(
            children: [
              Expanded(child: Container(padding:const EdgeInsets.all(5.0) ,color: Colors.blue ,child: CustomText(text: 'الكمية',color: Colors.white,fontSize: 16,))),
              Expanded(child: Container(padding:const EdgeInsets.all(5.0) ,color: Colors.blue ,child: CustomText(text: 'المجموع',color: Colors.white,fontSize: 16,))),
              Expanded(child: Container(padding:const EdgeInsets.all(5.0) ,color: Colors.blue ,child: CustomText(text: 'حذف من الفاتورة',color: Colors.white,fontSize: 16,))),
            ],
          )),
        ],
      ),
    );
  }
}
