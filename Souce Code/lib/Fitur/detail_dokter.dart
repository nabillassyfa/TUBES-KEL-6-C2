import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tp2/Fitur/panggilDokterAfter.dart';
import 'package:tp2/provider/p_jadwalDokter.dart';
import 'lihat_review.dart';
import 'beri_review.dart';
import 'buatJanjiKonsulAfter.dart';
import 'buatJanjiTemuAfter.dart';
import '../models/dokter.dart';

class DetailDokter extends StatefulWidget {
  final Dokter dokter;

  DetailDokter({required this.dokter});

  @override
  State<DetailDokter> createState() => DetailDokterState();
}

class DetailDokterState extends State<DetailDokter> {
  @override
  void initState() {
    super.initState();
    // Panggil method untuk mengambil data jadwal dokter
    final jadwalDokterProvider =
        Provider.of<JadwalDokterProvider>(context, listen: false);
    jadwalDokterProvider.getdataJadwalDokterByDokterRS(
        widget.dokter.id, widget.dokter.id_rs);

    final jadwalDokterOnlineProvider =
        Provider.of<JadwalDokterProvider>(context, listen: false);
    jadwalDokterProvider.getdataJadwalDokterByDokter(widget.dokter.id);

    final jadwalDokterPanggilDokterProvider =
        Provider.of<JadwalDokterProvider>(context, listen: false);
    jadwalDokterProvider.getdataJadwalPanggilDokterByDokter(widget.dokter.id);
  }

  Widget build(BuildContext context) {
    final dokter = widget.dokter;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Dokter'),
      ),
      body: SingleChildScrollView(
        child: Expanded(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Color(0xffd3e6ff),
                  border: Border.all(
                    color: const Color(0xff0165fc),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  dokter.imageUrl,
                                  width: 80.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 16.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      dokter.nama,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.medical_services,
                                          size: 16.0,
                                          color: Color(0xff0165fc),
                                        ),
                                        SizedBox(width: 4.0),
                                        Text(
                                          dokter.namaSpesialis,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          size: 16.0,
                                          color: Color(0xff0165fc),
                                        ),
                                        SizedBox(width: 4.0),
                                        Text(
                                          '${dokter.pengalaman} Thn Pengalaman',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ],
                                    )
                                    // SizedBox(height: 8.0),
                                    // Text(
                                    //   '${dokter.hospitalAddress}',
                                    //   style: TextStyle(
                                    //     fontSize: 16.0,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 16.0),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '4.5' + '  |',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 4.0),
                                  Icon(Icons.star, color: Colors.yellow),
                                  SizedBox(width: 4.0),
                                  Icon(Icons.star, color: Colors.yellow),
                                  SizedBox(width: 4.0),
                                  Icon(Icons.star, color: Colors.yellow),
                                  SizedBox(width: 4.0),
                                  Icon(Icons.star, color: Colors.yellow),
                                  SizedBox(width: 4.0),
                                  Icon(Icons.star, color: Colors.yellow),
                                ],
                              ),
                              VerticalDivider(
                                thickness: 2,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff0165fc),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DoctorReviewsPage(dokter: dokter,)
                                            ),
                                  );
                                },
                                child: Text(
                                  'Lihat Review',
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            'Deskripsi:',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            dokter.informasi,
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Consumer<JadwalDokterProvider>(
                  builder: (context, jadwalDokterProvider, child) {
                if (jadwalDokterProvider.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Color(0xffd3e6ff),
                    border: Border.all(
                      color: const Color(0xff0165fc),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 16.0),
                            Text(
                              'Jadwal Rawat Jalan',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Rp 400.000/sesi',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(height: 16.0),
                            ...jadwalDokterProvider.dataJadwalDokter
                                .map((jadwal) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            jadwal.hari,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0,
                                            ),
                                          ),
                                          Text(
                                            '${jadwal.waktu_mulai} - ${jadwal.waktu_berakhir}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                            SizedBox(height: 16.0),
                            Container(
                              height: 40,
                              width: double.infinity,
                              child: ElevatedButton(
                                child: Text(
                                  'Buat Janji Temu',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff0165fc),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        32.0), // Mengatur sudut melengkung menjadi 10.0
                                  ),
                                ),
                                onPressed: () {
                                  // Navigasi ke halaman baru saat tombol ditekan
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BuatJanjiTemuAfter(
                                              dokter: dokter,
                                            )),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 16.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
              Consumer<JadwalDokterProvider>(
                  builder: (context, jadwalDokterOnlineProvider, child) {
                if (jadwalDokterOnlineProvider.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Color(0xffd3e6ff),
                    border: Border.all(
                      color: const Color(0xff0165fc),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 16.0),
                            Text(
                              'Jadwal Konsultasi Online',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Rp 120.000/sesi',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(height: 16.0),
                            ...jadwalDokterOnlineProvider.dataJadwalDokterDaring
                                .map((jadwal) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            jadwal.hari,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0,
                                            ),
                                          ),
                                          Text(
                                            '${jadwal.waktu_mulai} - ${jadwal.waktu_berakhir}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                            SizedBox(height: 16.0),
                            Container(
                              height: 40,
                              width: double.infinity,
                              child: ElevatedButton(
                                child: Text(
                                  'Buat Janji Konsultasi Online',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff0165fc),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        32.0), // Mengatur sudut melengkung menjadi 10.0
                                  ),
                                ),
                                onPressed: () {
                                  // Navigasi ke halaman baru saat tombol ditekan
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BuatJanjiKonsulAfter(
                                              dokter: dokter,
                                            )),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 16.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
              Consumer<JadwalDokterProvider>(
                  builder: (context, jadwalDokterPanggilDokterProvider, child) {
                if (jadwalDokterPanggilDokterProvider.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Color(0xffd3e6ff),
                    border: Border.all(
                      color: const Color(0xff0165fc),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 16.0),
                            Text(
                              'Jadwal Panggil Dokter',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Rp 200.000/sesi',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(height: 16.0),
                            ...jadwalDokterPanggilDokterProvider
                                .data_Jadwal_dokter_panggil_dokter
                                .map((jadwal) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            jadwal.hari,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0,
                                            ),
                                          ),
                                          Text(
                                            '${jadwal.waktu_mulai} - ${jadwal.waktu_berakhir}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                            SizedBox(height: 16.0),
                            Container(
                              height: 40,
                              width: double.infinity,
                              child: ElevatedButton(
                                child: Text(
                                  'Buat Janji Panggil Dokter',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff0165fc),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        32.0), // Mengatur sudut melengkung menjadi 10.0
                                  ),
                                ),
                                onPressed: () {
                                  // Navigasi ke halaman baru saat tombol ditekan
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            panggilDokterAfter(
                                              dokter: dokter,
                                            )),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 16.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
