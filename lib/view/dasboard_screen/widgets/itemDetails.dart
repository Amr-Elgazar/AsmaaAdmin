import 'package:asmaaadmin/view/widgets/custom_text.dart';
import 'package:asmaaadmin/view/widgets/primary_color.dart';
import 'package:flutter/material.dart';

class ItemDetails extends StatefulWidget {
  const ItemDetails({Key? key}) : super(key: key);

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10,right: 30,left: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              CustomText(text: 'اسم السلعه',color: primaryColor,fontSize: 25,),
              CustomText(text: 'حله توب شيف جرانيت',fontSize: 20,)
            ],
          ),
          Column(
            children: [
              CustomText(text: 'السعر',color: primaryColor,fontSize: 25,),
              CustomText(text: '245',fontSize: 20,)
            ],
          ),
          Column(
            children: [
              CustomText(text: 'الرقم',color: primaryColor,fontSize: 25,),
              CustomText(text: '1001',fontSize: 20,)
            ],
          ),
          Column(
            children: [
              CustomText(text: 'المخزن',color: primaryColor,fontSize: 25,),
              CustomText(text: 'الامامي',fontSize: 20,)
            ],
          ),
          Column(
            children: [
              CustomText(text: 'متبقي',color: primaryColor,fontSize: 25,),
              CustomText(text: '30 قطعه',fontSize: 20,)
            ],
          ),
          IconButton(onPressed: (){}, icon: Icon(Icons.add,size: 50,)),
    IconButton(onPressed: (){}, icon: Icon(Icons.remove,size: 50,))

        ],
      ),
    );
  }
}
