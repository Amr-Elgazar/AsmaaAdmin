import 'dart:convert';

List<Sections> sectionsFromJson(String str) => List<Sections>.from(json.decode(str).map((x) => Sections.fromJson(x)));

String sectionsToJson(List<Sections> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Sections {
  Sections({
  required this.id,
  required this.name,
  });

  String id;
  String name;

  factory Sections.fromJson(Map<String, dynamic> json) => Sections(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}