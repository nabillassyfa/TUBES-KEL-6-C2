import 'package:flutter/material.dart';

class KebijakanPrivasiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0165fc),
        leading: Container(
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
        title: Row(
          children: [
            Text(
              'Kebijakan Privasi',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                'Kebijakan Privasi Pengguna Aplikasi DIHospital',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                'Kami menjaga privasi pelanggan dengan serius dan kami hanya akan mengumpulkan dan menggunakan informasi pribadi Anda seperti uraian di bawah ini. Perlindungan data adalah hal yang menyangkut kepercayaan dan privasi Anda sangatlah penting bagi kami. Oleh karena itu, kami hanya akan menggunakan nama anda dan informasi lain yang berhubungan dengan Anda sesuai dengan kebijakan privasi ini. Kami hanya akan mengumpulkan informasi yang penting bagi kami dan kami hanya akan mengumpulkan beberapa informasi yang dibutuhkan untuk melakukan urusan dengan Anda. Kami hanya akan menyimpan informasi Anda selama dibutuhkan diwajibkan oleh hukum atau selama informasi tersebut berhubungan dengan tujuan-tujuan yang ada saat informasi dikumpulkan. Kebijakan privasi kami mengikuti kebijakan perundangan-undangan yang berlaku. Bila Anda memiliki komentar dan masukan, kami dengan senang hati menerimanya melalui alamat email kami di dihospital@gmail.com',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
