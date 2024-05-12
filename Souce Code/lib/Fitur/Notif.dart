import 'package:flutter/material.dart';

class Notif extends StatefulWidget {
  @override
  _NotifState createState() => _NotifState();
}

class _NotifState extends State<Notif> {
  List<ListRS> hospitals = [
    ListRS(name: "Anda Memiliki Janji Temu", keterangan: "Anda Memiliki Janji Temu dengan Spesialis Jiwa,\n dr. Muhammad Rifky Afandi, SpKj.", imageUrl: "assets/images/jadwal.png", time: "30 m", isRead: false,),
    ListRS(name: "Anda Memiliki Janji Video Call", keterangan: "Anda Memiliki Janji Video Call dengan Spesialis Jiwa,\n dr. Muhammad Rifky Afandi, SpKj.", imageUrl: "assets/images/vc.png", time: "1j", isRead: false,),
    ListRS(name: "Lebih Banyak Langkah !", keterangan: "Anda belum mencapai target langkah anda hari ini.", imageUrl: "assets/images/kesehatan.png", time: "5j", isRead: true,),
    ListRS(name: "Makan Lebih Banyak Buah!", keterangan: "Ingat untuk selalu banyak makan buah setiap harinya!", imageUrl: "assets/images/kesehatan.png", time: "5j", isRead: true,)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_circle_left_outlined,
            size: 30,
            color: Colors.black,
          ),
        ),
        actions: [
          Spacer(), // Menggeser tombol ke sisi kanan
          MaterialButton(
            onPressed: () {},
            color: Color.fromARGB(255, 1, 101, 252),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            height: 30,
            minWidth: 30,
            child: Text(
              "2 Baru",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 10,
                color: Colors.white,
              ),
            ),
          ),
        ],
        flexibleSpace: Container(
          alignment: Alignment.center,
          child: Text(
            "Notifikasi",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 27,
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
            Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Row(
                  children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Column(
                      children: [
                      Text(
                        "HARI INI",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      ]
                    ),
                  ),
                  ]
                ),
            ),
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
                  keterangan: hospitals[index].keterangan,
                  isRead: hospitals[index].isRead,
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
  final String keterangan;
  final String imageUrl;
  final String time;
  final bool isRead;

  ListRS({required this.name, required this.keterangan, required this.imageUrl, required this.time, required this.isRead});

  @override
  _ListRSState createState() => _ListRSState();
}
class _ListRSState extends State<ListRS> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: Color.fromARGB(0,0,0,0), // Latar belakang chat berwarna biru
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey, // Warna garis bawah
                width: 1.0, // Lebar garis bawah
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage(widget.imageUrl),
                  maxRadius: 30,
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
                        widget.keterangan,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!widget.isRead)
                  Icon(
                    Icons.circle_notifications,
                    color: Colors.blue,
                    size: 24,
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
        ),
      ),
    );
  }
}
