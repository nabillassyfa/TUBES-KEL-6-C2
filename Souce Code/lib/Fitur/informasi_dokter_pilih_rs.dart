import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'pilih_dokter.dart';
import '../widget/Rs_widget.dart';
import '../provider/P_RS.dart';
import 'package:provider/provider.dart';

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
  const SpecializationPageSelectRS({Key? key}) : super(key: key);
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
    return ChangeNotifierProvider(
      create: (context) => RSProvider()..getdataRS(),
      child: Scaffold(
        appBar: AppBar(),
        body: Consumer<RSProvider>(
          builder: (context, value, child) {
            return SingleChildScrollView(
              child: Column(
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
                  Container(
                    height: MediaQuery.of(context).size.height -
                        kToolbarHeight -
                        MediaQuery.of(context).padding.top -
                        MediaQuery.of(context).padding.bottom,
                    padding: const EdgeInsets.all(10),
                    child: ListView.builder(
                      itemCount: value.dataRS.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: RSWidget(
                            data: value.dataRS[index],
                            asal: "dokter",
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SpecializationPageSelectRS(),
  ));
}
