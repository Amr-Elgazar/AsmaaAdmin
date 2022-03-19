import 'dart:convert';


import 'package:asmaaadmin/Constants/const.dart';
import 'package:asmaaadmin/Modules/products_model.dart';
import 'package:asmaaadmin/Modules/section_model.dart';
import 'package:http/http.dart' as http;

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
}
