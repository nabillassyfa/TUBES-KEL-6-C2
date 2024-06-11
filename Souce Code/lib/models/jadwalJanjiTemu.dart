import 'dart:convert';

List<JadwalJanjiTemu> JadwalJanjiTemuFromJson(String str) =>
    List<JadwalJanjiTemu>.from(json.decode(str).map((x) => JadwalJanjiTemu.fromJson(x)));

String JadwalJanjiTemuToJson(List<JadwalJanjiTemu> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JadwalJanjiTemu {
  JadwalJanjiTemu({
    required this.id,
    required this.id_user,
    required this.id_jadwal_dokter,
    required this.tanggal,
    required this.durasi,
    required this.id_dokter,
    required this.nama_dokter,
    required this.nama_spesialis,
    required this.nama_RS,
    required this.waktu_mulai,
    required this.waktu_berakhir,
  });

  final int id;
  final int id_user;
  final int id_jadwal_dokter;
  final DateTime tanggal;
  final int durasi;
  final int id_dokter;
  final String nama_dokter;
  final String nama_spesialis;
  final String nama_RS;
  final String waktu_mulai;
  final String waktu_berakhir;

  String get imageUrl => 'http://127.0.0.1:8000/dokter_image/$id_dokter';

  factory JadwalJanjiTemu.fromJson(Map<String, dynamic> json) => JadwalJanjiTemu(
        id: json["id"],
        id_user: json["id_user"],
        id_jadwal_dokter: json["id_jadwal_dokter"],
        tanggal: DateTime.parse(json["tanggal"]),
        durasi: json["durasi"],
        id_dokter: json["id_dokter"],
        nama_dokter: json["nama_dokter"],
        nama_spesialis: json["nama_spesialis"],
        nama_RS: json["nama_RS"],
        waktu_mulai: json["waktu_mulai"],
        waktu_berakhir: json["waktu_berakhir"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_user": id_user,
        "id_jadwal_dokter": id_jadwal_dokter,
        "tanggal": tanggal.toIso8601String(),
        "durasi": durasi,
      };
}
