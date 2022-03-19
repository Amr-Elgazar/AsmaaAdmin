import 'package:asmaaadmin/view/widgets/custom_text.dart';
import 'package:asmaaadmin/view/widgets/primary_color.dart';
import 'package:flutter/material.dart';

class ItemHeader extends StatefulWidget {

  ItemHeader({Key? key}) : super(key: key);

  @override
  State<ItemHeader> createState() => _ItemHeaderState();
}

class _ItemHeaderState extends State<ItemHeader> {

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
              CustomText(text: 'اسم السلعه',color: primaryColor,fontSize: 25,),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(text: 'السعر',color: primaryColor,fontSize: 25,),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(text: 'الرقم',color: primaryColor,fontSize: 25,),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(text: 'سعر القسط',color: primaryColor,fontSize: 25,),
            ],
          ),
          Column(
            children: [
              CustomText(text: 'متبقي',color: primaryColor,fontSize: 25,),

            ],
          ),
          IconButton(onPressed: (){}, icon: Icon(Icons.remove,size: 35,))
        ],
      ),
    );
  }
}
