import 'dart:convert';

List<Rating> RatingFromJson(String str) =>
    List<Rating>.from(json.decode(str).map((x) => Rating.fromJson(x)));

String RatingToJson(List<Rating> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Rating {
  Rating({
    required this.id,
    required this.pesan,
    required this.rating,
    required this.id_user,
    required this.id_dokter,
    required this.nama_dokter,
    required this.nama_user,
  });

  final int id;
  final String pesan;
  final double rating;
  final int id_user;
  final int id_dokter;
  final String nama_dokter;
  final String nama_user;

 String get imageUrl => 'http://127.0.0.1:8000/user_image/$id_user';
  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        id: json["id"],
        pesan: json["pesan"],
        rating: json["rating"],
        id_dokter: json["id_dokter"],
        id_user: json["id_user"],
        nama_dokter: json["nama_dokter"],
        nama_user: json["nama_user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pesan": pesan,
        "rating": rating,
        'id_dokter' : id_dokter,
        "id_user": id_user,
        "nama_dokter": nama_dokter,
        "nama_user" : nama_user,
      };
}
