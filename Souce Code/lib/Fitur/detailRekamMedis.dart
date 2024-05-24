import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../models/rekamMedis.dart';
import 'package:intl/intl.dart';


class DetailRekamMedis extends StatefulWidget {
  const DetailRekamMedis({
    Key? key,
    required this.data,
  }) : super(key: key);

  final RekamMedis data;

  @override
  State<DetailRekamMedis> createState() => _DetailRekamMedisState();
}

class _DetailRekamMedisState extends State<DetailRekamMedis> {
  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormatter = DateFormat('yyyy-MM-dd'); 
    final DateFormat timeFormatter = DateFormat('HH:mm:ss');

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_circle_left_outlined,
            size: 40,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              'Rekam Medis',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold
              ),
            ),
            const Text(
              'Lihat rekam medis anda secara detail dan lengkap',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
              ),
              maxLines: 2, // Batas jumlah baris
              overflow: TextOverflow.ellipsis, // Menggunakan elipsis (...) jika teks melebihi batas
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color.fromARGB(250, 206, 222, 245), // Latar belakang chat berwarna biru
                border: Border.all(
                  color: Colors.grey,
                  width: 2
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(
                  color: Colors.grey.withOpacity(0.8), // Warna bayangan
                  blurRadius: 2,
                  spreadRadius: 2,
                  offset: Offset(0, 2),
                )]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 200,
                    child: Text(
                      widget.data.dokter_nama,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ), 
                  Text(
                    widget.data.spesialis,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    children: [
                      Spacer(),
                      Text(
                        dateFormatter.format(widget.data.tanggal), //tanggal
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Spacer(),
                      Text(
                        timeFormatter.format(widget.data.tanggal), //waktu
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                        
                  const Text(
                    'Keterangan : ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    width: double.infinity,
                    height: 80,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Text(
                      widget.data.keterangan,
                      // style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 10,),
                  const Text(
                    'Obat : ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: double.infinity,
                    height: 80,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Text(
                      widget.data.obat,
                    ),
                  ),
                  SizedBox(height: 15,),
                  const Text(
                    'Catatan dokter : ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: double.infinity,
                    height: 120,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Text(
                      widget.data.catatan_dokter,
                    ),
                  ),
                  
                ],
              )
            ),
            const SizedBox(height: 40,),
            
          ],
        ),
      ),
    );
  }
}