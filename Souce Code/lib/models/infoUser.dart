import 'dart:convert';
import 'package:intl/intl.dart';

List<InfoUser> infoUserFromJson(String str) =>
    List<InfoUser>.from(json.decode(str).map((x) => InfoUser.fromJson(x)));

String infoUserToJson(List<InfoUser> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InfoUser {
  InfoUser({
    required this.id,
    this.jenis_kelamin,
    this.umur,
    this.berat_badan,
    this.tanggal_lahir,
    this.tinggi_badan,
    this.golongan_darah,
    required this.id_user,
    required this.alamat,
    required this.nama_lengkap,
    required this.username,
    required this.no_telp,
  });

  final int id;
  final String? jenis_kelamin;
  final int? umur;
  final int? berat_badan;
  final DateTime? tanggal_lahir;
  final int? tinggi_badan;
  final String? golongan_darah;
  final int id_user;
  final String alamat;
  final String nama_lengkap;
  final String username;
  final String no_telp;

  factory InfoUser.fromJson(Map<String, dynamic> json) {
    print("Parsing JSON: $json");
    return InfoUser(
      id: json["id"],
      jenis_kelamin: json["jenis_kelamin"] as String?,
      umur: json["umur"] as int?,
      berat_badan: json["berat_badan"] as int?,
      tanggal_lahir: json["tanggal_lahir"] != null ? DateTime.parse(json["tanggal_lahir"]) : null,
      tinggi_badan: json["tinggi_badan"] as int?,
      golongan_darah: json["golongan_darah"] as String?,
      id_user: json["id_user"],
      alamat: json["alamat"],
      nama_lengkap: json["nama_lengkap"],
      username: json["username"],
      no_telp: json["no_telp"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "jenis_kelamin": jenis_kelamin,
        "umur": umur,
        "berat_badan": berat_badan,
        "tanggal_lahir": tanggal_lahir != null ? DateFormat('yyyy-MM-dd').format(tanggal_lahir!) : null,
        "tinggi_badan": tinggi_badan,
        "golongan_darah": golongan_darah,
        "id_user": id_user,
        "alamat": alamat,
        "nama_lengkap": nama_lengkap,
        "username": username,
        "no_telp": no_telp,
      };
}
