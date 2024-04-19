import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'pilih_dokter.dart';

class Specialization {
  final String name;
  final IconData icon;

  Specialization({required this.name, required this.icon});
}

class Hospital {
  final String name;
  final String imageUrl;
  final String address;
  final String time;

  Hospital({
    required this.name,
    required this.imageUrl,
    required this.address,
    required this.time,
  });
}

class SpecializationPageSelectRS extends StatefulWidget {
  @override
  State<SpecializationPageSelectRS> createState() =>
      _SpecializationPageSelectRSState();
}

class _SpecializationPageSelectRSState
    extends State<SpecializationPageSelectRS> {
  final List<Specialization> specializations = [
    Specialization(name: 'Sp. Jantung', icon: Icons.favorite),
    Specialization(name: 'Sp. Kulit', icon: Icons.accessibility_new),
    Specialization(name: 'Sp. Kandungan', icon: Icons.pregnant_woman),
    Specialization(name: 'Sp. Anak', icon: Icons.child_care),
    Specialization(name: 'Sp. Saraf', icon: Icons.wifi),
    Specialization(name: 'Sp. Mata', icon: Icons.remove_red_eye),
    Specialization(name: 'Sp. Ortopedi', icon: Icons.accessibility),
    Specialization(name: 'Sp. Jiwa', icon: Icons.mood),
    Specialization(name: 'Sp. Urologi', icon: Icons.person),
    Specialization(name: 'Sp. THT', icon: Icons.hearing),
    Specialization(name: 'Sp. Kanker', icon: Icons.local_hospital),
    Specialization(name: 'Sp. Endokrin', icon: Icons.accessibility),
  ];

  final List<Hospital> hospitals = [
    Hospital(
      name: 'Rumah Sakit Doa Ibu A',
      imageUrl: 'assets/images/hospital.png',
      address: 'Jl. A.H. Nasution No.15',
      time: '10',
    ),
    Hospital(
      name: 'Rumah Sakit Doa Ibu B',
      imageUrl: 'assets/images/hospital.png',
      address: 'Jl. MH. Tamrin No.10',
      time: '18',
    ),
    Hospital(
      name: 'Rumah Sakit Doa Ibu C',
      imageUrl: 'assets/images/hospital.png',
      address: 'Jl. Dr. Setibaudi No.21',
      time: '27',
    ),
    // Tambahkan rumah sakit lainnya di sini
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            //logo
            'assets/images/banner.png',
            width: 400,
            height: 160,
          ),
          const SizedBox(height: 12),
          const Text(
            'Pilih Rumah Sakit',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Text(
            'Berikut Rumah Sakit yang tersedia Spesialis tersebut',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
            ),
            maxLines: 2, // Batas jumlah baris
            overflow: TextOverflow
                .ellipsis, // Menggunakan elipsis (...) jika teks melebihi batas
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: hospitals.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    // Tambahkan aksi yang ingin dilakukan saat card diklik di sini
                    switch (index) {
                      case 0:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PilihDokter()),
                        );
                        break;
                      case 1:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PilihDokter()),
                        );
                        break;
                      case 2:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PilihDokter()),
                        );
                        break;
                      case 3:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PilihDokter()),
                        );
                        break;
                      case 4:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PilihDokter()),
                        );
                        break;
                      case 5:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PilihDokter()),
                        );
                        break;
                      // Tambahkan case untuk ikon lainnya sesuai kebutuhan
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Card(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              bottomLeft: Radius.circular(8.0),
                            ),
                            child: Container(
                              width: 120,
                              height: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(hospitals[index].imageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        hospitals[index].name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      Text(
                                        'Address: ${hospitals[index].address}',
                                      ),
                                      Text(
                                        '${hospitals[index].time} Menit dari lokasi Anda saat ini',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        'Pilih',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff0165fc),
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SpecializationPageSelectRS(),
  ));
}
