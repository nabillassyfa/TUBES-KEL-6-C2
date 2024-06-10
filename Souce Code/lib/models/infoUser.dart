import 'dart:convert';
import 'package:intl/intl.dart';

List<InfoUser> infoUserFromJson(String str) =>
    List<InfoUser>.from(json.decode(str).map((x) => InfoUser.fromJson(x)));

String infoUserToJson(List<InfoUser> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InfoUser {
  InfoUser({
    required this.id,
    required this.jenis_kelamin,
    required this.umur,
    required this.berat_badan,
    required this.tanggal_lahir,
    required this.tinggi_badan,
    required this.golongan_darah,
    required this.id_user,
    required this.alamat,
    required this.foto,
    this.nama_lengkap,
    this.username,
    this.no_telp,
    this.email
  });

  final int id;
  final String jenis_kelamin;
  final int umur;
  final double berat_badan;
  final DateTime tanggal_lahir;
  final double tinggi_badan;
  final String golongan_darah;
  final int id_user;
  final String alamat;
  final String foto;
  String? nama_lengkap;
  String? username;
  String? no_telp;
  String? email;

  factory InfoUser.fromJson(Map<String, dynamic> json) {
    print("Parsing JSON: $json");
    return InfoUser(
      id: json["id"],
      jenis_kelamin: json["jenis_kelamin"],
      umur: json["umur"],
      berat_badan: json["berat_badan"].toDouble(),
      tanggal_lahir: DateTime.parse(json["tanggal_lahir"]),
      tinggi_badan: json["tinggi_badan"].toDouble(),
      golongan_darah: json["golongan_darah"],
      id_user: json["id_user"],
      alamat: json["alamat"],
      foto: json["foto"],
      nama_lengkap: json["nama_lengkap"],
      username: json["username"],
      no_telp: json["no_telp"],
      email: json["email"],
    );
  }

  String get imageUrl => 'http://127.0.0.1:8000/user_image/$id';

  Map<String, dynamic> toJson() => {
        "id": id,
        "jenis_kelamin": jenis_kelamin,
        "umur": umur,
        "berat_badan": berat_badan,
        "tanggal_lahir": DateFormat('yyyy-MM-dd').format(tanggal_lahir),
        "tinggi_badan": tinggi_badan,
        "golongan_darah": golongan_darah,
        "id_user": id_user,
        "alamat": alamat,
        "foto": foto,
      };
}
