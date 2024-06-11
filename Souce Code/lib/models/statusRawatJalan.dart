import 'dart:convert';

List<StatusRawatJalan> statusRawatJalanFromJson(String str) =>
    List<StatusRawatJalan>.from(json.decode(str).map((x) => StatusRawatJalan.fromJson(x)));

String statusRawatJalanToJson(List<StatusRawatJalan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StatusRawatJalan {
  StatusRawatJalan({
    required this.id_status,
    required this.keterangan_status,
    required this.deskripsi,
  });

  final int id_status;
  final String keterangan_status;
  final String deskripsi;

  factory StatusRawatJalan.fromJson(Map<String, dynamic> json) => StatusRawatJalan(
        id_status: json["id_status"],
        keterangan_status: json["keterangan_status"],
        deskripsi: json["deskripsi"],
      );

  Map<String, dynamic> toJson() => {
        "id_status": id_status,
        "keterangan_status": keterangan_status,
        "deskripsi": deskripsi,
      };
}
