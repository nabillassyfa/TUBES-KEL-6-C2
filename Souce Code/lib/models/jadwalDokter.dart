import 'dart:convert';

import 'package:flutter/material.dart';

List<JadwalDokter> JadwalDokterFromJson(String str) =>
    List<JadwalDokter>.from(json.decode(str).map((x) => JadwalDokter.fromJson(x)));

String JadwalDokterToJson(List<JadwalDokter> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JadwalDokter {
  JadwalDokter({
    required this.id,
    required this.hari,
    required this.waktu_mulai,
    required this.waktu_berakhir,
    required this.id_dokter,
    required this.id_RS,
  });

  final int id;
  final String hari;
  final String waktu_mulai;
  final String waktu_berakhir;
  final int id_dokter;
  final int id_RS;

  factory JadwalDokter.fromJson(Map<String, dynamic> json) => JadwalDokter(
        id: json["id"],
        hari: json["hari"],
        waktu_mulai: json["waktu_mulai"],
        waktu_berakhir: json["waktu_berakhir"],
        id_dokter: json["id_dokter"],
        id_RS: json["id_RS"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "hari": hari,
        "waktu_mulai": waktu_mulai,
        'waktu_berakhir': waktu_berakhir,
        "id_dokter": id_dokter,
        "id_RS": id_RS,
      };
}
