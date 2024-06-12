import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tp2/Fitur/bottomNavBar.dart';
import 'package:tp2/models/jadwalVideoCall.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:tp2/models/jadwalVideoCall.dart';
import 'package:tp2/provider/p_jadwalVideoCall.dart';
import 'package:tp2/provider/p_obat.dart';
import 'package:tp2/provider/p_rekamMedis.dart';

class WidgetJadwalVideoCall extends StatefulWidget {
  final List<JadwalVideoCall> jadwalVideoCall;

  WidgetJadwalVideoCall({Key? key, required this.jadwalVideoCall})
      : super(key: key);

  @override
  _WidgetJadwalVideoCallState createState() => _WidgetJadwalVideoCallState();
}

class _WidgetJadwalVideoCallState extends State<WidgetJadwalVideoCall> {
  bool isLoading = false;

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
    final formattedHour = timeOfDay.hour.toString().padLeft(2, '0'); // Menggunakan padLeft untuk menambah nol di depan jam jika hanya satu digit
    final formattedMinute = timeOfDay.minute.toString().padLeft(2, '0'); // Menggunakan padLeft untuk menambah nol di depan menit jika hanya satu digit
    return '$formattedHour:$formattedMinute'; // Menggabungkan jam dan menit dalam format 24 jam
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

  Future<void> _handleVideoCallButtonPress(JadwalVideoCall jadwal) async {
    setState(() {
      isLoading = true;
    });

    // Simulate video call duration
    await Future.delayed(Duration(seconds: 3));

    final obatProvider = Provider.of<ObatProvider>(context, listen: false);

    // Convert list of obat names to a single string
    final obatNames = obatProvider.dataObat.map((obat) => obat.nama).join(', ');

      // Parse time string to TimeOfDay
    final waktuMulai = parseTimeOfDay(jadwal.waktu_mulai);

    // Combine date and time
    final combinedDateTime = combineDateWithTime(jadwal.tanggal, waktuMulai);

    // After the simulated video call, post the medical record
    try{
      await Provider.of<RekamMedisProvider>(context, listen: false).postdataRekamMedis(
        obatNames,
        combinedDateTime,
        jadwal.id_dokter,
        'Video Call',
      );
    } catch (e) {
      print(e);
    } finally{
      setState(() {
        isLoading = false;
      });

    }

    // Show confirmation popup
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Konsultasi Selesai'),
        content: Text('Anda telah menyelesaikan konsultasi online.'),
        actions: [
          TextButton(
            onPressed: () {
              Provider.of<JadwalVideoCallProvider>(context, listen: false).deleteJadwalVideoCall(jadwal.id);

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => BottomNavBar(idx: 2),
                ),
                (Route<dynamic> route) => false,
              );
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Fetch obat data
    Provider.of<ObatProvider>(context, listen: false).getDataObat();
  }

  @override
  Widget build(BuildContext context) {
    final rekamMedisProvider = Provider.of<RekamMedisProvider>(context);

    return isLoading || rekamMedisProvider.isLoading
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.jadwalVideoCall.length,
            itemBuilder: (context, index) {
              final jadwal = widget.jadwalVideoCall[index];
              final waktuMulai = parseTimeOfDay(jadwal.waktu_mulai);
              final waktuBerakhir = parseTimeOfDay(jadwal.waktu_berakhir);
              final formattedTanggal = formatTanggal(jadwal.tanggal);
              final formattedWaktuMulai = formatWaktu(waktuMulai);
              final formattedWaktuBerakhir = formatWaktu(waktuBerakhir);

              final imageUrl = 'http://127.0.0.1:8000/dokter_image/${jadwal.id_dokter}';

              return Container(
                width: double.infinity,
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Color(0xffd3e6ff), // Latar belakang chat berwarna biru
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Warna bayangan
                        blurRadius: 2,
                        spreadRadius: 2,
                        offset: Offset(0, 2),
                      )
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: const Border(
                            bottom: BorderSide(color: Colors.black, width: 1)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Jadwal Video Call',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(imageUrl),
                                radius: 30,
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      jadwal.nama_dokter,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      jadwal.nama_spesialis,
                                      style: TextStyle(fontSize: 11),
                                    ),
                                  ],
                                ),
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
                                formattedTanggal,
                                style: TextStyle(
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
                                '$formattedWaktuMulai - $formattedWaktuBerakhir',
                                style: TextStyle(
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Durasi',
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 240,
                                child: Text(
                                  textAlign: TextAlign.end,
                                  '${jadwal.durasi} menit',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 70,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Link : ',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.bold),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black, // Warna teks lainnya
                                  ),
                                  children: [
                                    TextSpan(
                                      text: jadwal.link_video_call,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(
                                            255, 1, 101, 252), // Warna teks biru
                                        decoration:
                                            TextDecoration.underline, // Garis bawah
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30), // Spasi antara link dan tombol
                          Container(
                            width: double.infinity, // Lebar maksimum
                            decoration: BoxDecoration(
                              color: Color.fromARGB(
                                  255, 1, 101, 252), // Warna latar belakang biru
                              borderRadius: BorderRadius.circular(
                                  50), // Ubah ke sudut bulat jika diinginkan
                            ),
                            child: ElevatedButton(
                              onPressed: () => _handleVideoCallButtonPress(jadwal),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Color(
                                    0xff0165fc)), // Ubah warna latar belakang tombol menjadi transparan
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        50), // Ubah ke sudut bulat jika diinginkan
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(
                                    10), // Padding teks di dalam tombol
                                child: Text(
                                  'Masuk Ke Video Call Room',
                                  style: TextStyle(
                                    color: Colors.white, // Warna teks putih
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
  }
}
