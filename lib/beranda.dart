import 'package:flutter/material.dart';
import 'bottomNavBar.dart';
import 'emergency.dart';
import 'chat_dokter.dart';
import 'informasi_dokter.dart';

class Beranda extends StatefulWidget {
  const Beranda({super.key});
  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //Appbar
        surfaceTintColor: Colors.white, //warna ketika di scroll
        automaticallyImplyLeading: false, // Menonaktifkan tombol kembali bawaan
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        flexibleSpace: Center(
          //agar berada ditengah secara vertikal
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // Logo DIhospital
            children: [
              Image.asset(
                //logo
                "assets/images/logo.png",
                width: 40,
                height: 40,
              ),
              const SizedBox(width: 4), // Jarak antara logo dan teks
              const Text(
                //Text
                'DIHospital', // Teks ditampilkan di sebelah logo
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0), // Warna teks
                  fontSize: 20, // Ukuran teks
                  fontWeight: FontWeight.w800, // Ketebalan teks
                ),
              ),
            ],
          ),
        ),
        toolbarHeight: 70, //Tinggi appbar
      ),
      body: SingleChildScrollView(
        //body dengan scroll view
        padding: const EdgeInsets.only(
            left: 20, right: 20, bottom: 20), //padding kedalam
        controller: ScrollController(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Material(
                  //Profil
                  child: InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BottomNavBar(
                                idx:
                                    4)), // Ganti ProfilePage dengan halaman profil yang ingin ditampilkan
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: Row(children: [
                      Container(
                        // poto profil
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color.fromARGB(
                                255, 1, 101, 252), // Warna border
                            width: 2, // Ketebalan border
                          ),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            "assets/images/celine.png",
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8), //jarak image dan tulisan
                      const Column(
                        //nama dan gender
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            //nama
                            'Celine Rodriguez',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            //gender
                            children: [
                              Icon(
                                Icons.female,
                                color: Colors.pink,
                              ),
                              Text(
                                'Wanita',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ]),
                  ),
                ),
                Row(
                  //darurat dan notif
                  children: [
                    Material(
                      //darurat
                      child: InkWell(
                        onTap: () {
                          // Navigasi ke halaman baru ketika widget ditekan
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Emergency(),
                                barrierDismissible:
                                    true), // Ganti HalamanTujuan dengan halaman yang ingin dituju
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 255, 62, 62),
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4)),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment
                                .center, // Center the icon and text horizontally
                            children: [
                              Text(
                                'Darurat',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 62, 62),
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                  width:
                                      4), // Add spacing between icon and text
                              Icon(
                                Icons.local_hospital,
                                color: Color.fromARGB(255, 255, 62, 62),
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Stack(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.notifications,
                            size: 35,
                            color: Colors
                                .black, // Atur warna ikon sesuai kebutuhan
                          ),
                          onPressed: () {
                            // Tambahkan kode aksi yang ingin dilakukan saat ikon diklik di sini
                          },
                        ),
                        Positioned(
                          //titik merah
                          top: 9,
                          right: 10,
                          child: Container(
                            height: 10,
                            width: 10,
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                                border: Border.all(
                                    color: Colors.white,
                                    width: 3,
                                    strokeAlign:
                                        BorderSide.strokeAlignOutside)),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            const Divider(
              //garis batas
              thickness: 2,
              color: Colors.black,
            ),
            const Padding(
              //Teks layanan
              padding: EdgeInsets.only(
                  bottom: 5,
                  top: 10), // Atur padding sebanyak yang Anda inginkan
              child: Text(
                "Layanan",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              //Kotak Layanan
              padding: const EdgeInsets.all(12),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: const Color.fromARGB(255, 1, 101, 252),
                    width: 2,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(12))),
              child: Column(
                children: [
                  Builder(builder: (context) {
                    List menuImage = [
                      {"icon": Icons.library_add, "label": "Buat Janji Temu"},
                      {
                        "icon": Icons.local_hospital,
                        "label": "Informasi Rumah Sakit"
                      },
                      {
                        "icon": Icons.person_pin_rounded,
                        "label": "Informasi Dokter"
                      },
                      {"icon": Icons.local_bar, "label": "Pemeriksaan Lab"},
                      {"icon": Icons.video_call, "label": "Video Call Dokter"},
                      {"icon": Icons.chat, "label": "Chat Dokter"},
                      {
                        "icon": Icons.person_add_alt_1,
                        "label": "Panggil Dokter"
                      },
                      {"icon": Icons.list_alt, "label": "Lainnya"},
                    ];
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1,
                        crossAxisCount: 4,
                        mainAxisSpacing: 6,
                        crossAxisSpacing: 10,
                      ),
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: menuImage.length,
                      itemBuilder: (BuildContext context, index) {
                        var item = menuImage[index];
                        return Column(
                          children: [
                            Expanded(
                              //atur icon
                              child: IconButton(
                                icon: Icon(
                                  item["icon"],
                                  size: 40,
                                  color: const Color.fromARGB(
                                      255, 1, 101, 252), // Atur warna ikon
                                ),
                                onPressed: () {
                                  // Tambahkan kode aksi yang ingin dilakukan saat ikon diklik di sini
                                  switch (index) {
                                    case 0:
                                      // Aksi untuk ikon pertama
                                      break;
                                    case 1:
                                      // Aksi untuk ikon kedua
                                      break;
                                    case 2:
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SpecializationPage()),
                                      );
                                      break;
                                    case 3:
                                      break;
                                    case 4:
                                      break;
                                    case 5:
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ChatPage()),
                                      );
                                      break;
                                    // Tambahkan case untuk ikon lainnya sesuai kebutuhan
                                  }
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              //atur label
                              item["label"],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                              ),
                            )
                          ],
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            const Padding(
              //Teks anda memiliki janji temu
              padding: EdgeInsets.only(bottom: 5, top: 10),
              child: Text(
                "Anda memiliki janji temu!",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              //Card janji temu
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 1, 101, 252),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 16,
                        offset: const Offset(0, 11)),
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(12))),
              child: Column(children: [
                Row(children: [
                  //profil dokter
                  Container(
                    //poto dokter
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: Image.network(
                        "https://picsum.photos/250?image=1",
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
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Psikiatri - Spesialis Jiwa',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.pin_drop_sharp,
                            color: Color.fromARGB(255, 255, 255, 255),
                            size: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              'Rumah Sakit Doa Ibu B',
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ]),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  //Waktu Konsultasi
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 5, bottom: 5),
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 8, 88, 209),
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_month,
                            color: Colors.white,
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Text(
                                "Senin, 18 Maret",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ))
                        ],
                      ),
                      SizedBox(
                        //garis tengah
                        height: 25,
                        child: VerticalDivider(
                            thickness: 2,
                            color: Color.fromARGB(255, 41, 111, 215)),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.access_time_filled,
                            color: Colors.white,
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Text(
                                "08.00-08.30",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Material(
                  //lihat detail, direct ke halaman jadwal
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: () {},
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Lihat detail',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ]),
            ),
            const SizedBox(
              height: 24,
            ),
            const Padding(
              //Teks informasi kesehatan
              padding: EdgeInsets.only(bottom: 5, top: 10),
              child: Text(
                "Informasi Kesehatan",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              //Tampilan informasi kesehatan
              height: 200,
              margin: const EdgeInsets.only(right: 10),
              child: Scrollbar(
                thumbVisibility: true, //agar scroll bar selalu muncul
                controller: ScrollController(),
                child: Builder(builder: (context) {
                  List artikelKesehatan = [
                    {
                      "img":
                          "https://akcdn.detik.net.id/community/media/visual/2022/11/23/ilustrasi-tidur-1_169.jpeg?w=700&q=90",
                      "judul": "Solusi Mengatasi Sulit Tidur!",
                      "tgl": "08 Feb 2024"
                    },
                    {
                      "img":
                          "https://images.tokopedia.net/img/KRMmCm/2022/7/13/be1f5715-32af-4c66-bec7-8c8c3b57d6a2.jpg",
                      "judul": "Makanan sehat untuk sahur!",
                      "tgl": "08 Jan 2024"
                    }
                  ];
                  return ListView.separated(
                    //List view horizontal
                    itemCount: artikelKesehatan.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> item = artikelKesehatan[index];
                      return _informasiKesehatan(item);
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 25.0,
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        //Floating Action Button
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              30), // Mengatur bentuk lingkaran dengan borderRadius
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatPage()),
          );
        },
        backgroundColor: const Color.fromARGB(255, 1, 101, 252),
        child: const Icon(
          Icons.chat,
          color: Colors.white,
        ),
      ),
    );
  }
}

InkWell _informasiKesehatan(Map<String, dynamic> item) {
  //Atur tampilan list view
  return InkWell(
    onTap: () {},
    child: Container(
      width: 250,
      height: 170.0,
      margin: const EdgeInsets.only(bottom: 20, right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color.fromARGB(255, 255, 255, 255),
          border: Border.all(
              color: const Color.fromARGB(255, 198, 198, 198), width: 2),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(128, 158, 158, 158),
              spreadRadius: 0.5,
              blurRadius: 2,
              offset: Offset(1, 3),
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12)),
                child: Image.network(
                  item["img"],
                  fit: BoxFit.cover,
                  height: 120,
                  width: 250,
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: 2.0, // Tinggi garis border
                  color: Colors.black, // Warna garis border
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, top: 5),
            child: Text(
              item["judul"],
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              item["tgl"],
              style: const TextStyle(
                color: Colors.black,
                fontSize: 10,
              ),
            ),
          )
        ],
      ),
    ),
  );
}
