import 'package:flutter/material.dart';

class SyaratDanKetentuanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0165fc),
        title: Text('Syarat & Ketentuan'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                'Syarat dan Ketentuan Pengguna Aplikasi DIHospital',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                '   Dengan mengunduh, memasang, dan/atau menggunakan aplikasi DIHospital, Anda sebagai pengguna (“Anda”) telah setuju dan telah membaca memahami, mengetahui, dan menerima syarat-syarat dan ketentuan-ketentuan ini (“Syarat dan Ketentuan”) dan kebijakan privasi yang terlampir (“Kebijakan Privasi”). Syarat dan Ketentuan ini dan Kebijakan Privasi yang terlampir merupakan suatu perjanjian terkait tata cara dan persyaratan penggunaan Aplikasi antara Anda dengan kami yaitu PT Doa Ibu Hospitals berikut dengan anak perusahaannya (“Kami”).',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                '     Anda setuju dan mengakui, bahwa Kami memiliki hak dan kewenangan untuk melakukan pembaharuan atas Syarat dan Ketentuan ini dari waktu ke waktu dan pembaruan tersebut akan Kami beritahukan kepada Anda pada saat Anda mengakses Aplikasi. Dalam hal Anda tidak dapat menyetujui Syarat dan Ketentuan dan Kebijakan Privasi ini maka Anda dapat menghapus akun (dalam hal Anda telah melakukan pendaftaran sebagai pengguna Aplikasi).\n\nI. Ketentuan Umum',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 32, right: 16),
              child: Text(
                '1.) Kookiness internet diperlukan untuk dapat menggunakan Aplikasi. Segala biaya yang timbul atas koneksi perangkat elektronik Anda dengan jaringan internet merupakan tanggung jawab Anda sepenuhnya.\n\n2.) Aplikasi ini merupakan aplikasi perangkat lunak yang berfungsi sebagai pemberian informasi terkait Kami ataupun rumah sakit-rumah sakit ',
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
