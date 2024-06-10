import 'dart:convert';

List<Lab> LabFromJson(String str) =>
    List<Lab>.from(json.decode(str).map((x) => Lab.fromJson(x)));

String LabToJson(List<Lab> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Lab {
  Lab({
    required this.id,
    required this.nama,
    required this.kategori,
    required this.deskripsi,
    required this.harga,
  });

  final int id;
  final String nama;
  final String kategori;
  final String deskripsi;
  final String harga;

  factory Lab.fromJson(Map<String, dynamic> json) => Lab(
        id: json["id"],
        nama: json["nama"],
        kategori: json["kategori"],
        harga: json["harga"],
        deskripsi: json["deskripsi"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "kategori": kategori,
        'harga': harga,
        "deskripsi": deskripsi,
      };
}
