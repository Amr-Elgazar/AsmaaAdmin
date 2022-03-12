import 'package:asmaaadmin/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ItemList extends StatefulWidget {
  const ItemList({Key? key}) : super(key: key);

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        elevation: 3,
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15)
            ),
            child:  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomText(text: 'حله توب شيف جرانيت',fontSize: 17,),
                      CustomText(text: '243',fontSize: 17,),
                      CustomText(text: '1',fontSize: 17,),
                      IconButton(onPressed: (){}, icon: Icon(Icons.add,color: Colors.green,)),
                      IconButton(onPressed: (){}, icon: Icon(Icons.remove,color: Colors.red,)),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomText(text: 'حله توب شيف جرانيت',fontSize: 17,),
                      CustomText(text: '243',fontSize: 17,),
                      CustomText(text: '1',fontSize: 17,),
                      IconButton(onPressed: (){}, icon: Icon(Icons.add,color: Colors.green,)),
                      IconButton(onPressed: (){}, icon: Icon(Icons.remove,color: Colors.red,)),
                    ],
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
}
