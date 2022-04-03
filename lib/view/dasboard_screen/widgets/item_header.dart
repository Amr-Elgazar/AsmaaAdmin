import 'package:asmaaadmin/view/widgets/custom_text.dart';
import 'package:asmaaadmin/view/widgets/primary_color.dart';
import 'package:flutter/material.dart';

class ItemHeader extends StatefulWidget {
  String invoiceType;
  ItemHeader({Key? key , required this.invoiceType}) : super(key: key);

  @override
  State<ItemHeader> createState() => _ItemHeaderState();
}

class _ItemHeaderState extends State<ItemHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Row(
            children: [
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.all(5.0),
                      color: Colors.blue,
                      child: CustomText(
                        text: 'إسم السلعه',
                        color: Colors.white,
                        fontSize: 16,
                      ))),
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.all(5.0),
                      color: Colors.blue,
                      child: CustomText(
                        text: 'الرقم',
                        color: Colors.white,
                        fontSize: 16,
                      ))),
            ],
          )),
          Visibility(
            visible: widget.invoiceType.contains('قسط'),
            child: Expanded(
                child: Container(
                    padding: const EdgeInsets.all(5.0),
                    color: Colors.blue,
                    child: CustomText(
                      text: 'سعر القسط',
                      color: Colors.white,
                      fontSize: 16,
                    ))),
          ),
          Visibility(
            visible: widget.invoiceType.contains('جملة') || widget.invoiceType.contains('كاش'),
            child: Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                          padding: const EdgeInsets.all(5.0),
                          color: Colors.blue,
                          child: CustomText(
                            text: 'سعر البيع',
                            color: Colors.white,
                            fontSize: 16,
                          ))),
                  Expanded(
                      child: Container(
                          padding: const EdgeInsets.all(5.0),
                          color: Colors.blue,
                          child: CustomText(
                            text: 'سعر الجملة',
                            color: Colors.white,
                            fontSize: 16,
                          ))),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                    child: Container(
                        padding: const EdgeInsets.all(5.0),
                        color: Colors.blue,
                        child: CustomText(
                          text: 'متبقي',
                          color: Colors.white,
                          fontSize: 16,
                        ))),
                Expanded(
                    child: Container(
                        padding: const EdgeInsets.all(5.0),
                        color: Colors.blue,
                        child: CustomText(
                          text: 'إضافة المنتج الي الفاتورة',
                          color: Colors.white,
                          fontSize: 16,
                        ))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
