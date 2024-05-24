import 'dart:convert';

List<Spesialis> SpesialisFromJson(String str) =>
    List<Spesialis>.from(json.decode(str).map((x) => Spesialis.fromJson(x)));

String SpesialisToJson(List<Spesialis> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Spesialis {
  Spesialis({
    required this.id,
    required this.nama,
    required this.icon,
  });

  final int id;
  final String nama;
  final String icon;

  String get imageUrl => 'http://127.0.0.1:8000/spesialis_icon/$id';


  factory Spesialis.fromJson(Map<String, dynamic> json) => Spesialis(
        id: json["id"],
        nama: json["spesialis"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "spesialis": nama,
        "icon": icon,
      };
}
