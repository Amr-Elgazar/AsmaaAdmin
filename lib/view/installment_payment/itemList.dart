
import 'package:flutter/material.dart';

import '../../Modules/products_model.dart';
import '../widgets/custom_text.dart';

class ItemListOrder extends StatefulWidget {
  List<Products> products = [];
  List qtys = [];
  List prices = [];

  ItemListOrder({Key? key, required this.products , required this.qtys , required this.prices }) : super(key: key);

  @override
  State<ItemListOrder> createState() => _ItemListOrderState();
}

class _ItemListOrderState extends State<ItemListOrder> {

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child: ListView.builder(
            itemCount: widget.products.isEmpty ? 0 : widget.products.length,
            itemBuilder: (context, index) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                        child: CustomText(
                      text:  widget.products[index].name.replaceAll('"', ''),
                      fontSize: 17,
                    )),
                    Expanded(
                        child: CustomText(
                          text: '${int.parse(widget.products[index].productNum.replaceAll('"', ''))}',
                          fontSize: 17,
                        )),
                    Expanded(
                        child: CustomText(
                          text: '    ${widget.prices[index]}',
                          fontSize: 17,
                        )),
                  ],
                ),
              ),


              Expanded(
                child: Row(
                  children: [
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomText(
                            text: '${widget.qtys[index]}',
                            fontSize: 17,
                          ),
                        )),
                    Expanded(
                        child: CustomText(
                          text: '${widget.qtys[index] *  widget.prices[index]}',
                          fontSize: 17,
                        )),
                  ],
                ),
              ),
            ],
          );
        })
    );
  }
}
