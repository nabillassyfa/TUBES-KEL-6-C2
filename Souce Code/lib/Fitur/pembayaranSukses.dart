import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tp2/Fitur/bottomNavBar.dart';


class PembayaranSukses extends StatefulWidget {
  final String itemNama;
  final String itemDeskripsi;
  String? itemDeskripsi2;
  final String itemLayanan;
  String? tanggal;
  String? waktu;
  final int biaya;
  final String pasien;

  PembayaranSukses({
    super.key,
    required this.itemNama,
    required this.itemDeskripsi,
    this.itemDeskripsi2,
    required this.itemLayanan,
    this.tanggal,
    this.waktu,
    required this.biaya,
    required this.pasien,
  });
  @override
  State<PembayaranSukses> createState() => _PembayaranSuksesState();
}

class _PembayaranSuksesState extends State<PembayaranSukses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                'Pembayaran',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold
                ),),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: Color.fromARGB(255, 1, 101, 252), // Atur warna garis sesuai keinginan
              thickness: 2, // Atur ketebalan garis
            ),
            SizedBox(
              height: 10,
            ),
            Icon(
              Icons.check_circle_rounded,
              color: Color.fromARGB(255, 1, 101, 252),
              size: 170,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Pembayaran Sukses!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Anda telah berhasil membuat janji dengan',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.itemNama,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.only(left: 50, right: 50),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.account_circle,
                            color: Color.fromARGB(255, 1, 101, 252),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.pasien,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_month,
                            color: Color.fromARGB(255, 1, 101, 252),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${widget.tanggal}',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      widget.itemDeskripsi2 != null ?
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_pin,
                            color: Color.fromARGB(255, 1, 101, 252),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${widget.itemDeskripsi2}',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ) : Container(),
                      
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.attach_money,
                            color: Color.fromARGB(255, 1, 101, 252),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 2).format(widget.biaya)}',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.access_time_filled,
                            color: Color.fromARGB(255, 1, 101, 252),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${widget.waktu}',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                      
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 160,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color.fromARGB(255, 1, 101, 252),
              width: 2,
            ),
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 20),
            MaterialButton(
              minWidth: 380,
              height: 50,
              onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const BottomNavBar(idx: 1)), // Ganti ProfilePage dengan halaman profil yang ingin ditampilkan
                    (Route<dynamic> route) => false,
                  );
                },
              color: Color.fromARGB(255, 1, 101, 252),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                "Lihat Jadwal",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const BottomNavBar(idx: 0)), // Ganti ProfilePage dengan halaman profil yang ingin ditampilkan
                  (Route<dynamic> route) => false,
                );
              },
              child: Text(
                'Kembali ke beranda',
                style: TextStyle(
                  color: Color.fromARGB(255, 1, 101, 252),
                  decoration: TextDecoration.underline,
                  decorationColor: Color.fromARGB(255, 1, 101, 252),
                  decorationThickness: 3,
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}