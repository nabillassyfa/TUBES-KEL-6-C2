import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tp2/bottomNavBar.dart';
import 'beranda.dart';

class Doctor {
  final String imageUrl;
  final String name;
  final String specialization;
  final int yearsOfExperience;
  final String hospitalAddress;
  final double rating;
  final int ratingCount;
  final String description;

  Doctor({
    required this.imageUrl,
    required this.name,
    required this.specialization,
    required this.yearsOfExperience,
    required this.hospitalAddress,
    required this.rating,
    required this.ratingCount,
    required this.description,
  });
}

class DoctorAddReviewsPage extends StatefulWidget {
  @override
  State<DoctorAddReviewsPage> createState() => DoctorAddReviewsState();
}

class DoctorAddReviewsState extends State<DoctorAddReviewsPage> {
  @override
  Widget build(BuildContext context) {
    Doctor doctor = Doctor(
      imageUrl: 'assets/images/dokter2.png',
      name: 'Dr. John Doe',
      specialization: 'Cardiologist',
      yearsOfExperience: 10,
      hospitalAddress: '123 Main St, City',
      rating: 4.5,
      ratingCount: 23,
      description:
          'Muhammad Rifky Afandi adalah seorang dokter spesialis jiwa dengan pengalaman kerja 5 tahun. Beliau menempuh S1 dan spesialis jiwa di Universitas Padjajaran.',
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Reviews'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Image.asset(
                  doctor.imageUrl,
                  width: 120.0,
                  height: 120.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'dr. Muhammad Rifky Afandi, SpKj',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            Text(
              'Spesialis Kejiwaan',
              style: TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
            SizedBox(height: 16.0),
            Text(
              'Bagaimana pengalaman Anda dengan dr. Rifky?',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            Divider(thickness: 2),
            SizedBox(height: 16.0),
            Text(
              'Rating yang diberikan',
              style: TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 4.0),
                Icon(
                  Icons.star_border,
                  color: Colors.black,
                  size: 48,
                ),
                Icon(
                  Icons.star_border,
                  color: Colors.black,
                  size: 48,
                ),
                Icon(
                  Icons.star_border,
                  color: Colors.black,
                  size: 48,
                ),
                Icon(
                  Icons.star_border,
                  color: Colors.black,
                  size: 48,
                ),
                Icon(
                  Icons.star_border,
                  color: Colors.black,
                  size: 48,
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Divider(thickness: 2),
            SizedBox(height: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tambahkan Review',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 80.0, // Ubah nilai tinggi sesuai kebutuhan Anda
                  child: TextFormField(
                    maxLines: null, // Mengatur jumlah baris menjadi dinamis
                    decoration: InputDecoration(
                      labelText: 'Review Anda',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                child: Text(
                  'Kirim',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff0165fc),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        32.0), // Mengatur sudut melengkung menjadi 10.0
                  ),
                ),
                onPressed: () {
                  // Simpan perubahan biodata ke tempat penyimpanan yang sesuai
                  // Misalnya, Anda dapat menggunakan metode penyimpanan data seperti SharedPreferences, SQLite, atau REST API untuk menyimpan biodata yang telah diedit.
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Konfirmasi'),
                        content:
                            Text('Apakah Anda yakin ingin dengan reviewnya?'),
                        actions: [
                          TextButton(
                            child: Text('Batal'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Kirim'),
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const BottomNavBar(
                                        idx: 0)), // Ganti ProfilePage dengan halaman profil yang ingin ditampilkan
                                (Route<dynamic> route) => false,
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
