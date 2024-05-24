import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tp2/Fitur/detailRekamMedis.dart';
import '../models/rekamMedis.dart';
import 'package:intl/intl.dart';

class RMWidget extends StatelessWidget {
  const RMWidget({
    Key? key,
    required this.data,
  }) : super(key: key);
  final RekamMedis data;

   @override
  Widget build(BuildContext context) {
    final DateFormat dateFormatter = DateFormat('yyyy-MM-dd'); 
    final DateFormat timeFormatter = DateFormat('HH:mm:ss');
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DetailRekamMedis(
            data: data,
          );
        }));
      },
    child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey),
          boxShadow: [BoxShadow(
            color: Colors.grey.withOpacity(0.8), // Warna bayangan
            blurRadius: 2,
            spreadRadius: 2,
            offset: Offset(0, 2),
          )]
        ),
        
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 50,
              child: Text(
                data.spesialis, //spesialis
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 8, right: 8),
              width: 1.5, // Lebar garis vertikal
              height: 40, // Tinggi garis vertikal
              color: Color.fromARGB(255, 1, 101, 252), // Warna garis vertikal
            ),
            Flexible(
              child: Text(
                data.dokter_nama,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12
                  ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 8, right: 8),
              width: 1.5, // Lebar garis vertikal
              height: 40, // Tinggi garis vertikal
              color: Color.fromARGB(255, 1, 101, 252), // Warna garis vertikal
            ),
            
            Flexible(
              child: Column(
                children: [
                  Text(
                    dateFormatter.format(data.tanggal), //tanggal
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12
                    ),
                  ),
                  Text(
                    timeFormatter.format(data.tanggal), //waktu
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color.fromARGB(255, 1, 101, 252),
            ),
          ],
        ),
      ),
    );
  }

}
