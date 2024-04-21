import 'package:flutter/material.dart';
import 'detailRS.dart';
import 'beranda.dart';

class InfoRS extends StatefulWidget {
  @override
  _InfoRSState createState() => _InfoRSState();
}

class _InfoRSState extends State<InfoRS> {
  List<ListRS> hospitals = [
    ListRS(name: "Rumah Sakit Doa Ibu C", location: "Jl. AH Nasution No 15", imageUrl: "assets/images/RS.png", time: "18 menit dari lokasi saat ini"),
    ListRS(name: "Rumah Sakit Doa Ibu A", location: "Jl. RE Martadinata No 34", imageUrl: "assets/images/RS.png", time: "50 menit dari lokasi saat ini"),
    ListRS(name: "Rumah Sakit Doa Ibu B", location: "Jl. Dr Setia Budi No 50", imageUrl: "assets/images/RS.png", time: "1 jam 30 menit dari lokasi saat ini")
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
        child: IconButton(
          onPressed: () {
           Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Beranda()),
            );
          },
          icon: Icon(
            Icons.arrow_circle_left_outlined,
            size: 30,
            color: Colors.black,
          ),
        ),
      ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height / 12,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/logo.png")
                              )
                            ),
                          ),
                          Text(
                            "Informasi Rumah Sakit",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 10), // Menambahkan spasi antara teks dan ikon
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Memposisikan secara sejajar dan rata antara elemen
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Cari Rumah Sakit",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.grey.shade100,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                children: [
                Text(
                  "Rumah Sakit Terdekat",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ]
              ),
            ),
            // ListView.builder moved here
           // ListView.builder untuk menampilkan daftar rumah sakit
            ListView.builder(
              itemCount: hospitals.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return ListRS(
                  name: hospitals[index].name,
                  imageUrl: hospitals[index].imageUrl,
                  time: hospitals[index].time,
                  location: hospitals[index].location,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ListRS extends StatefulWidget{
  final String name;
  final String location;
  final String imageUrl;
  final String time;

  ListRS({required this.name, required this.location, required this.imageUrl, required this.time});

  @override
  _ListRSState createState() => _ListRSState();
}
class _ListRSState extends State<ListRS> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return detailRS();
        }));
      },
      child: Container(
        color: Color.fromARGB(0,0,0,0), // Latar belakang chat berwarna biru
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white, // Kotak chat berwarna putih
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(widget.imageUrl),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10), // Untuk membuat sudut kotak melengkung
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.name,
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 6),
                      Text(
                        widget.location,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Text(
                        widget.time,
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_right_outlined,
                  color: Colors.blue,
                  size: 24,
                ),
                Text(
                  "Lihat detail",
                  style: TextStyle(
                    fontSize: 10, color: Color.fromARGB(255, 1, 101, 252)
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
