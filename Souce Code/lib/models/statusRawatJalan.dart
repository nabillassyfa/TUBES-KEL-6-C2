import 'dart:convert';

List<StatusRawatJalan> statusRawatJalanFromJson(String str) =>
    List<StatusRawatJalan>.from(json.decode(str).map((x) => StatusRawatJalan.fromJson(x)));

String statusRawatJalanToJson(List<StatusRawatJalan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StatusRawatJalan {
  StatusRawatJalan({
    required this.id_status,
    required this.id_user,
    required this.keterangan_status,
    required this.deskripsi,
    required this.nama_user,
  });

  final int id_status;
  final int id_user;
  final String keterangan_status;
  final String deskripsi;
  final String nama_user;

  factory StatusRawatJalan.fromJson(Map<String, dynamic> json) => StatusRawatJalan(
        id_status: json["id_status"],
        id_user: json["id_user"],
        keterangan_status: json["keterangan_status"],
        deskripsi: json["deskripsi"],
        nama_user: json["nama_user"],
      );

  Map<String, dynamic> toJson() => {
        "id_status": id_status,
        "id_user": id_user,
        "keterangan_status": keterangan_status,
        "deskripsi": deskripsi,
        "nama_user": nama_user,
      };
}
