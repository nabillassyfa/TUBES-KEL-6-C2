import 'package:flutter/material.dart';

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
    Specialization(name: 'Cardiologist', icon: Icons.favorite),
    Specialization(name: 'Dermatologist', icon: Icons.accessibility_new),
    Specialization(name: 'Gynecologist', icon: Icons.pregnant_woman),
    Specialization(name: 'Pediatrician', icon: Icons.child_care),
    Specialization(name: 'Neurologist', icon: Icons.wifi),
    Specialization(name: 'Ophthalmologist', icon: Icons.remove_red_eye),
    Specialization(name: 'Orthopedic', icon: Icons.accessibility),
    Specialization(name: 'Psychiatrist', icon: Icons.mood),
    Specialization(name: 'Urologist', icon: Icons.person),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Image.asset(
            //logo
            'assets/images/banner.png',
            width: 400,
            height: 160,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                itemCount: specializations.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue,
                            ),
                            padding: EdgeInsets.all(10.0),
                            child: Icon(
                              specializations[index].icon,
                              size: 50.0,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Text(specializations[index].name),
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
