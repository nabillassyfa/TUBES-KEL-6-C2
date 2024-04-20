import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';
import 'dart:async';


class JadwalKonsultasi extends StatefulWidget {
  final bool notifkonsul;
  final Function(bool) onNotifChanged;

  JadwalKonsultasi({
    Key? key,
    required this.notifkonsul,
    required this.onNotifChanged,
  }) : super(key: key);

  @override
  _JadwalKonsultasiState createState() => _JadwalKonsultasiState();
}

class _JadwalKonsultasiState extends State<JadwalKonsultasi> {
  int indeks = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Timer untuk menambah nilai indeks setiap 10 detik
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      setState(() {
        if (indeks < 4) {
          indeks++; // Tambah indeks jika belum mencapai 4
        } else {
          _timer.cancel(); // Hentikan timer setelah mencapai 4
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Hentikan timer saat widget di-dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              const Text(
                'Notifikasi',
              ),
              const SizedBox(width: 10,),
              Switch(
                splashRadius: 0,
                value: widget.notifkonsul,
                activeColor: Color.fromARGB(255, 1, 101, 252),
                onChanged: widget.onNotifChanged,
              ),
            ],
          ),
        ),
        
        Container(
          width: double.infinity,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color.fromARGB(250, 206, 222, 245), // Latar belakang chat berwarna biru
            border: Border.all(
              color: Colors.grey,
              width: 2
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(
              color: Colors.grey.withOpacity(0.8), // Warna bayangan
              blurRadius: 2,
              spreadRadius: 2,
              offset: Offset(0, 2),
            )]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: const Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 2
                    )
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Jadwal Panggil Dokter',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(
                                "assets/images/dokter2.png",
                              ),
                              radius: 30,
                            ),
                            SizedBox(width: 5,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: Text(
                                    'dr. Muhammad Rifky Afandi, SpKj',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                Text(
                                  'Spesialis Jiwa',
                                  style: TextStyle(
                                    fontSize: 10
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 1, 101, 252),
                          ),
                          child: IconButton(
                            color: Colors.white,
                            onPressed: () {},
                            icon: Icon(Icons.phone),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Hari & Tanggal',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        const Text(
                          'Selasa, 13/02/2024',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Waktu',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        const Text(
                          '08.00',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Alamat',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(
                          width: 240,
                          child: Text(
                            textAlign: TextAlign.end,
                            'Jln. Geger Kalong Girang, Gg. Cempaka, Kec. Sukasari, Bandung',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 24,),
                    DoctorTimeline(),
                    Container(
                      width: 1000,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: indeks == 0 ? BorderRadius.only(bottomLeft: Radius.circular(12), topRight: Radius.circular(12), bottomRight: Radius.circular(12)) : ( indeks == _processes.length-1 ? BorderRadius.only(bottomLeft: Radius.circular(12), topLeft: Radius.circular(12), bottomRight: Radius.circular(12)) : BorderRadius.circular(12))
                        // borderRadius: _selectedProcess == 0 ? BorderRadius.only(bottomLeft: Radius.circular(12), topRight: Radius.circular(12), bottomRight: Radius.circular(12)) : ( _selectedProcess == _processes.length-1 ? BorderRadius.only(bottomLeft: Radius.circular(12), topLeft: Radius.circular(12), bottomRight: Radius.circular(12)) : BorderRadius.circular(12))
                      ),
                      child: Text(
                        _processes[indeks], // Mendapatkan teks untuk setiap poin
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Lihat Lokasi Dokter',
                              style: TextStyle(
                                color: Color.fromARGB(255, 1, 101, 252)
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Color.fromARGB(255, 1, 101, 252),
                              size: 12,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ]
    );
  }
}

const completeColor = Color.fromARGB(255, 108, 108, 108);
const inProgressColor = Color.fromARGB(255, 1, 101, 252);
const todoColor = Colors.grey;

//Timeline buat panggil dokter
class DoctorTimeline extends StatefulWidget {
  @override
  _DoctorTimelineState createState() => _DoctorTimelineState();
}

class _DoctorTimelineState extends State<DoctorTimeline> {
  int _processIndex = 0;
  int _selectedProcess = 0;
  late Timer _timer;

  Color getColor(int index) {
    if (index == _processIndex) {
      return inProgressColor;
    } else if (index < _processIndex) {
      return completeColor;
    } else {
      return todoColor;
    }
  }

  @override
  void initState() {
    super.initState();
    // Timer untuk menambah nilai _processIndex dan _selectedProcess setiap 10 detik
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      setState(() {
        if (_processIndex < 4) {
        _processIndex += 1; // Maksimal 5 nilai (_processIndex 0-4)
        _selectedProcess += 1; // Maksimal 5 nilai (_selectedProcess 0-4)
        } else {
          _timer.cancel(); // Hentikan timer setelah mencapai 4
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Hentikan timer saat widget di-dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Timeline.tileBuilder(
        theme: TimelineThemeData(
          direction: Axis.horizontal, // Atur arah timeline menjadi vertical
          
          connectorTheme: ConnectorThemeData(
            space: 20.0, // Spasi antara titik dalam timeline
            thickness: 4.0, // Ketebalan garis connector
          ),
        ),
        builder: TimelineTileBuilder.connected(
          connectionDirection: ConnectionDirection.before,
          itemExtentBuilder: (_, index) {
            if (index == 0 || index == _processes.length - 1) {
              return MediaQuery.of(context).size.width / (_processes.length*2); // Lebar normal
            } else {
              return MediaQuery.of(context).size.width / _processes.length - 8; // Lebar dikurangi 8
            }
          },
          itemCount: 5, // Jumlah poin dalam timeline (sesuaikan dengan jumlah posisi dokter)
          contentsBuilder: (context, index) {
            if (_selectedProcess == index) {
              return Column(
                crossAxisAlignment: _selectedProcess == 0 ? CrossAxisAlignment.start : (_selectedProcess == _processes.length - 1 ? CrossAxisAlignment.end : CrossAxisAlignment.center),
                children: [
                  SizedBox(height: 5,),
                  Image.asset(
                    "assets/icons/Polygon 2.png",
                    scale: 1.5,
                  ),
                  SizedBox(height: 5,),
                  // Container(
                  //   width: 1000,
                  //   padding: EdgeInsets.all(10),
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     border: Border.all(
                  //       color: Colors.black,
                  //     ),
                  //     borderRadius: _selectedProcess == 0 ? BorderRadius.only(bottomLeft: Radius.circular(12), topRight: Radius.circular(12), bottomRight: Radius.circular(12)) : ( _selectedProcess == _processes.length-1 ? BorderRadius.only(bottomLeft: Radius.circular(12), topLeft: Radius.circular(12), bottomRight: Radius.circular(12)) : BorderRadius.circular(12))
                  //   ),
                  //   child: Text(
                  //     _processes[index], // Mendapatkan teks untuk setiap poin
                  //     style: TextStyle(fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                ],
              );
            } else {
              return SizedBox.shrink(); // Mengembalikan widget kosong jika proses belum dipilih
            }
          },
          indicatorBuilder: (_, index) {
            Color color;
            if (index == _processIndex) {
              color = inProgressColor;
            } else if (index < _processIndex) {
              color = completeColor;
            } else {
              color = todoColor;
            }
      
            if (index <= _processIndex) {
              return Stack(
                children: [
                  DotIndicator(
                    size: 24.0,
                    color: color,
                  ),
                ],
              );
            } else {
              return Stack(
                children: [
                  DotIndicator(
                    size: 20.0,
                    color: color,
                  ),
                ],
              );
            }
          },
          connectorBuilder: (_, index, type) {
            if (index > 0) {
              if (index == _processIndex) {
                final prevColor = getColor(index - 1);
                final color = getColor(index);
                List<Color> gradientColors;
                if (type == ConnectorType.start) {
                  gradientColors = [Color.lerp(prevColor, color, 0.5)!, color];
                } else {
                  gradientColors = [
                    prevColor,
                    Color.lerp(prevColor, color, 0.5)!
                  ];
                }
                return DecoratedLineConnector(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: gradientColors,
                    ),
                  ),
                );
              } else {
                return SolidLineConnector(
                  color: getColor(index),
                );
              }
            } else {
              return null;
            }
          },
        ),
      ),
    );
  }

}

final _processes = [
  'Dokter sedang bersiap', // Contoh dengan ikon
  'Dokter dalam perjalanan', // Contoh dengan ikon lain
  'Dokter tiba di lokasi', // Contoh dengan ikon lain lagi
  'Dokter melakukan pemeriksaan', // Contoh dengan ikon lain lagi
  'Pemeriksaan selesai. \nDokter kembali ke rumah sakit', // Contoh dengan ikon lain lagi
];
