import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'lihat_review.dart';
import 'beri_review.dart';
import 'buatJanjiKonsulAfter.dart';
import 'buatJanjiTemuAfter.dart';

class Doctor {
  final String imageUrl;
  final String name;
  final String specialization;
  final int yearsOfExperience;
  final String hospitalAddress;
  final double rating;
  final String description;

  Doctor({
    required this.imageUrl,
    required this.name,
    required this.specialization,
    required this.yearsOfExperience,
    required this.hospitalAddress,
    required this.rating,
    required this.description,
  });
}

class DetailDokter extends StatefulWidget {
  @override
  State<DetailDokter> createState() => DetailDokterState();
}

class DetailDokterState extends State<DetailDokter> {
  @override
  Widget build(BuildContext context) {
    Doctor doctor = Doctor(
      imageUrl: 'assets/images/dokter-portrait.png',
      name: 'dr. Muhammad Rifky Afandi, SpKj',
      specialization: 'Spesialis Jiwa',
      yearsOfExperience: 10,
      hospitalAddress: 'Kl. AH Nasution No.07',
      rating: 4.5,
      description:
          'Muhammad Rifky Afandi adalah seorang dokter spesialis jiwa dengan pengalaman kerja 5 tahun. Beliau menempuh S1 dan spesialis jiwa di Universitas Padjajaran.',
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              height: 400,
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
                              child: Image.asset(
                                doctor.imageUrl,
                                width: 80.0,
                                height: 120.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 16.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    doctor.name,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    doctor.specialization,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    '${doctor.yearsOfExperience}',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    '${doctor.hospitalAddress}',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
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
                                  doctor.rating.toString() + '  |',
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
                                          DoctorReviewsPage()),
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
                          'Description:',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          doctor.description,
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              height: 260,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Senin',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            Text(
                              '13.00 - 18.00',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Selasa',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            Text(
                              '07.00 - 12.00',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Kamis',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            Text(
                              '19.00 - 21.00',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
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
                                    builder: (context) => BuatJanjiTemuAfter()),
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              height: 260,
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
                          'Rp 120.000/video call',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Rabu',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            Text(
                              '13.00 - 18.00',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Jum\'at',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            Text(
                              '07.00 - 12.00',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Sabtu',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            Text(
                              '19.00 - 21.00',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
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
                                        BuatJanjiKonsulAfter()),
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
          ],
        ),
      ),
    );
  }
}
