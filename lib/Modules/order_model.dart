import 'package:asmaaadmin/Modules/products_model.dart';

class Order {
  Order(
      {required this.id,
      required this.name,
      required this.phone,
      required this.invoiceType,
      required this.amountPaid,
      required this.productNum,
      required this.total,
      required this.products,
      required this.qty,
      required this.prices,
      required this.discount});

  String id;
  String name;
  String phone;
  String invoiceType;
  String amountPaid;
  String productNum;
  String total;
  List<Products> products;
  String qty;
  String prices;
  String discount;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        invoiceType: json["invoiceType"],
        amountPaid: json["amountPaid"],
        productNum: json["productNum"],
        total: json["Total"],
        products: List<Products>.from(
            json["products"].map((x) => Products.fromJson(x))),
        qty: json["qty"],
        prices: json["prices"],
        discount: json["discount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "invoiceType": invoiceType,
        "amountPaid": amountPaid,
        "productNum": productNum,
        "Total": total,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "qty": qty,
        "prices": prices,
        "discount": discount,
      };
}
