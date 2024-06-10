import 'package:flutter/material.dart';
import 'InfoRS.dart';
import 'maps.dart';
import '../models/dataRS.dart';

class detailRS extends StatefulWidget {
  const detailRS({
    Key? key,
    required this.data,
  }) : super(key: key);

  final RS data;

  @override
  _detailRSState createState() => _detailRSState();
}

class _detailRSState extends State<detailRS> {
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
                    image: NetworkImage(widget.data
                        .imageUrl), // Provide the URL directly to NetworkImage
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
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => InfoRS()),
                                );
                              },
                              icon: Icon(
                                Icons.arrow_circle_left_sharp,
                                color: Colors.white,
                                size: 34,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.data.nama,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      widget.data.lokasi,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Row(children: [
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            color: Colors.black,
                            size: 24,
                          ),
                          SizedBox(width: 5), // Jarak antara ikon dan teks
                          Text(
                            "18 menit dari lokasi anda",
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Maps()),
                              );
                            },
                            icon: Icon(
                              Icons.map_sharp,
                              color: Colors.black,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: 5), // Jarak antara ikon dan teks
                          Text(
                            "petunjuk arah",
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ])
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 8),
                      Text(
                        "Deskripsi",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.data.deskripsi,
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Fasilitas dan Layanan ",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.data.fasilitas,
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.justify,
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
