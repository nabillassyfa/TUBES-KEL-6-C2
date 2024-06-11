import 'dart:convert';

List<Obat> ObatFromJson(String str) =>
    List<Obat>.from(json.decode(str).map((x) => Obat.fromJson(x)));

String ObatToJson(List<Obat> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Obat {
  Obat({
    required this.id,
    required this.nama,
    required this.harga,
    required this.keterangan,
  });

  final int id;
  final String nama;
  final int harga;
  final String keterangan;

  factory Obat.fromJson(Map<String, dynamic> json) => Obat(
        id: json["id"],
        nama: json["nama"],
        harga: json["harga"],
        keterangan: json["keterangan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "harga": harga,
        "keterangan": keterangan,
      };
}
