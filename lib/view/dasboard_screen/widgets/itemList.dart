import 'package:asmaaadmin/Constants/const.dart';
import 'package:asmaaadmin/Modules/products_model.dart';
import 'package:asmaaadmin/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ItemList extends StatefulWidget {
  final Function() updateTotal;
  List<Products> products = [];
  List<int> qtys = [];
  List ids;
  List<double> prices = [];

  ItemList({Key? key, required this.products , required this.qtys , required this.prices ,required this.updateTotal , required this.ids}) : super(key: key);

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          margin:  const EdgeInsets.symmetric(horizontal:kMarginHorizontalHeader),
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
                          child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    if(!(widget.qtys[index] >= int.parse(widget.products[index].productNum.replaceAll('"', '')))){
                                      widget.qtys[index]++;
                                    }
                                  });
                                  widget.updateTotal();
                                },
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.green,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomText(
                              text: '${widget.qtys[index]}',
                              fontSize: 17,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    if( widget.qtys[index]!= 1) {
                                      widget.qtys[index]-- ;
                                    }
                                  });
                                  widget.updateTotal();
                                },
                                icon: const Icon(
                                  Icons.remove,
                                  color: Colors.red,
                                )),
                          ),
                        ],
                      )),
                      Expanded(
                          child: CustomText(
                            text: '${widget.qtys[index] *  widget.prices[index]}',
                            fontSize: 17,
                          )),
                      Expanded(
                          child: InkWell(
                            onTap: (){
                              setState(() {
                                widget.products.removeAt(index);
                                widget.qtys.removeAt(index);
                                widget.ids.removeAt(index);
                                widget.prices.removeAt(index);
                                widget.updateTotal();
                              });

                            },
                            child: Icon(Icons.remove_circle_outlined , color: Colors.red,)
                          )),
                    ],
                  ),
                ),
              ],
            );
          })
      ),
    );
  }
}
