import 'package:asmaaadmin/Api/api.dart';
import 'package:asmaaadmin/view/dasboard_screen/widgets/add_screen.dart';
import 'package:asmaaadmin/view/dasboard_screen/widgets/itemDetails.dart';
import 'package:asmaaadmin/view/dasboard_screen/widgets/itemList.dart';
import 'package:asmaaadmin/view/widgets/custom_button.dart';
import 'package:asmaaadmin/view/widgets/custom_text.dart';
import 'package:asmaaadmin/view/widgets/custom_text_form_field.dart';
import 'package:asmaaadmin/view/widgets/primary_color.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,

          title: Row(children: [
            CustomText(text: 'اسماء',
              color: primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 23,),
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Image.asset('assets/logo.jpg'),
            )
          ]),
        ),
        body: Column(
          children: [
            AddScreen(),
           // ItemDetails(),
            SizedBox(height: 5,),
            Divider(color: Colors.black,),
            ItemList(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                      CustomButton(text: CustomText(text: 'طباعه',fontSize: 17,), icon: Icon(Icons.print),onPress: (){},),
                    Container(
                      width: 100,
                        child: CustomTextFormField(text: 'خصم %')),
                    CustomText(text: 'المجموع : 486', fontSize: 25,),
                    CustomText(text: 'مجموع الاصناف : 2', fontSize: 25,),
                  ],
                ),
              ),
            ),
                ],
              ),
            )
    );
}
}
