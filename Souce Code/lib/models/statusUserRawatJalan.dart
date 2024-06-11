import 'dart:convert';

List<StatusUserRawatJalan> StatusUserRawatJalanFromJson(String str) =>
    List<StatusUserRawatJalan>.from(json.decode(str).map((x) => StatusUserRawatJalan.fromJson(x)));

String StatusUserRawatJalanToJson(List<StatusUserRawatJalan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StatusUserRawatJalan {
  StatusUserRawatJalan({
    required this.id,
    required this.id_janji_temu,
    required this.id_statusRawatJalan,
    required this.keterangan_status,
    required this.deskripsi,
  });

  final int id;
  final int id_janji_temu;
  final int id_statusRawatJalan;
  final String keterangan_status;
  final String deskripsi;

  factory StatusUserRawatJalan.fromJson(Map<String, dynamic> json) => StatusUserRawatJalan(
        id: json["id"],
        id_janji_temu: json["id_janji_temu"],
        id_statusRawatJalan: json["id_statusRawatJalan"],
        keterangan_status: json["keterangan_status"],
        deskripsi: json["deskripsi"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_janji_temu": id_janji_temu,
        "id_statusRawatJalan": id_statusRawatJalan,
      };
}
