import 'package:flutter/material.dart';
import 'package:tp2/Fitur/monitoringSayur.dart';
import 'package:tp2/Fitur/monitoringBuah.dart';
import 'package:tp2/Fitur/monitoringTidur.dart';
import 'package:tp2/Fitur/monitoringLangkah.dart';

class MonitoringKesehatanApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MonitoringKesehatanScreen(),
    );
  }
}

class MonitoringKesehatanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Monitoring Kesehatan',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 360,
              child: Text(
                'Pertahankan kebiasaan baik anda dan lacak aktifitas sehat anda.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                ),
                maxLines: 2, // Batas jumlah baris
                overflow: TextOverflow.ellipsis, // Menggunakan elipsis (...) jika teks melebihi batas
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tracker",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.add,
                      ),
                      Text(
                        "Tambah Tracker",
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 180,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                    builder: (context) => MyWalk()));
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6)),
                            height: 70,
                            margin: EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 120,
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.directions_walk,
                                        color: Color.fromARGB(255, 1, 101, 252),
                                      ),
                                      Text("Jumlah Langkah"),
                                    ],
                                  ),
                                ),
                                //Garis Pembatas

                                Container(
                                  width: 1,
                                  height: double.infinity,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Target: 2000 Langkah"),
                                    Text(
                                      "Hari Ini: 0 Langkah ",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Icon(
                                  Icons.keyboard_arrow_right_rounded,
                                  color: Color.fromARGB(255, 1, 101, 252),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Kontainer 2 alur isi nya sama kek kontainer 1
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                    builder: (context) => MySleep()));
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            height: 70,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6)),
                            margin: EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 120,
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.bedtime,
                                        color: Color.fromARGB(255, 1, 101, 252),
                                      ),
                                      Text("Waktu Tidur"),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  height: double.infinity,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Target: 8 Jam"),
                                    Text(
                                      "Hari Ini: 0 Jam",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Icon(
                                  Icons.keyboard_arrow_right_rounded,
                                  color: Color.fromARGB(255, 1, 101, 252),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Kebiasaan Baik",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.add,
                      ),
                      Text(
                        "Tambah Kebiasaan Baik",
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 150,
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                    builder: (context) => MyFruit()));
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6)),
                            margin: EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              children: [
                                Text("Makan Lebih Banyak Buah"),
                                Spacer(),
                                Icon(
                                  Icons.keyboard_arrow_right_rounded,
                                  color: Color.fromARGB(255, 1, 101, 252),
                                )
                              ],
                            ),
                          ),
                        ),
                        // kontainer 4 sama kek kontainer 3
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                    builder: (context) => MyVegetable()));
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6)),
                            height: 50,
                            margin: EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              children: [
                                Text("Makan Lebih Banyak Sayuran"),
                                Spacer(),
                                Icon(
                                  Icons.keyboard_arrow_right_rounded,
                                  color: Color.fromARGB(255, 1, 101, 252),
                                )
                              ],
                            ),
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
