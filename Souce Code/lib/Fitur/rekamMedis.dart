import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tp2/Fitur/detailRekamMedis.dart';


class RekamMedis extends StatefulWidget {
  const RekamMedis({super.key});

  @override
  State<RekamMedis> createState() => _RekamMedisState();
}

class _RekamMedisState extends State<RekamMedis> {
  List<RekamMed> rekamMed = [
    RekamMed(spesialis: "Spesialis Jiwa", dokter: "dr. Muhammad Rifky Afandi, SpKj", tanggal: "Selasa, 13/02/2024", waktu: "08.00"),
    RekamMed(spesialis: "Spesialsi THT", dokter: "dr. Nabilla Assyfa, SpTHT", tanggal: "Rabu, 14/02/2024", waktu: "12.00"),
    RekamMed(spesialis: "Spesialis Anak", dokter: "dr. Muhammad Tio Ariyanto, Sp.A", tanggal: "Kamis, 15/02/2024", waktu: "16.00"),
    RekamMed(spesialis: "Spesialis Paru", dokter: "dr. Wildan Hafizh, Sp.P", tanggal: "Jumat, 16/02/2024", waktu: "16.00"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Center(
              child: Column(
                children: [
                  const Text(
                    'Rekam Medis',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(
                    width: 300,
                    child: Text(
                      'Lihat rekam medis anda setelah melakukan konsultasi dengan dokter',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      maxLines: 2, // Batas jumlah baris
                      overflow: TextOverflow.ellipsis, // Menggunakan elipsis (...) jika teks melebihi batas
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.filter_list_alt),
                              Text('Filter', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),)
                            ],
                          ),
                        ),
                        const SizedBox(width: 10,),
                        InkWell(
                          onTap: () {
                            
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.sort),
                              Text('Urutkan', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 500,
                    margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    padding: const EdgeInsets.all(8),
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
                    child: ListView.builder(
                      itemCount: rekamMed.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index){
                        return RekamMedList(
                          index: index,
                          spesialis: rekamMed[index].spesialis,
                          dokter: rekamMed[index].dokter,
                          tanggal: rekamMed[index].tanggal,
                          waktu: rekamMed[index].waktu,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
class RekamMed {
  String spesialis;
  String dokter;
  String tanggal;
  String waktu;

  RekamMed({required this.spesialis, required this.dokter, required this.tanggal, required this.waktu});
}
// ignore: must_be_immutable
class RekamMedList extends StatefulWidget{
  String spesialis;
  String dokter;
  String tanggal;
  String waktu;
  int index;

  RekamMedList({super.key, required this.index, required this.spesialis, required this.dokter, required this.tanggal, required this.waktu});

  @override
  _RekamMedListState createState() => _RekamMedListState();
}
class _RekamMedListState extends State<RekamMedList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailRekamMedis(
              index: widget.index,
              spesialis: widget.spesialis,
              dokter: widget.dokter,
              tanggal: widget.tanggal,
              waktu: widget.waktu,
            ),
          ),
        );
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
                widget.spesialis,
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
                widget.dokter,
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
                    widget.tanggal,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12
                    ),
                  ),
                  Text(
                    widget.waktu,
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
