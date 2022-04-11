// To parse this JSON data, do
//
//     final allInstalments = allInstalmentsFromJson(jsonString);

import 'dart:convert';

AllInstalments allInstalmentsFromJson(String str) => AllInstalments.fromJson(json.decode(str));

String allInstalmentsToJson(AllInstalments data) => json.encode(data.toJson());

class AllInstalments {
  AllInstalments({
  required this.installments,
  });

  List<Installment> installments;

  factory AllInstalments.fromJson(Map<String, dynamic> json) => AllInstalments(
    installments: List<Installment>.from(json["installments"].map((x) => Installment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "installments": List<dynamic>.from(installments.map((x) => x.toJson())),
  };
}

class Installment {
  Installment({
  required this.id,
  required this.amountPaid,
  required this.orderId,
  required this.createdAt,
  });

  String id;
  String amountPaid;
  String orderId;
  String createdAt;

  factory Installment.fromJson(Map<String, dynamic> json) => Installment(
    id: json["id"],
    amountPaid: json["amountPaid"],
    orderId: json["orderId"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "amountPaid": amountPaid,
    "orderId": orderId,
    "created_at": createdAt,
  };
}
