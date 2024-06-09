import 'dart:convert';

List<JadwalDokterDaring> JadwalDokterDaringFromJson(String str) =>
    List<JadwalDokterDaring>.from(json.decode(str).map((x) => JadwalDokterDaring.fromJson(x)));

String JadwalDokterDaringToJson(List<JadwalDokterDaring> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JadwalDokterDaring {
  JadwalDokterDaring({
    required this.id,
    required this.hari,
    required this.waktu_mulai,
    required this.waktu_berakhir,
    required this.id_dokter,
    required this.nama, 
  });

  final int id;
  final String hari;
  final String waktu_mulai;
  final String waktu_berakhir;
  final int id_dokter;
  final String nama; 

  factory JadwalDokterDaring.fromJson(Map<String, dynamic> json) => JadwalDokterDaring(
        id: json["id"],
        hari: json["hari"],
        waktu_mulai: json["waktu_mulai"],
        waktu_berakhir: json["waktu_berakhir"],
        id_dokter: json["id_dokter"],
        nama: json["nama_dokter"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "hari": hari,
        "waktu_mulai": waktu_mulai,
        'waktu_berakhir': waktu_berakhir,
        "id_dokter": id_dokter,
        "nama_dokter": nama,
      };

}