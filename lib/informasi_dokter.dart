import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Specialization {
  final String name;
  final IconData icon;

  Specialization({required this.name, required this.icon});
}

class SpecializationPage extends StatefulWidget {
  @override
  State<SpecializationPage> createState() => _SpecializationPageState();
}

class _SpecializationPageState extends State<SpecializationPage> {
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
            'Informasi Dokter',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Text(
            'Pilih spesialis dari dokter yang anda cari',
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                itemCount: specializations.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
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
                                builder: (context) => SpecializationPage()),
                          );
                          break;
                        case 3:
                          break;
                        case 4:
                          break;
                        case 5:
                          break;
                        // Tambahkan case untuk ikon lainnya sesuai kebutuhan
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffd3e6ff),
                            ),
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(
                              specializations[index].icon,
                              size: 50.0,
                              color: const Color(0xff0165fc),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Expanded(
                            child: Text(
                              specializations[index].name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SpecializationPage(),
  ));
}
