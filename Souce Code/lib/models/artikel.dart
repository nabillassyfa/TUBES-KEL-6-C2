import 'dart:convert';

List<Artikel> ArtikelFromJson(String str) =>
    List<Artikel>.from(json.decode(str).map((x) => Artikel.fromJson(x)));

String ArtikelToJson(List<Artikel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Artikel {
  Artikel({
    required this.id,
    required this.judul,
    required this.abstrak,
    required this.hasil,
    required this.kesimpulan,
    required this.penerbit,
    required this.penulis,
    required this.tanggal,
    required this.image,
  });

  final int id;
  final String judul;
  final String abstrak;
  final String hasil;
  final String kesimpulan;
  final String penerbit;
  final String penulis;
  final DateTime tanggal;
  final String image;

  factory Artikel.fromJson(Map<String, dynamic> json) => Artikel(
        id: json["id"],
        judul: json["judul"],
        abstrak: json["abstrak"],
        kesimpulan: json["kesimpulan"],
        hasil: json["hasil"],
        penerbit: json["penerbit"],
        penulis: json["penulis"],
        tanggal: DateTime.parse(json["tanggal"]), // PaArtikeling string tanggal menjadi DateTime
        image: json["img"], // Menggunakan kunci "img" sebagai pengganti "image"
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "judul": judul,
        "abstrak": abstrak,
        'kesimpulan': kesimpulan,
        "hasil": hasil,
        "penerbit": penerbit,
        "penulis": penulis,
        "tanggal": tanggal.toIso8601String(), // MengonveArtikeli DateTime ke string ISO 8601
        "img": image, // Menggunakan kunci "img" sebagai pengganti "image"
      };
}
