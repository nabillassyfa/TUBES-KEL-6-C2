import 'package:flutter/material.dart';
import 'package:tp2/Fitur/monitoringSayur.dart';


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
            SizedBox(height: 40,),
            Text(
              'Monitoring Kesehatan',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold
              ),
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
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(  
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text (   
                    "Tracker",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.add, 
                      ),
                      Text(  
                        "Tambah Tracker",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
              
            Container(
              height: 210,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey
                        ),
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(12)
                      ),
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey
                              ),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6)
                            ),
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
                                      Text (
                                        "Jumlah Langkah" 
                                      ),
                                    ],
                                  ),
                                ),
                                //Garis Pembatas
                                SizedBox(width: 10,), 
                                Container(  
                                  width: 1,
                                  height: double.infinity,
                                  color: Colors.black,
                                ), 
                                SizedBox(width: 5.0,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Target: 2000 Langkah" 
                                    ),
                                    Text(
                                      "Catatan Hari Ini: 0 Langkah ",
                                      style: TextStyle(
                                        fontSize: 12
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(), 
                                Icon(
                                  Icons.keyboard_arrow_right_rounded,
                                  color: Color.fromARGB(255, 1, 101, 252),
                                ),
                              ],
                            )
                          ),

                          // Kontainer 2 alur isi nya sama kek kontainer 1
                          Container(
                            padding: EdgeInsets.all(10),
                            height: 70,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey
                              ),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6)
                            ),
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
                                      Text (
                                        "Waktu Tidur" 
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10,), 
                                Container(  
                                  width: 1,
                                  height: double.infinity,
                                  color: Colors.black,
                                ), 
                                SizedBox(width: 10.0,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Target: 8 Jam" 
                                    ),
                                    Text(
                                      "Catatan Hari Ini: 0 Jam",
                                      style: TextStyle(
                                        fontSize: 12
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(), 
                                Icon(
                                  Icons.keyboard_arrow_right_rounded,
                                  color: Color.fromARGB(255, 1, 101, 252),
                                ),
                              ],
                            )
                          ),
                        ],
                      ),
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
                  Text (   
                    "Kebiasaan Baik",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.add, 
                      ),
                      Text(  
                        "Tambah Kebiasaan Baik",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 180,
              margin: EdgeInsets.symmetric(horizontal:  20.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey
                        ),
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(12)
                      ),
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey
                              ),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6)
                            ),
                            margin: EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              children: [
                                Text(
                                  "Makan Lebih Banyak Buah" 
                                ),
                                Spacer(),
                                Icon(
                                  Icons.keyboard_arrow_right_rounded,
                                  color: Color.fromARGB(255, 1, 101, 252),
                                )
                              ],
                            ),
                          ),
                          // kontainer 4 sama kek kontainer 3
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(builder: (context) => MyVegetable())
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey
                                ),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6)
                              ),
                              height: 50,
                              margin: EdgeInsets.only(bottom: 10.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Makan Lebih Banyak Sayuran" 
                                  ),
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