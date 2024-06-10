import 'dart:convert';

List<JadwalVideoCall> JadwalVideoCallFromJson(String str) =>
    List<JadwalVideoCall>.from(json.decode(str).map((x) => JadwalVideoCall.fromJson(x)));

String JadwalVideoCallToJson(List<JadwalVideoCall> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JadwalVideoCall {
  JadwalVideoCall({
    required this.id,
    required this.id_user,
    required this.id_jadwal_dokter_online,
    required this.tanggal,
    required this.durasi,
    required this.id_dokter,
    required this.nama_dokter,
    required this.nama_spesialis,
    required this.waktu_mulai,
    required this.waktu_berakhir,
    required this.link_video_call
  });

  final int id;
  final int id_user;
  final int id_jadwal_dokter_online;
  final DateTime tanggal;
  final int durasi;
  final int id_dokter;
  final String nama_dokter;
  final String nama_spesialis;
  final String waktu_mulai;
  final String waktu_berakhir;
  final String link_video_call;

  factory JadwalVideoCall.fromJson(Map<String, dynamic> json) => JadwalVideoCall(
        id: json["id"],
        id_user: json["id_user"],
        id_jadwal_dokter_online: json["id_jadwal_dokter_online"],
        tanggal: DateTime.parse(json["tanggal"]),
        durasi: json["durasi"],
        id_dokter: json["id_dokter"],
        nama_dokter: json["nama_dokter"],
        nama_spesialis: json["nama_spesialis"],
        waktu_mulai: json["waktu_mulai"],
        waktu_berakhir: json["waktu_berakhir"],
        link_video_call: json["link_video_call"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_user": id_user,
        "id_jadwal_dokter_online": id_jadwal_dokter_online,
        "tanggal": tanggal.toIso8601String(),
        "durasi": durasi,
      };
}
