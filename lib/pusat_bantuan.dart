import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PusatBantuanPage extends StatefulWidget {
  @override
  State<PusatBantuanPage> createState() => _PusatBantuanPageState();
}

class _PusatBantuanPageState extends State<PusatBantuanPage> {
  int isPressed = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0165fc),
        title: Text('Pusat Bantuan'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 24.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Pada fitur apa Anda butuh bantuan?',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                SizedBox(width: 16),
                Text(
                  'Topik',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(
                        () {
                          isPressed = 1;
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isPressed == 1 ? Color(0xff0165fc) : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      'Semua',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(
                        () {
                          isPressed = 2;
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isPressed == 2 ? Color(0xff0165fc) : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      'Layanan',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(
                        () {
                          isPressed = 3;
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isPressed == 3 ? Color(0xff0165fc) : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      'Akun',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(
                        () {
                          isPressed = 4;
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isPressed == 4 ? Color(0xff0165fc) : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      'Umum',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(
                        () {
                          isPressed = 5;
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isPressed == 5 ? Color(0xff0165fc) : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      'Transaksi',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ExpansionTile(
                title: Text(
                  'Fitur dan kegunaan',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      '1. Bagaimana cara membuat janji temu dokter?\n\n2. Bagaimana cara me-reschedule janji temu dokter?',
                      style: TextStyle(),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ExpansionTile(
                title: Text(
                  'Manajemen akun',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      '1. Apa yang harus dilakukan jika saya lupa password akun saya?\n\n2. Bagaimana jika akun saya digunakan oleh orang lain?',
                      style: TextStyle(),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ExpansionTile(
                title: Text(
                  'Memulai',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      '1. Apa itu DIHospital medical app?\n\n2. Bagaimana cara menggunakan aplikasi DiHospital?',
                      style: TextStyle(),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ExpansionTile(
                title: Text(
                  'Pembayaran dalam aplikasi',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      '1. Tipe pembayaran apa saja yang didukung?\n\n2. Apakah aman melakukan pembayaran dalam aplikasi?',
                      style: TextStyle(),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                SizedBox(width: 16),
                Text(
                  'Hubungi Kami',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.support_agent,
                        color: Color(0xff0165fc),
                        size: 48,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Customer Service',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          side: BorderSide(color: Color(0xff0165fc))),
                    ),
                    child: Text(
                      'Hubungi',
                      style: TextStyle(
                        color: Color(0xff0165fc),
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
