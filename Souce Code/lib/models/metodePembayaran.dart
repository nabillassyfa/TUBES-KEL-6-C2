import 'dart:convert';

List<MetodePembayaran> MetodePembayaranFromJson(String str) =>
    List<MetodePembayaran>.from(json.decode(str).map((x) => MetodePembayaran.fromJson(x)));

String MetodePembayaranToJson(List<MetodePembayaran> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MetodePembayaran {
  MetodePembayaran({
    required this.id,
    required this.nama_pembayaran,
  });

  final int id;
  final String nama_pembayaran;

  factory MetodePembayaran.fromJson(Map<String, dynamic> json) => MetodePembayaran(
        id: json["id"],
        nama_pembayaran: json["nama_pembayaran"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_pembayaran": nama_pembayaran,
      };
}
