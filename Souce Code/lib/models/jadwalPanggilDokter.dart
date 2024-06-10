import 'dart:convert';

List<JadwalPanggilDokter> JadwalPanggilDokterFromJson(String str) =>
    List<JadwalPanggilDokter>.from(json.decode(str).map((x) => JadwalPanggilDokter.fromJson(x)));

String JadwalPanggilDokterToJson(List<JadwalPanggilDokter> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JadwalPanggilDokter {
  JadwalPanggilDokter({
    required this.id,
    required this.id_user,
    required this.tanggal,
    required this.id_jadwal_dokter_panggil_dokter,
    required this.alamat,
    required this.id_dokter,
    required this.nama_dokter,
    required this.nama_spesialis,
    required this.waktu_mulai,
    required this.waktu_berakhir,
  });

  final int id;
  final int id_user;
  final int id_jadwal_dokter_panggil_dokter;
  final DateTime tanggal;
  final String alamat;
  final int id_dokter;
  final String nama_dokter;
  final String nama_spesialis;
  final String waktu_mulai;
  final String waktu_berakhir;

  factory JadwalPanggilDokter.fromJson(Map<String, dynamic> json) => JadwalPanggilDokter(
        id: json["id"],
        id_user: json["id_user"],
        tanggal: DateTime.parse(json["tanggal"]),
        id_jadwal_dokter_panggil_dokter: json["id_jadwal_dokter_panggil_dokter"],
        alamat: json["alamat"],
        id_dokter: json["id_dokter"],
        nama_dokter: json["nama_dokter"],
        nama_spesialis: json["nama_spesialis"],
        waktu_mulai: json["waktu_mulai"],
        waktu_berakhir: json["waktu_berakhir"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_user": id_user,
        "tanggal": tanggal.toIso8601String(),
        "id_jadwal_dokter_panggil_dokter": id_jadwal_dokter_panggil_dokter,
        "alamat": alamat,
      };
}
