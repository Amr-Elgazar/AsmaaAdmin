import 'package:asmaaadmin/Modules/products_model.dart';
import 'package:asmaaadmin/core/size_config.dart';
import 'package:asmaaadmin/view/widgets/custom_text.dart';
import 'package:asmaaadmin/view/widgets/primary_color.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class ItemDetails extends StatefulWidget {
  Products products;
  List<Products> products2;
  String invoiceType;

  List<int> qty;
  List ids ;
  List<double> price;
  final Function(List<Products> products, List<int> qtys, List<double> prices)
      getData;

  ItemDetails(
      {Key? key,
      required this.products,
      required this.getData,
      required this.products2,
      required this.qty,
      required this.price,
      required this.ids,
      required this.invoiceType})
      : super(key: key);

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  List<Products> product = [];
  List<int> qtys = [];

  List<double> prices = [];

  int _radioChooseSection = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 30, left: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                    child: CustomText(
                  text: widget.products.name.replaceAll('"', ''),
                  fontSize: 16,
                )),
                Expanded(
                    child: CustomText(
                  text:
                      '${int.parse(widget.products.productCode.replaceAll('"', ''))}',
                  fontSize: 16,
                )),
              ],
            ),
          ),
          Visibility(
            visible: widget.invoiceType.contains('قسط'),
            child: Expanded(
                child: CustomText(
              text:
                  '${int.parse(widget.products.installmentPrice.replaceAll('"', ''))}',
              fontSize: 16,
            )),
          ),
          Visibility(
            visible: widget.invoiceType.contains('جملة') ||
                widget.invoiceType.contains('كاش'),
            child: Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: _buildRadioChoosePrice(1,
                          '${int.parse(widget.products.sellingPrice.replaceAll('"', ''))}')),
                  Expanded(
                      child: _buildRadioChoosePrice(2,
                          '${int.parse(widget.products.wholesalePrice.replaceAll('"', ''))}')),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                    child: CustomText(
                  text:
                      '    ${int.parse(widget.products.productNum.replaceAll('"', ''))}',
                  fontSize: 16,
                )),
                Expanded(
                    child: IconButton(
                        onPressed: () => onPressed(),
                        icon: CustomText(
                          color: Colors.blueAccent,
                          text: 'إضافة',
                          fontSize: 16,
                        )))
              ],
            ),
          ),
        ],
      ),
    );
  }

  RadioListTile<dynamic> _buildRadioChoosePrice(val, txt) {
    return RadioListTile(
      controlAffinity: ListTileControlAffinity.platform,
      activeColor: Colors.blue,
      value: val,
      groupValue: _radioChooseSection,
      onChanged: (value) {
        setState(() {
          _radioChooseSection = value;

        });
      },
      title: Text(
        txt,
        style: const TextStyle(
            color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  void onPressed() {
    setState(() {
      if(widget.products.productNum == '0'){
        _showErrorDialog(
            'لايمكن إضافة هذا المنتج لعدم توفره بالمخازن',
            'نظام الفاتورة',
            context);
      }else{
        if (product.isEmpty) {
          if (widget.invoiceType == 'كاش' || widget.invoiceType == 'جملة') {
            if(_radioChooseSection !=0) {
              if (!widget.products2.contains(widget.products)) {
                product.add(widget.products);
                print(_radioChooseSection);
                if (_radioChooseSection == 1) {
                  widget.price.add(double.parse(
                      widget.products.sellingPrice.replaceAll('"', '')));
                  widget.products2.add(widget.products);
                  qtys = widget.qty;
                  widget.ids.add(int.parse(widget.products.id));
                  qtys.add(1);
                  widget.getData(widget.products2, qtys, widget.price);
                  _showSuccessDialog(context);
                } else if (_radioChooseSection == 2) {
                  widget.price.add(double.parse(
                      widget.products.wholesalePrice.replaceAll('"', '')));
                  widget.products2.add(widget.products);
                  widget.ids.add(int.parse(widget.products.id));
                  qtys = widget.qty;
                  qtys.add(1);
                  widget.getData(widget.products2, qtys, widget.price);
                  _showSuccessDialog(context);
                }
              } else {
                _showErrorDialog(
                    'تمت إضافة هذا المنتج إلي الفاتورة من فضلك قم بزيادة الكمية إذا أردت',
                    'نظام الفاتورة',
                    context);
              }
            }
          } else {
            if (!widget.products2.contains(widget.products)) {
              product.add(widget.products);
              widget.price.add(double.parse(
                  widget.products.installmentPrice.replaceAll('"', '')));
              widget.products2.add(widget.products);
              widget.ids.add(int.parse(widget.products.id));
              qtys = widget.qty;
              qtys.add(1);
              widget.getData(widget.products2, qtys, widget.price);
              _showSuccessDialog(context);
            } else {
              _showErrorDialog(
                  'تمت إضافة هذا المنتج إلي الفاتورة من فضلك قم بزيادة الكمية إذا أردت',
                  'نظام الفاتورة',
                  context);
            }
          }
        } else {
          if (widget.invoiceType == 'كاش' || widget.invoiceType == 'جملة') {
            if(_radioChooseSection !=0) {
              if (!product.contains(widget.products)) {
                product.add(widget.products);
                print(_radioChooseSection);
                if (_radioChooseSection == 1) {
                  widget.price.add(double.parse(
                      widget.products.sellingPrice.replaceAll('"', '')));
                  widget.products2.add(widget.products);
                  widget.ids.add(int.parse(widget.products.id));
                  qtys = widget.qty;
                  qtys.add(1);
                  widget.getData(widget.products2, qtys, widget.price);
                  _showSuccessDialog(context);
                } else if (_radioChooseSection == 2) {
                  widget.price.add(double.parse(
                      widget.products.wholesalePrice.replaceAll('"', '')));
                  widget.products2.add(widget.products);
                  widget.ids.add(int.parse(widget.products.id));
                  qtys = widget.qty;
                  qtys.add(1);
                  widget.getData(widget.products2, qtys, widget.price);
                  _showSuccessDialog(context);
                }
              } else {
                _showErrorDialog(
                    'تمت إضافة هذا المنتج إلي الفاتورة من فضلك قم بزيادة الكمية إذا أردت',
                    'نظام الفاتورة',
                    context);
              }
            }
          } else {
            if (!product.contains(widget.products)) {
              product.add(widget.products);
              widget.price.add(double.parse(
                  widget.products.installmentPrice.replaceAll('"', '')));
              widget.products2.add(widget.products);
              widget.ids.add(int.parse(widget.products.id));
              qtys = widget.qty;
              qtys.add(1);
              widget.getData(widget.products2, qtys, widget.price);
              _showSuccessDialog(context);
            } else {
              _showErrorDialog(
                  'تمت إضافة هذا المنتج إلي الفاتورة من فضلك قم بزيادة الكمية إذا أردت',
                  'نظام الفاتورة',
                  context);
            }
          }

        }
      }


    });
  }

  void _showSuccessDialog(BuildContext context) {
    AwesomeDialog(
            context: context,
            width: SizeConfig.screenWidth! * 0.4,
            animType: AnimType.LEFTSLIDE,
            headerAnimationLoop: false,
            dialogType: DialogType.SUCCES,
            showCloseIcon: false,
            title: 'نظام الفاتورة',
            desc: 'تمت إضافة المنتج للفاتورة بنجاح',
            btnOkOnPress: () {
              setState(() {
                _radioChooseSection= 0;
              });
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
