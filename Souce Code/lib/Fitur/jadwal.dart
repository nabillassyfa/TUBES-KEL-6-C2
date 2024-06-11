// import 'package:example_app/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:tp2/Fitur/jadwalKonsultasi.dart';
import 'jadwalObat.dart';

class Jadwal extends StatefulWidget {
  final int initialTabIndex;

  const Jadwal({super.key, this.initialTabIndex = 0});

  @override
  State<Jadwal> createState() => _JadwalState();
}

class _JadwalState extends State<Jadwal> with SingleTickerProviderStateMixin {
  bool notifkonsul = true;
  bool notifobat = true;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.initialTabIndex,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          const Center(
            child: Text(
              'Jadwal',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            width: 300,
            child: Text(
              'Jangan lupakan jadwal konsultasi dan minum obat Anda!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
              ),
              maxLines: 2, // Batas jumlah baris
              overflow: TextOverflow
                  .ellipsis, // Menggunakan elipsis (...) jika teks melebihi batas
            ),
          ),
          SizedBox(
            height: 8,
          ),
          DefaultTabController(
            length: 2, // Jumlah tab
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(text: 'Jadwal Konsultasi'),
                      Tab(text: 'Jadwal Obat'),
                    ],
                    physics: NeverScrollableScrollPhysics(),
                    dividerHeight: 0,
                    indicator: BoxDecoration(),
                    unselectedLabelColor: Colors.grey,
                    labelColor: Color.fromARGB(255, 1, 101, 252),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height -
                      309, // Atur sesuai dengan tinggi TabBarView
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      JadwalKonsultasi(
                        notifkonsul: notifkonsul,
                        onNotifChanged: (bool value) {
                          setState(() {
                            notifkonsul = value;
                          });
                        },
                      ),
                      JadwalObat(
                        notifobat: notifobat,
                        onNotifChanged: (bool value) {
                          setState(() {
                            notifobat = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
