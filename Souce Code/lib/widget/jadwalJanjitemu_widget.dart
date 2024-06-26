import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:tp2/Fitur/tahapRawatJalan.dart';
import 'package:tp2/models/jadwalJanjiTemu.dart';

class WidgetJadwalJanjiTemu extends StatelessWidget {
  final List<JadwalJanjiTemu> jadwalJanjiTemu;

  WidgetJadwalJanjiTemu({Key? key, required this.jadwalJanjiTemu})
      : super(key: key);

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
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: jadwalJanjiTemu.length,
      itemBuilder: (context, index) {
        final jadwal = jadwalJanjiTemu[index];
        final waktuMulai = parseTimeOfDay(jadwal.waktu_mulai);
        final waktuBerakhir = parseTimeOfDay(jadwal.waktu_berakhir);
        final formattedTanggal = formatTanggal(jadwal.tanggal);
        final formattedWaktuMulai = formatWaktu(waktuMulai);
        final formattedWaktuBerakhir = formatWaktu(waktuBerakhir);

        final imageUrl =
            'http://127.0.0.1:8000/dokter_image/${jadwal.id_dokter}';

        return Container(
          width: double.infinity,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color(0xffd3e6ff), // Latar belakang chat berwarna biru
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Warna bayangan
                blurRadius: 2,
                spreadRadius: 2,
                offset: Offset(0, 2),
              )
            ],
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
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Jadwal Rawat Jalan',
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
                              Row(
                                children: [
                                  Icon(
                                    Icons.pin_drop_sharp,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    size: 20,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    jadwal.nama_RS,
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
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
                          formattedTanggal, // Tampilkan tanggal dengan format yang diinginkan
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
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
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
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
                            '${jadwal.durasi} menit',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tahap 1/5',
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              'Pergi ke resepsionis',
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 24), // Spasi antara link dan tombol
                    Container(
                      width: double.infinity, // Lebar maksimum
                      decoration: BoxDecoration(
                        color: Color(0xff0165fc), // Warna latar belakang biru
                        borderRadius: BorderRadius.circular(
                            50), // Ubah ke sudut bulat jika diinginkan
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TahapRawatJalan(
                                  jadwalJanjiTemu: jadwal,
                                ),
                                barrierDismissible:
                                    true), // Ganti HalamanTujuan dengan halaman yang ingin dituju
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color(
                              0xff0165fc)), // Ubah warna latar belakang tombol menjadi transparan
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
                            'Lihat Detail Langkah Rawat Jalan',
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
      },
    );
  }
}
