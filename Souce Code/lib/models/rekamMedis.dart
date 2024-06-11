import 'dart:convert';

List<RekamMedis> RekamMedisFromJson(String str) =>
    List<RekamMedis>.from(json.decode(str).map((x) => RekamMedis.fromJson(x)));

String RekamMedisToJson(List<RekamMedis> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
    
class RekamMedis {
  RekamMedis({
    required this.id,
    required this.keterangan,
    required this.catatan_dokter,
    required this.obat,
    required this.dokter_nama,
    required this.user_nama,
    required this.tanggal,
    required this.id_dokter,
    required this.id_user,
    required this.spesialis,
  });

  final int id;
  final String keterangan;
  final String catatan_dokter;
  final String obat;
  final String dokter_nama;
  final String user_nama;
  final DateTime tanggal;
  final int id_dokter;
  final int id_user;
  final String spesialis;

  factory RekamMedis.fromJson(Map<String, dynamic> json) => RekamMedis(
        id: json["id"],
        keterangan: json["keterangan"],
        catatan_dokter: json["catatan_dokter"],
        dokter_nama: json["dokter_nama"],
        obat: json["obat"],
        user_nama: json["user_nama"],
        tanggal: DateTime.parse(json["tanggal"]),
        id_dokter: json["id_dokter"],
        id_user: json["id_user"],
        spesialis: json["spesialis"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "keterangan": keterangan,
        "catatan_dokter": catatan_dokter,
        "obat": obat,
        "tanggal": tanggal.toIso8601String(),
        "id_dokter": id_dokter,
        "id_user": id_user,
      };
}


