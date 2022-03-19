import 'package:asmaaadmin/view/widgets/custom_text.dart';
import 'package:asmaaadmin/view/widgets/primary_color.dart';
import 'package:flutter/material.dart';

class ItemDetails extends StatefulWidget {
  String id , name ,selling , wholesale , installmentPrice ;
   ItemDetails({Key? key , required this.name , required this.id , required this.installmentPrice , required this.selling , required this.wholesale}) : super(key: key);

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10,right: 30,left: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(text: widget.name.replaceAll('"', ''),fontSize: 20,)
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(text: '${int.parse(widget.selling.replaceAll('"', ''))}',fontSize: 20,)
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(text: '${int.parse(widget.id.replaceAll('"', ''))}',fontSize: 20,)
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(text: '${int.parse(widget.installmentPrice.replaceAll('"', ''))}',fontSize: 20,)
            ],
          ),
          Column(
            children: [
              CustomText(text: '30 قطعه',fontSize: 20,)
            ],
          ),
    IconButton(onPressed: (){}, icon: Icon(Icons.remove,size: 35,))

        ],
      ),
    );
  }
}
