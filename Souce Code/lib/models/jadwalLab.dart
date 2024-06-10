import 'dart:convert';

List<JadwalLab> JadwalLabFromJson(String str) =>
    List<JadwalLab>.from(json.decode(str).map((x) => JadwalLab.fromJson(x)));

String JadwalLabToJson(List<JadwalLab> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JadwalLab {
  JadwalLab({
    required this.id,
    required this.id_RS,
    required this.nama_lab,
    required this.kategori,
    required this.harga,
    required this.waktu_mulai,
    required this.waktu_berakhir,
    required this.deskripsi,
    required this.hari,
  });

  final int id;
  final int id_RS;
  final String nama_lab;
  final String kategori;
  final String harga;
  final String deskripsi;
  final String hari;
  final String waktu_mulai;
  final String waktu_berakhir;

  factory JadwalLab.fromJson(Map<String, dynamic> json) => JadwalLab(
        id: json["id"],
        id_RS: json["id_RS"],
        nama_lab: json["nama_lab"],
        kategori: json["kategori"],
        harga: json["harga"],
        deskripsi: json["deskripsi"],
        hari: json["hari"],
        waktu_mulai: json["waktu_mulai"],
        waktu_berakhir: json["waktu_berakhir"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_RS": id_RS,
        "hari": hari,
        "waktu_mulai": waktu_mulai,
        'waktu_berakhir': waktu_berakhir,
        "nama_lab": nama_lab,
        "kategori": kategori,
        "harga": harga,
        "deskripsi": deskripsi,
      };
}
