import 'package:asmaaadmin/view/widgets/custom_text.dart';
import 'package:asmaaadmin/view/widgets/custom_text_form_field.dart';
import 'package:asmaaadmin/view/widgets/primary_color.dart';
import 'package:flutter/material.dart';

class installmentPayment extends StatefulWidget {
  const installmentPayment({Key? key}) : super(key: key);

  @override
  State<installmentPayment> createState() => _installmentPaymentState();
}

class _installmentPaymentState extends State<installmentPayment> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text('تسديد أقساط'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CustomTextFormField(text: 'رقم الهاتف'),
            ),
            CustomText(text: 'الاسم : عمرو احمد محمد',fontSize: 20,),
            SizedBox(height: 10,),
            CustomText(text: 'رقم الهاتف : 01030691425',fontSize: 20,),
            SizedBox(height: 10,),
            CustomText(text: 'العنوان : عزبه بكري اما دار المناسبات',fontSize: 20,),
            SizedBox(height: 10,),
            CustomText(text: 'اسم الضامن : عمرو احمد محمد',fontSize: 20,),
            SizedBox(height: 10,),
            CustomText(text: 'رقم الهاتف : 01030691425',fontSize: 20,),
            SizedBox(height: 10,),
            Material(
              elevation: 10,
                child: CustomText(text: 'باقي المبلغ : 2345',fontSize: 20,fontWeight: FontWeight.bold,)),
            SizedBox(height: 10,),
            Material(
                elevation: 10,
                child: CustomText(text: 'المطلوب سداده : 500',fontSize: 20,fontWeight: FontWeight.bold,)),
          ],
        ),
      ),
    );
  }
}
