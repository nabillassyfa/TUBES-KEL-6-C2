import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tp2/Fitur/InfoRS.dart';
import 'package:tp2/Fitur/Notif.dart';
import 'package:tp2/Fitur/tahapRawatJalan.dart';
import 'package:tp2/Fitur/panggilDokter.dart';
import 'package:tp2/models/artikel.dart';
import 'package:tp2/models/infoUser.dart';
import '../Fitur/bottomNavBar.dart';
import '../Fitur/emergency.dart';
import '../Fitur/chat_dokter.dart';
import '../Fitur/informasi_dokter.dart';
import '../Fitur/pemeriksaanLab.dart';
import '../Fitur/buatJanjiKonsulBefore.dart';
import '../Fitur/buatJanjiTemuBefore.dart';
import '../widget/Artikel_widget.dart';
import '../provider/P_Artikel.dart';
import '../provider/p_infoUser.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Beranda extends StatefulWidget {
  const Beranda({Key? key}) : super(key: key);

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  late InfoUserProvider infoUserProvider;

  @override
  void initState() {
    super.initState();
    infoUserProvider = Provider.of<InfoUserProvider>(context, listen: false);
    infoUserProvider.getdataInfoUser();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ArtikelProvider()..getdataArtikel(),
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          flexibleSpace: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  width: 40,
                  height: 40,
                ),
                const SizedBox(width: 4),
                const Text(
                  'DIHospital',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          toolbarHeight: 70,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Material(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BottomNavBar(idx: 4),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color.fromARGB(255, 1, 101, 252),
                                width: 2,
                              ),
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                "assets/images/celine.png",
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Consumer<InfoUserProvider>(
                            builder: (context, infoUserProvider, child) {
                              if (infoUserProvider.isLoading) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              final InfoUser user =
                                  infoUserProvider.dataInfoUser.single;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user.nama_lengkap,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        user.jenis_kelamin == 'Laki-laki'
                                            ? Icons.male
                                            : Icons.female,
                                        color: user.jenis_kelamin == 'Laki-laki'
                                            ? Colors.blue
                                            : Colors.pink,
                                      ),
                                      Text(
                                        user.jenis_kelamin == 'Laki-laki'
                                            ? 'Pria'
                                            : 'Wanita',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Material(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Emergency(),
                                barrierDismissible: true,
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            width: 84,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromARGB(255, 255, 62, 62),
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4)),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Darurat',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 62, 62),
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(width: 4),
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
                      Stack(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.notifications,
                              size: 35,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Notif(),
                                  barrierDismissible: true,
                                ),
                              );
                            },
                          ),
                          Positioned(
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
                                  strokeAlign: BorderSide.strokeAlignOutside,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              Divider(
                thickness: 2,
                color: Colors.black,
              ),
              const Padding(
                //Teks layanan
                padding: EdgeInsets.only(bottom: 5),
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
                        {
                          "icon": Icons.video_call,
                          "label": "Video Call Dokter"
                        },
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
                        itemBuilder: (BuildContext context, int index) {
                          final item = menuImage[index];
                          return GestureDetector(
                            onTap: () {
                              // Implement navigation logic here
                              switch (index) {
                                case 0:
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BuatJanjiTemuBefore()),
                                  );
                                  break;
                                case 1:
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => InfoRS()),
                                  );
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PemeriksaanLab()),
                                  );
                                  break;
                                case 4:
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BuatJanjiKonsulBefore()),
                                  );
                                  break;
                                case 5:
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatPage()),
                                  );
                                  break;
                                case 6:
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PanggilDokter()),
                                  );
                                  break;
                                // Add cases for other menu items
                              }
                            },
                            child: Column(
                              children: [
                                Expanded(
                                  child: Icon(
                                    item["icon"],
                                    size: 40,
                                    color:
                                        const Color.fromARGB(255, 1, 101, 252),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  item["label"],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
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
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TahapRawatJalan(),
                              barrierDismissible:
                                  true), // Ganti HalamanTujuan dengan halaman yang ingin dituju
                        );
                      },
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
                height: 16,
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 5, top: 10),
                child: Text(
                  "Informasi Kesehatan",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Consumer<ArtikelProvider>(
                builder: (context, value, child) {
                  if (value.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Container(
                    height: 200,
                    margin: const EdgeInsets.only(right: 10),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                      ),
                      items: value.dataArtikel.map((item) {
                        return _informasiKesehatan(context, item);
                      }).toList(),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
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
      ),
    );
  }
}

// Function for displaying health information card
InkWell _informasiKesehatan(BuildContext context, Artikel item) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Berita_widget(
            data: item,
          ),
          barrierDismissible: true,
        ),
      );
    },
    child: Container(
      width: 250,
      height: 170.0,
      margin: const EdgeInsets.only(bottom: 20, right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color.fromARGB(255, 255, 255, 255),
        border: Border.all(
          color: const Color.fromARGB(255, 198, 198, 198),
          width: 2,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(128, 158, 158, 158),
            spreadRadius: 0.5,
            blurRadius: 2,
            offset: Offset(1, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12)),
                child: Image.network(
                  item.image,
                  width: 250,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12)),
                  ),
                  child: Text(
                    DateFormat('dd MMM yyyy').format(item.tanggal),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item.judul,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
