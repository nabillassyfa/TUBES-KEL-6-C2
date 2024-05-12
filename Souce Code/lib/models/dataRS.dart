import 'dart:convert';

List<RS> RSFromJson(String str) =>
    List<RS>.from(json.decode(str).map((x) => RS.fromJson(x)));

String RSToJson(List<RS> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RS {
  RS({
    required this.id,
    required this.nama,
    required this.deskripsi,
    required this.lokasi,
    required this.fasilitas,
    required this.image,
  });

  final int id;
  final String nama;
  final String deskripsi;
  final String lokasi;
  final String fasilitas;
  final String image;

  String get imageUrl => 'http://127.0.0.1:8000/RS_image/$id';


  factory RS.fromJson(Map<String, dynamic> json) => RS(
        id: json["id"],
        nama: json["nama"],
        deskripsi: json["deskripsi"],
        fasilitas: json["fasilitas"],
        lokasi: json["lokasi"],
        image: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "deskripsi": deskripsi,
        'fasilitas' : fasilitas,
        "lokasi": lokasi,
        "img": image,
      };
}
