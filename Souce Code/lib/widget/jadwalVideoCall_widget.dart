import 'package:flutter/material.dart';


class WidgetJadwalVideoCall extends StatefulWidget {

  WidgetJadwalVideoCall({Key? key}) : super(key: key);

  @override
  _WidgetJadwalVideoCallState createState() => _WidgetJadwalVideoCallState();
}

class _WidgetJadwalVideoCallState extends State<WidgetJadwalVideoCall> {

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      backgroundImage: AssetImage(
                        "assets/images/dokter2.png",
                      ),
                      radius: 30,
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'dr. Muhammad Rifky Afandi, SpKj',
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            'Spesialis Jiwa',
                            style: TextStyle(
                              fontSize: 11
                            ),
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
                                'Rumah Sakit Doa Ibu C',
                                style: TextStyle(
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ],
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
                      'Durasi',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(
                      width: 240,
                      child: Text(
                        textAlign: TextAlign.end,
                        '15 menit',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 70,),
                Row(
                  children: [
                    Text(
                      'Link : ',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.black, // Warna teks lainnya
                        ),
                        children: [
                          TextSpan(
                            text: 'https://uny-ac-id.zoom.us/j/99590146921?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 1, 101, 252), // Warna teks biru
                              decoration: TextDecoration.underline, // Garis bawah
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
                      color: Color.fromARGB(255, 1, 101, 252), // Warna latar belakang biru
                      borderRadius: BorderRadius.circular(50), // Ubah ke sudut bulat jika diinginkan
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        // Logika untuk memulai video call
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent), // Ubah warna latar belakang tombol menjadi transparan
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50), // Ubah ke sudut bulat jika diinginkan
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10), // Padding teks di dalam tombol
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
  }
}
