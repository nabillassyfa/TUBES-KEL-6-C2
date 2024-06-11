// import 'package:example_app/button.dart';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timelines/timelines.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tp2/Fitur/bottomNavBar.dart';
import 'package:tp2/Fitur/denah.dart';
import 'package:tp2/Fitur/pembayaran.dart';
import 'package:tp2/models/jadwalJanjiTemu.dart';
import 'package:tp2/models/metodePembayaran.dart';
import 'package:tp2/provider/p_metodePembayaran.dart';
import 'package:tp2/provider/p_obat.dart';
import 'package:tp2/provider/p_rekamMedis.dart';
import 'package:tp2/provider/p_statusUserRawatJalan.dart';
import 'package:tp2/widget/dotTahapRawatjalan_widget.dart';
import 'beri_review.dart';

class TahapRawatJalan extends StatefulWidget {
  final JadwalJanjiTemu jadwalJanjiTemu;

  TahapRawatJalan({super.key, required this.jadwalJanjiTemu});

  @override
  State<TahapRawatJalan> createState() => _TahapRawatJalanState();
}

class _TahapRawatJalanState extends State<TahapRawatJalan> {
  int indeks = 0;
  MetodePembayaranProvider? metodePembayaranProvider;
  MetodePembayaran? selectedMetodePembayaran;

  TimeOfDay parseTimeOfDay(String timeString) {
    final parts = timeString.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }

  String formatTanggal(DateTime dateTime) {
    return DateFormat.yMMMMEEEEd('id_ID').format(
        dateTime); // Format tanggal hari, tanggal-bulan-tahun (Bahasa Indonesia)
  }

  String formatWaktu(TimeOfDay timeOfDay) {
    final formattedHour = timeOfDay.hour.toString().padLeft(2,
        '0'); // Menggunakan padLeft untuk menambah nol di depan jam jika hanya satu digit
    final formattedMinute = timeOfDay.minute.toString().padLeft(2,
        '0'); // Menggunakan padLeft untuk menambah nol di depan menit jika hanya satu digit
    return '$formattedHour:$formattedMinute'; // Menggabungkan jam dan menit dalam format 24 jam
  }

  @override
  void initState() {
    super.initState();
    Provider.of<StatusUserRawatJalanProvider>(context, listen: false)
        .getDataStatusUserRawatJalan(widget.jadwalJanjiTemu.id)
        .then((_) {
      final status =
          Provider.of<StatusUserRawatJalanProvider>(context, listen: false)
              .dataStatus;
      if (status != null) {
        setState(() {
          indeks = status.id_statusRawatJalan -
              1; // Set initial index based on the fetched status
        });
      }
    });

    metodePembayaranProvider =
        Provider.of<MetodePembayaranProvider>(context, listen: false);
    metodePembayaranProvider!.getdataMetodePembayaran();
    // Fetch obat data
    Provider.of<ObatProvider>(context, listen: false).getDataObat();
  }

  void _incrementIndeks() {
    final provider =
        Provider.of<StatusUserRawatJalanProvider>(context, listen: false);
    setState(() {
      if(indeks == 5){
         _postRekamMedis();
      }
      if (indeks < 6) {
        indeks++;
        print('indeks: ' + '${indeks}');
        provider
            .updateStatusUserRawatJalan(widget.jadwalJanjiTemu.id, indeks + 1)
            .then((_) {
          provider.getDataStatusUserRawatJalan(widget.jadwalJanjiTemu.id);
        });
      }
    });
  }

