import 'package:asmaaadmin/view/installment_payment/installment_payment.dart';
import 'package:asmaaadmin/view/widgets/custom_button.dart';
import 'package:asmaaadmin/view/widgets/custom_text.dart';
import 'package:asmaaadmin/view/widgets/custom_text_form_field.dart';
import 'package:asmaaadmin/view/widgets/primary_color.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  String dropdownValue = 'كاش';
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: [
             Row(
               mainAxisAlignment:   MainAxisAlignment.spaceEvenly,
               children: [
               CustomButton(text: CustomText(text: 'تسديد أقساط',), icon: Icon(Icons.payment_outlined),onPress: (){Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => const installmentPayment()),
               );},),
               Container(
                 alignment: Alignment.topRight,
                 width: 200,
                 child: DropdownButton<String>(
                   value: dropdownValue,
                   icon: const Icon(Icons.arrow_downward),
                   elevation: 16,
                   style: const TextStyle(color: primaryColor,fontSize: 15),
                   underline: Container(
                     height: 2,
                     color: primaryColor,
                   ),
                   onChanged: (String? newValue) {
                     setState(() {
                       dropdownValue = newValue!;
                     });
                   },
                   items: <String>['كاش', 'قسط', 'جمله',]
                       .map<DropdownMenuItem<String>>((String value) {
                     return DropdownMenuItem<String>(
                       value: value,
                       child: Text(value),
                     );
                   }).toList(),
                 ),
               ),
             ],),

              CustomTextFormField(text: 'أضافه رقم السلعه')
            ],
          ),
        ),
      ),
    );
  }
}
