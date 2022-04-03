import 'dart:convert';

import 'order_model.dart';

ShowOrders showOrdersFromJson(String str) => ShowOrders.fromJson(json.decode(str));

String showOrdersToJson(ShowOrders data) => json.encode(data.toJson());

class ShowOrders {
  ShowOrders({
    required this.orders,
  });

  List<Order> orders;

  factory ShowOrders.fromJson(Map<String, dynamic> json) => ShowOrders(
    orders: List<Order>.from(json["Orders"].map((x) => Order.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Orders": List<dynamic>.from(orders.map((x) => x.toJson())),
  };
}


