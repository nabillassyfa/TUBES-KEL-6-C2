import 'dart:convert';

List<Dokter> DokterFromJson(String str) =>
    List<Dokter>.from(json.decode(str).map((x) => Dokter.fromJson(x)));

String DokterToJson(List<Dokter> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Dokter {
  Dokter({
    required this.id,
    required this.nama,
    required this.spesialis,
    required this.informasi,
    required this.pengalaman,
    required this.foto,
    required this.nama_spesialis,
  });

  final int id;
  final String nama;
  final String spesialis;
  final String informasi;
  final String pengalaman;
  final String foto;
  final String nama_spesialis;

  String get imageUrl => 'http://127.0.0.1:8000/dokter_image/$id';


  factory Dokter.fromJson(Map<String, dynamic> json) => Dokter(
        id: json["id"],
        nama: json["nama"],
        spesialis: json["spesialis"],
        pengalaman: json["pengalaman"],
        informasi: json["informasi"],
        foto: json["foto"],
        nama_spesialis: json["nama_spesialis"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "spesialis": spesialis,
        'pengalaman' : pengalaman,
        "informasi": informasi,
        "foto": foto,
        "nama_spesialis" : spesialis,
      };
}
