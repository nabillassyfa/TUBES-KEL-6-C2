import 'package:flutter/material.dart';
import 'package:tp2/bottomNavBar.dart';
import 'beranda.dart';

class detailBerita extends StatefulWidget {
  const detailBerita({super.key});

  @override
  _detailBeritaState createState() => _detailBeritaState();
}

class _detailBeritaState extends State<detailBerita> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
 body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/Berita.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.only(top: 5, left: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Menambahkan Icon
                      Container(
                        padding: EdgeInsets.only(top: 16),
                        child: Row(
                          children: [
                            SizedBox(width: 20),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          BottomNavBar(idx: 0,)),
                                );
                              },
                              icon: Icon(
                              Icons.arrow_back_outlined,
                              color: Colors.black,
                              size: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Solusi Mengatasi Sulit Tidur",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Beberapa cara mengatasi susah tidur, mulai dari mengurangi kafein hingga minum susu, bisa diterapkan agar tidur menjadi mudah dan nyenyak. Jika tidak ditangani, susah tidur dapat mengganggu aktivitas sehari-hari hingga memicu berbagai gangguan kesehatan",
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Beragam cara mengatasi sulit tidur :",
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "   1. Olahraga Secara teratur\n"
                      "   2. Membatasi waktu tidur siang\n"
                      "   3. Membatasi penggunaan gawai\n"
                      "   4. Mandi air hangat",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Beberapa orang mungkin menyiasati keluhan susah tidur dengan mengonsumsi obat tidur. Namun, penggunaan obat tidur sebaiknya dilakukan atas saran dari dokter agar tidak terjadi penyalahgunaan obat atau ketergantungan obat.",
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Jika cara mengatasi susah tidur di atas tidak membuat keluhan susah tidur Anda membaik atau bertahan lebih dari seminggu, segera konsultasikan dengan dokter untuk mendapatkan penanganan yang sesuai.",
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Terakhir diperbarui: 25 Februari 2023\n"
                      "Ditinjau oleh: dr. Sienny Agustin\n",
                      style: TextStyle(fontSize: 12),
                    ),
                  ]
                ),
              ),
                
            ],
          ),
        ),
      ),
    );
  }
}