  DateTime combineDateWithTime(DateTime date, TimeOfDay time) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }
  

  void _postRekamMedis() {
    final obatProvider = Provider.of<ObatProvider>(context, listen: false);
    final rekamMedisProvider = Provider.of<RekamMedisProvider>(context, listen: false);

    // Convert list of obat names to a single string
    final obatNames = obatProvider.dataObat.map((obat) => obat.nama).join(', ');

      // Parse time string to TimeOfDay
    final waktuMulai = parseTimeOfDay(widget.jadwalJanjiTemu.waktu_mulai);

    // Combine date and time
    final combinedDateTime = combineDateWithTime(widget.jadwalJanjiTemu.tanggal, waktuMulai);

    rekamMedisProvider.postdataRekamMedis(
      obatNames,
      combinedDateTime,
      widget.jadwalJanjiTemu.id_dokter,
    ).then((_) {
      // Show success message or handle post submission logic
      print('Rekam Medis posted successfully');
    }).catchError((error) {
      // Handle error
      print('Error posting Rekam Medis: $error');
    });
  }

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
            icon: Icon(
              Icons.arrow_back,
              size: 24,
              color: Colors.white,
            ),
          ),
        ),
        floatingActionButton: (indeks != 4 && indeks != 6)
            ? FloatingActionButton(
                onPressed: _incrementIndeks,
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
                backgroundColor: Color.fromARGB(255, 1, 101, 252),
              )
            : null,
        body: SingleChildScrollView(
          child: Stack(children: [
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
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Ikuti langkah-langkah melakukan rawat jalan',
                    style: TextStyle(
                      color: Color.fromARGB(200, 255, 255, 255),
                    ),
                  ),
                  SizedBox(
                    height: 1000,
                  )
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
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 2,
                          spreadRadius: 2,
                        )
                      ]),
                  child: Consumer<StatusUserRawatJalanProvider>(
                      builder: (context, provider, child) {
                    print('tstts');
                    if (provider.isLoading) {
                      print('tatts');
                      return Center(child: CircularProgressIndicator());
                    }
                    // print(provider.dataStatus.keterangan_status);

                    final dataStatus = provider.dataStatus;
                    if (dataStatus == null) {
                      return Center(child: Text("No data available"));
                    }

                    return Column(
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
                                  border:
                                      Border.all(color: Colors.grey.shade800)),
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
                            Column(
                              //nama, spesialis, asal RS
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.jadwalJanjiTemu.nama_dokter,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  widget.jadwalJanjiTemu.nama_spesialis,
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
                                        widget.jadwalJanjiTemu.nama_RS,
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
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Hari & Tanggal',
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              formatTanggal(widget.jadwalJanjiTemu.tanggal),
                              style: TextStyle(
                                color: Colors.grey[900],
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Waktu',
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${formatWaktu(parseTimeOfDay(widget.jadwalJanjiTemu.waktu_mulai))} - ${formatWaktu(parseTimeOfDay(widget.jadwalJanjiTemu.waktu_berakhir))}',
                              style: TextStyle(
                                color: Colors.grey[900],
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Durasi',
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${widget.jadwalJanjiTemu.durasi} Menit',
                              style: TextStyle(
                                color: Colors.grey[900],
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RawatJalanTimeLine(
                          processIndex: indeks,
                        ), // ---------------- timeline
                        Container(
                          width: 1000,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black,
                              ),
                              borderRadius: indeks == 0
                                  ? BorderRadius.only(
                                      bottomLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                      bottomRight: Radius.circular(12))
                                  : (indeks == 5 - 1
                                      ? BorderRadius.only(
                                          bottomLeft: Radius.circular(12),
                                          topLeft: Radius.circular(12),
                                          bottomRight: Radius.circular(12))
                                      : BorderRadius.circular(12)),
                              // borderRadius: _selectedProcess == 0 ? BorderRadius.only(bottomLeft: Radius.circular(12), topRight: Radius.circular(12), bottomRight: Radius.circular(12)) : ( _selectedProcess == 5-1 ? BorderRadius.only(bottomLeft: Radius.circular(12), topLeft: Radius.circular(12), bottomRight: Radius.circular(12)) : BorderRadius.circular(12))
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                    color: Colors.grey,
                                    offset: Offset(0, 3))
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                dataStatus
                                    .keterangan_status, // Mendapatkan teks untuk setiap poin
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                dataStatus
                                    .deskripsi, // Mendapatkan teks untuk setiap poin
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 10),
                              ),
                              SizedBox(
                                height: 5,
                              ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Lihat denah',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 1, 101, 252),
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
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
                        SizedBox(
                          height: 10,
                        ),
                        indeks == 6
                            ? Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BottomNavBar(
                                                idx:
                                                    2)), // Ganti ProfilePage dengan halaman profil yang ingin ditampilkan
                                        (Route<dynamic> route) => false,
                                      );
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 30),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Colors.black,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              spreadRadius: 1,
                                              blurRadius: 4,
                                              color: Colors.grey,
                                              offset: Offset(0, 3),
                                            )
                                          ]),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Lihat Rekam Medis',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 1, 101, 252),
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            color: Color.fromARGB(
                                                255, 1, 101, 252),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BottomNavBar(
                                                idx:
                                                    1)), // Ganti ProfilePage dengan halaman profil yang ingin ditampilkan
                                        (Route<dynamic> route) => false,
                                      );
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 30),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Colors.black,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              spreadRadius: 1,
                                              blurRadius: 4,
                                              color: Colors.grey,
                                              offset: Offset(0, 3),
                                            )
                                          ]),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Lihat Jadwal Minum Obat',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 1, 101, 252),
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            color: Color.fromARGB(
                                                255, 1, 101, 252),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BottomNavBar(
                                                idx:
                                                    1)), // Ganti ProfilePage dengan halaman profil yang ingin ditampilkan
                                        (Route<dynamic> route) => false,
                                      );
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 30),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Colors.black,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              spreadRadius: 1,
                                              blurRadius: 4,
                                              color: Colors.grey,
                                              offset: Offset(0, 3),
                                            )
                                          ]),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Lihat Jadwal Selanjutnya',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 1, 101, 252),
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            color: Color.fromARGB(
                                                255, 1, 101, 252),
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
                                    ]),
                                child: indeks == 0
                                    ? Center(
                                        child: QrImageView(
                                          data: '1234567890',
                                          version: QrVersions.auto,
                                          size: 320,
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
                                      ]),
                                  child: indeks == 0
                                      ? Center(
                                          child: QrImageView(
                                            data: '1234567890',
                                            version: QrVersions.auto,
                                            size: 320,
                                          ),
                                        )
                                      : (indeks == 1 || indeks == 2
                                          ? const Column(
                                              children: [
                                                Text(
                                                  'No Antrean',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w800,
                                                      fontSize: 18),
                                                ),
                                                Text(
                                                  '6',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w800,
                                                      fontSize: 160,
                                                      color: Color.fromARGB(
                                                          255, 1, 101, 252)),
                                                )
                                              ],
                                            )
                                          : (indeks == 3
                                              ? const Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      height: 90,
                                                    ),
                                                    Icon(
                                                      Icons.local_hospital,
                                                      color: Color.fromARGB(
                                                          255, 1, 101, 252),
                                                      size: 40,
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      'Sedang melakukan pemeriksaan',
                                                    ),
                                                    SizedBox(
                                                      height: 90,
                                                    ),
                                                  ],
                                                )
                                              : (indeks == 4 || indeks == 5
                                                  ? Consumer<ObatProvider>(
                                                      builder: (context, obatProvider, child) {
                                                        if (obatProvider.isLoading) {
                                                          return CircularProgressIndicator();
                                                        }
                                                        final obatList = obatProvider.dataObat;
                                                        if (obatList.isEmpty) {
                                                          return Text("No medications available");
                                                        }
                                                        return Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Text(
                                                              'Obat Anda',
                                                              style: TextStyle(
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.bold),
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Column(
                                                              children: obatList.map((obat) {
                                                                return Column(
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          obat.nama,
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                        Text(
                                                                          obat.harga.toString(),
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(height: 20),
                                                                  ],
                                                                );
                                                              }).toList(),
                                                            ),
                                                            Divider(
                                                              color: Colors.black,
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Text(
                                                                  'Total :',
                                                                  style: TextStyle(
                                                                      color: Colors.black,
                                                                      fontWeight: FontWeight.w800),
                                                                ),
                                                                Text(
                                                                  obatProvider.totalHarga.toString(),
                                                                  style: TextStyle(
                                                                      color: Colors.black,
                                                                      fontWeight: FontWeight.w800),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    )
                                                  : SizedBox.shrink()))),
                                ),
                          SizedBox(
                            height: 20,
                          ),
                          indeks == 4?
                          Container(
                            padding: EdgeInsets.only(left: 15),
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Color.fromARGB(255, 1, 101, 252),

                              ),
                        SizedBox(
                          height: 20,
                        ),
                        indeks == 4
                            ? Container(
                                padding: EdgeInsets.only(left: 15),
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Color.fromARGB(255, 1, 101, 252),
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        color: Colors.grey,
                                        offset: Offset(0, 3),
                                      )
                                    ]),
                                child: InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Consumer<
                                            MetodePembayaranProvider>(
                                          builder: (context, provider, child) {
                                            if (provider.isLoading) {
                                              return Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            } else {
                                              List<MetodePembayaran>
                                                  filteredMetodePembayaran =
                                                  provider.dataMetodePembayaran;
                                              return ListView.builder(
                                                itemCount:
                                                    filteredMetodePembayaran
                                                        .length,
                                                itemBuilder: (context, index) {
                                                  MetodePembayaran metode =
                                                      filteredMetodePembayaran[
                                                          index];
                                                  return ListTile(
                                                    title: Text(
                                                        metode.nama_pembayaran),
                                                    onTap: () {
                                                      setState(() {
                                                        selectedMetodePembayaran =
                                                            metode;
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                  );
                                                },
                                              );
                                            }
                                          },
                                        );
                                      },
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        selectedMetodePembayaran != null
                                            ? selectedMetodePembayaran!
                                                .nama_pembayaran
                                            : 'Pilih Metode Pembayaran',
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.grey[900],
                                          size: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                        SizedBox(
                          height: 20,
                        ),
                        indeks == 4 || indeks == 6
                            ? MaterialButton(
                                minWidth: 380,
                                height: 50,
                                onPressed: () {
                                  indeks == 4
                                      ? selectedMetodePembayaran != null
                                          ? _incrementIndeks()
                                          : ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    'Silahkan isi metode pembayaran'),
                                              ),
                                            )
                                      : Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DoctorAddReviewsPage(
                                              beri_review:
                                                  widget.jadwalJanjiTemu,
                                            ),
                                          ));
                                },
                                color: Color.fromARGB(255, 1, 101, 252),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Text(
                                  indeks == 4 ? "Konfirmasi" : "Selesai",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : (indeks == 5
                                ? Container(
                                    padding:
                                        EdgeInsets.only(top: 20, bottom: 20),
                                    child: Text(
                                      'Sudah Terbayar',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                : SizedBox.shrink()),
                      ],
                    );
                  }),
                ))
          ]),
        ));
  }
}
