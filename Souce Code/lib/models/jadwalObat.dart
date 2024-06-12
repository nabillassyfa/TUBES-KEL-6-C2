import 'dart:convert';

List<JadwalObat> JadwalObatFromJson(String str) =>
    List<JadwalObat>.from(json.decode(str).map((x) => JadwalObat.fromJson(x)));

String JadwalObatToJson(List<JadwalObat> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JadwalObat {
  JadwalObat({
    required this.id,
    required this.id_obat,
    required this.id_user,
    required this.nama_obat,
    required this.kondisi_makan,
    required this.takaran,
    required this.waktu_konsumsi,
  });

  final int id;
  final int id_obat;
  final int id_user;
  final String nama_obat;
  final String kondisi_makan;
  final String takaran;
  final List<dynamic> waktu_konsumsi;

  factory JadwalObat.fromJson(Map<String, dynamic> json) => JadwalObat(
        id: json["id"],
        id_obat: json["id_obat"],
        id_user: json["id_user"],
        nama_obat: json["nama_obat"],
        kondisi_makan: json["kondisi_makan"],
        takaran: json["takaran"],
        waktu_konsumsi: json["waktu_konsumsi"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_obat": id_obat,
        "kondisi_makan": kondisi_makan,
        "takaran": takaran,
        "id_user": id_user,
      };
}
