import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tp2/Fitur/informasi_dokter_pilih_rs.dart';
import '../models/spesialis.dart';

class SpesialisWidget extends StatelessWidget {
  const SpesialisWidget({
    Key? key,
    required this.data,
  }) : super(key: key);
  final Spesialis data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SpecializationPageSelectRS(
            idSpesialis: data.id,
            dataSpesialis: data,
          );
        }));
      },
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(data.imageUrl),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 10.0),
            Expanded(
              child: Text(
                data.nama,
                style: const TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
