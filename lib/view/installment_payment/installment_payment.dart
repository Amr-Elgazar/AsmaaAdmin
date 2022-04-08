
import 'package:flutter/material.dart';

import '../../Api/api.dart';
import '../../Modules/all_orders.dart';
import '../../Modules/order_model.dart';
import '../../core/size_config.dart';
import 'item_order.dart';

class installmentPayment extends StatefulWidget {
  const installmentPayment({Key? key}) : super(key: key);

  @override
  State<installmentPayment> createState() => _installmentPaymentState();
}

class _installmentPaymentState extends State<installmentPayment> {

  ShowOrders? showOrders;
  List<Order> ourOrders = [],ourOrders2 = [];
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ServData.getOurOrders().then((value) {

        showOrders = value;
        showOrders?.orders.forEach((element) {
          if(element.invoiceType == 'قسط'){
            setState(() {
            ourOrders.add(element) ;
            ourOrders2.add(element) ;

            });
          }


        isLoading = true;
      });
    });
  }


  void filterSearch(String query) {
    List<Order> dummyData = ourOrders2;
    if (query.isNotEmpty) {
      List<Order> resultSearchProduct = [];
      for (int x = 0; x < dummyData.length; x++) {
        if (dummyData[x]
            .name
            .replaceAll('"', '')
            .toLowerCase()
            .contains(query.toLowerCase())) {
          resultSearchProduct.add(dummyData[x]);
        }else  if (dummyData[x]
            .phone
            .replaceAll('"', '')
            .toLowerCase()
            .contains(query.toLowerCase())) {
          resultSearchProduct.add(dummyData[x]);
        }
      }
      setState(() {
        ourOrders = resultSearchProduct;
      });
      return;
    } else {
      setState(() {
        ourOrders = [];
        ourOrders = ourOrders2;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return isLoading
        ? Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('تسديد إقساط'),
          centerTitle: true ,
        ),
        body: Container(
          width: SizeConfig.screenWidth!,
          height: SizeConfig.screenHeight!,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (v){
                    if(v.isEmpty){
                      setState(() {
                        ourOrders = ourOrders2;
                      });
                    }else{
                      filterSearch(v);
                    }
                  },
                  decoration: const InputDecoration(
                      labelText: 'بحث بإسم العميل أو الضامن رقم هاتف العميل أو الضامن',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.search),

                  ),

                ),
              ),
              ourOrders.isEmpty? Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('لا يوجد أي طلبات متاحة الآن')
                  ],
                ),
              ):Expanded(
                child: ListView.builder(
                    itemCount: ourOrders.isEmpty ? 0 : ourOrders.length,
                    itemBuilder: (context, index) {
                      return OrderItem(orders: ourOrders[index]);
                    }),
              ),
            ],
          ),
        ),
      ),
    )
        : Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(
            color: Colors.blue,
          ),
          Text('إنتظر جاري تجهيز الطلبات')
        ],
      ),
    );
  }


}
