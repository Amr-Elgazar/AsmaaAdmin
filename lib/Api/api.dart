import 'dart:convert';

import 'package:asmaaadmin/Constants/const.dart';
import 'package:asmaaadmin/Modules/products_model.dart';
import 'package:asmaaadmin/Modules/section_model.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../Modules/all_orders.dart';

class ServData {
  static Future<List<Products>> getProducts() async {
    String baseUrl = root + 'get.php?action=GET_ALL_Product';
    var response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      return productsFromJson(response.body);
    } else {
      return [];
    }
  }

  static Future<List<Sections>> getSections() async {
    String baseUrl = root + 'get.php?action=GET_ALL_SECTION';
    var response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      return sectionsFromJson(response.body);
    } else {
      return [];
    }
  }

  static Future<ShowOrders?> getOurOrders() async {
    String baseUrl = root + 'get.php?action=GET_ALL_Orders';
    var response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      return showOrdersFromJson(response.body);
    } else {
      return null;
    }
  }

  static Future<String> SendOrder({
    required String name,
    required String phone,
    required String nameG,
    required String phoneG,
    required String invoiceType,
    required String amountPaid,
    required int productNum,
    required double total,
    required List products,
    required List qty,
    required List prices,
    required String discount,
  }) async {
    String baseUrl = root + 'orders.php';
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy/MM/dd');
    final String formatted = formatter.format(now);
    var map = {
      'action': 'SendOrder',
      'nameCustomer': name,
      'phone': phone,
      'nameCustomerG': name,
      'phoneG': phone,
      'invoiceType': invoiceType,
      'amountPaid': amountPaid,
      'productNum': jsonEncode(productNum),
      'total': jsonEncode(total),
      'product': jsonEncode(products),
      'qty': jsonEncode(qty),
      'price': jsonEncode(prices),
      'discount': discount,
      'created_at': formatted,
      'updated_at': formatted,
    };
    var response = await http.post(Uri.parse(baseUrl), body: map);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return '';
    }
  }

  static Future<String> paidINSTALLMENT({

    required String amountPaid,
    required int id,
  }) async {
    String baseUrl = root + 'orders.php';
    var map = {
      'action': 'PAID_INSTALLMENT',
      'amountPaid': amountPaid,
      'id': '$id',
    };
    var response = await http.post(Uri.parse(baseUrl), body: map);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return '';
    }
  }

  static Future<String> ReturnOrder({
    required String name,
    required String phone,
    required String invoiceType,
    required String amountPaid,
    required int productNum,
    required double total,
    required List products,
    required List qty,
    required List prices,
    required String discount,
  }) async {
    String baseUrl = root + 'orders.php';
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy/MM/dd');
    final String formatted = formatter.format(now);
    var map = {
      'action': 'ReturnOrder',
      'nameCustomer': name,
      'phone': phone,
      'invoiceType': invoiceType,
      'amountPaid': amountPaid,
      'productNum': jsonEncode(productNum),
      'total': jsonEncode(total),
      'product': jsonEncode(products),
      'qty': jsonEncode(qty),
      'price': jsonEncode(prices),
      'discount': discount,
      'created_at': formatted,
    };
    var response = await http.post(Uri.parse(baseUrl), body: map);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return '';
    }
  }
}
