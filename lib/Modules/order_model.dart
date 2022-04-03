import 'package:asmaaadmin/Modules/products_model.dart';

class Order {
  Order({
   required this.id,
   required this.name,
   required this.phone,
   required this.invoiceType,
   required this.productNum,
   required this.total,
   required this.products,
   required this.qty,
   required this.prices,
  });

  String id;
  String name;
  String phone;
  String invoiceType;
  String productNum;
  String total;
  List<Products> products;
  String qty;
  String prices;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    invoiceType: json["invoiceType"],
    productNum: json["productNum"],
    total: json["Total"],
    products: List<Products>.from(json["products"].map((x) => Products.fromJson(x))),
    qty: json["qty"],
    prices: json["prices"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "invoiceType": invoiceType,
    "productNum": productNum,
    "Total": total,
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
    "qty": qty,
    "prices": prices,
  };
}