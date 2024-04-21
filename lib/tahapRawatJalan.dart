// import 'package:example_app/button.dart';
import 'dart:ui';
import 'package:timelines/timelines.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tp2/denah.dart';


class TahapRawatJalan extends StatefulWidget {
  const TahapRawatJalan({super.key});

  @override
  State<TahapRawatJalan> createState() => _TahapRawatJalanState();
}

class _TahapRawatJalanState extends State<TahapRawatJalan> {
  int indeks = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Timer untuk menambah nilai indeks setiap 10 detik
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      setState(() {
        if (indeks < 6) {
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

  bool notifkonsul = true;
  bool notifobat = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 1, 101, 252),
        surfaceTintColor: Color.fromARGB(255, 1, 101, 252),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_circle_left_outlined,
            size: 40,
            // color: Colors.black,
          ),
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              // padding: EdgeInsets.only(top: 10),
              // height: 120,
              width: double.infinity,
              color: Color.fromARGB(255, 1, 101, 252),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Rawat Jalan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    'Ikuti langkah-langkah melakukan rawat jalan',
                    style: TextStyle(
                      color: Color.fromARGB(200, 255, 255, 255),
                    ),
                  ),
                  SizedBox(height: 1000,)
                ],
              ),
            ),
            Positioned(
              top: 80,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey
                  ),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                  boxShadow: [BoxShadow(
                    color: Colors.grey.shade800,
                    blurRadius: 5,
                    spreadRadius: 2,
                  )]
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        //profil dokter
                        Container(
                          //poto dokter
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey.shade800
                            )
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              "assets/images/dokter2.png",
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Column(
                          //nama, spesialis, asal RS
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'dr. Muhammad Rifky Afandi, SpKj',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                              'Spesialis Jiwa',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_rounded,
                                  size: 16,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Text(
                                    'Rumah Sakit Doa Ibu B',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
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
                        Text(
                          'Selasa, 13/02/2024',
                          style: TextStyle(
                            color: Colors.grey[900],
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
                        Text(
                          '08.00',
                          style: TextStyle(
                            color: Colors.grey[900],
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
                          'Durasi',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          '30 Menit',
                          style: TextStyle(
                            color: Colors.grey[900],
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    RawatJalanTimeLine(),
                    Container(
                      width: 1000,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: indeks == 0 ? BorderRadius.only(bottomLeft: Radius.circular(12), topRight: Radius.circular(12), bottomRight: Radius.circular(12)) : ( indeks == 5-1 ? BorderRadius.only(bottomLeft: Radius.circular(12), topLeft: Radius.circular(12), bottomRight: Radius.circular(12)) : BorderRadius.circular(12)),
                        // borderRadius: _selectedProcess == 0 ? BorderRadius.only(bottomLeft: Radius.circular(12), topRight: Radius.circular(12), bottomRight: Radius.circular(12)) : ( _selectedProcess == 5-1 ? BorderRadius.only(bottomLeft: Radius.circular(12), topLeft: Radius.circular(12), bottomRight: Radius.circular(12)) : BorderRadius.circular(12))
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 1,
                            blurRadius: 4,
                            color: Colors.grey,
                            offset: Offset(0, 3)
                          )
                        ]
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _processes[indeks]['teks1'].toString(), // Mendapatkan teks untuk setiap poin
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            _processes[indeks]['teks2'].toString(), // Mendapatkan teks untuk setiap poin
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10
                            ),
                          ),
                          SizedBox(height: 5,),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Denah()),
                                );
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Lihat denah',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 1, 101, 252),
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Color.fromARGB(255, 1, 101, 252),
                                    size: 10,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    indeks == 6 ?Column(
                      children: [
                        InkWell(
                          onTap: () {
                            
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  color: Colors.grey,
                                  offset: Offset(0, 3),
                                )
                              ]
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Lihat Rekam Medis',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 1, 101, 252),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Color.fromARGB(255, 1, 101, 252),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        InkWell(
                          onTap: () {
                            
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  color: Colors.grey,
                                  offset: Offset(0, 3),
                                )
                              ]
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Lihat Jadwal Minum Obat',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 1, 101, 252),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Color.fromARGB(255, 1, 101, 252),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        InkWell(
                          onTap: () {
                            
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  color: Colors.grey,
                                  offset: Offset(0, 3),
                                )
                              ]
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Lihat Jadwal Selanjutnya',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 1, 101, 252),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Color.fromARGB(255, 1, 101, 252),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ) 
                    : Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 1,
                            blurRadius: 4,
                            color: Colors.grey,
                            offset: Offset(0, 3),
                          )
                        ]
                      ),
                      child: indeks == 0 ? Center(
                        child: QrImageView(
                          data: '1234567890',
                          version: QrVersions.auto,
                          size: 320,
                        ),
                      ) : (indeks == 1 || indeks == 2 ? const Column(
                        children: [
                          Text(
                            'No Antrian',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 18
                            ),
                          ),
                          Text(
                            '6',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 160,
                              color: Color.fromARGB(255, 1, 101, 252)
                            ),
                          )
                        ],
                      ): (indeks == 3 ? const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 90,),
                          Icon(
                            Icons.local_hospital,
                            color: Color.fromARGB(255, 1, 101, 252),
                            size: 40,
                          ),
                          SizedBox(height: 10,),
                          Text(
                            'Sedang melakukan pemeriksaan',
                          ),
                          SizedBox(height: 90,),
                        ],
                      ) : (indeks == 4 || indeks == 5 ? const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Obat Anda',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Anti Depresan',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                '90.000',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Sertaline',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                '85.000',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Patrazoxine',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                '175.000',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 20,),
                          Divider(color: Colors.black,),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total :',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800
                                ),
                              ),
                              Text(
                                'Rp. 350.000',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800
                                ),
                              )
                            ],
                          ),
                        ],
                      ): SizedBox.shrink()))),
                    ),
                    SizedBox(height: 20,),
                    indeks == 4 || indeks == 6 ? MaterialButton(
                      minWidth: 380,
                      height: 50,
                      onPressed: () {
                      },
                      color: Color.fromARGB(255, 1, 101, 252),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        indeks == 4 ? "Bayar Sekarang" : "Selesai",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ) : ( indeks == 5 ? 
                      Container(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: Text(
                          'Sudah Terbayar',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                     : SizedBox.shrink()) 
                    ,
                  ],
                ),
              )
            )
          ]
        ),
      )
    );
  }
}

