import 'package:flutter/material.dart';
import 'package:tp2/Fitur/bottomNavBar.dart';
import 'package:tp2/models/artikel.dart';
import 'package:intl/intl.dart';

class Berita_widget extends StatelessWidget {
  const Berita_widget({
    Key? key,
    required this.data,
  }) : super(key: key);
  final Artikel data;

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
                  image: NetworkImage(data.image), 
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10), 
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
                      data.judul,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      data.abstrak,
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 5),
                    Text(
                      data.hasil,
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.justify
                    ),
                    Text(
                      data.kesimpulan,
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.justify
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Sumber : " + data.penerbit,
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Terakhir diperbarui: " + DateFormat('dd MMM yyyy').format(data.tanggal),
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Ditinjau oleh: " + data.penulis,
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