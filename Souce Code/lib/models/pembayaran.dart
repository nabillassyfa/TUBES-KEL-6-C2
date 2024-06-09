import 'dart:convert';

List<Pembayaran> PembayaranFromJson(String str) =>
    List<Pembayaran>.from(json.decode(str).map((x) => Pembayaran.fromJson(x)));

String PembayaranToJson(List<Pembayaran> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pembayaran {
  Pembayaran({
    required this.id,
    required this.id_user,
    required this.waktu_pembayaran,
    required this.metode_pembayaran,
    required this.total_pembayaran,
    required this.status,
    required this.item,
  });

  final int id;
  final int id_user;
  final String waktu_pembayaran;
  final String metode_pembayaran;
  final int total_pembayaran;
  final String status;
  final String item;

  factory Pembayaran.fromJson(Map<String, dynamic> json) => Pembayaran(
        id: json["id"],
        id_user: json["id_user"],
        waktu_pembayaran: json["waktu_pembayaran"],
        metode_pembayaran: json["metode_pembayaran"],
        total_pembayaran: json["total_pembayaran"],
        status: json["status"],
        item: json["item"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_user": id_user,
        "waktu_pembayaran": waktu_pembayaran,
        "metode_pembayaran": metode_pembayaran,
        "total_pembayaran": total_pembayaran,
        "status": status,
        "item": item,
      };
}