const completeColor = Color.fromARGB(255, 108, 108, 108);
const inProgressColor = Color.fromARGB(255, 1, 101, 252);
const todoColor = Colors.grey;

class RawatJalanTimeLine extends StatefulWidget {
  @override
  _RawatJalanTimeLineState createState() => _RawatJalanTimeLineState();
}

class _RawatJalanTimeLineState extends State<RawatJalanTimeLine> {
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
        if (_processIndex == 2 || _processIndex == 3) {
          // Jika _processIndex = 2 atau _processIndex = 3, tunggu 20 detik sebelum menambah nilai
          Future.delayed(Duration(seconds: 10), () {
            if (_processIndex < 4) {
              _processIndex += 1; // Maksimal 5 nilai (_processIndex 0-4)
              _selectedProcess += 1; // Maksimal 5 nilai (_selectedProcess 0-4)
            } else {
              _timer.cancel(); // Hentikan timer setelah mencapai 4
            }
          });
        } else if (_processIndex < 4) {
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
        physics: NeverScrollableScrollPhysics(),
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
            return MediaQuery.of(context).size.width / 5 - 8; // Lebar dikurangi 8
          },
          itemCount: 5, // Jumlah poin dalam timeline (sesuaikan dengan jumlah posisi dokter)
          contentsBuilder: (context, index) {
            if (_selectedProcess == index) {
              return Column(
                crossAxisAlignment: _selectedProcess == 0 ? CrossAxisAlignment.start : (_selectedProcess == 5 - 1 ? CrossAxisAlignment.end : CrossAxisAlignment.center),
                children: [
                  SizedBox(height: 5,),
                  Image.asset(
                    "assets/icons/Polygon 2.png",
                    scale: 1.5,
                  ),
                  SizedBox(height: 5,),
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
  {'teks1': 'Pergi ke Resepsionis', 'teks2': 'Begitu sampai rumah sakit langsung pergi ke resepsionis dan scan QR code untuk konfirmasi kedatangan.'}, // Contoh dengan ikon
  {'teks1':'Pergi ke Nurse station', 'teks2': 'Anda telah mendapat nomor antrian, dimohon untuk pergi ke nurse station terlebih dahulu.'}, // Contoh dengan ikon lain
  {'teks1':'Menunggu Pemeriksaan', 'teks2': 'Anda telah dicek di nurse station, dimohon untuk menunggu nomor antrean anda dipanggil.'}, // Contoh dengan ikon lain lagi
  {'teks1':'Pemeriksaan', 'teks2': 'Silahkan memasuki ruangan dokter dan lakukan konsultasi.'}, // Contoh dengan ikon lain lagi
  {'teks1':'Pembayaran obat', 'teks2': 'Silahkan pergi ke ruang tunggu farmasi.\nDibawah ini obat yang anda dapatkan, silahkan lakukan pembayaran terlebih dahulu.'}, // Contoh dengan ikon lain lagi
  {'teks1':'Pengambilan obat', 'teks2': 'Tunggu nama anda dipanggil, setelah dipanggil pergi ke meja farmasi dan ambil obat anda.'}, // Contoh dengan ikon lain lagi
  {'teks1':'Selesai', 'teks2': 'Selamat anda telah menyelesaikan rawat jalan anda!'}, // Contoh dengan ikon lain lagi
];
