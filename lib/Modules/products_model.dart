import 'dart:convert';

List<Products> productsFromJson(String str) => List<Products>.from(json.decode(str).map((x) => Products.fromJson(x)));

String productsToJson(List<Products> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Products {
  Products({
  required this.id,
  required this.name,
  required this.description,
  required this.productNum,
  required this.sellingPrice,
  required this.purchasePrice,
  required this.wholesalePrice,
  required this.installmentPrice,
  required this.productCode,
  required this.sectionId,
  });

  String id;
  String name;
  String description;
  String productNum;
  String sellingPrice;
  String purchasePrice;
  String wholesalePrice;
  String installmentPrice;
  String productCode;
  String sectionId;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    id: '${json["id"]}',
    name: json["name"],
    description: json["description"],
    productNum: json["productNum"],
    sellingPrice: json["sellingPrice"],
    purchasePrice: json["purchasePrice"],
    wholesalePrice: json["wholesalePrice"],
    installmentPrice: json["installmentPrice"],
    productCode: json["productCode"],
    sectionId: '${json["sectionId"]}',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "productNum": productNum,
    "sellingPrice": sellingPrice,
    "purchasePrice": purchasePrice,
    "wholesalePrice": wholesalePrice,
    "installmentPrice": installmentPrice,
    "productCode": productCode,
    "sectionId": sectionId,
  };
}