import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'detail_dokter.dart';
import '../models/dataRS.dart';

class Doctor {
  final String name;
  final String imageUrl;
  final String specialization;
  final double rating;

  Doctor({
    required this.name,
    required this.imageUrl,
    required this.specialization,
    required this.rating,
  });
}

class PilihDokter extends StatefulWidget {
  const PilihDokter({
    Key? key,
    required this.data,
  }) : super(key: key);

  final RS data;

  @override
  State<PilihDokter> createState() => _PilihDokterState();
}

class _PilihDokterState extends State<PilihDokter> {
  final List<Doctor> doctors = [
    Doctor(
      name: 'dr. Muhammad Rifky Afandi, SpKj',
      imageUrl: 'assets/images/dokter-portrait.png',
      specialization: 'Spesialis Jiwa',
      rating: 4.8,
    ),
    Doctor(
      name: 'dr. Muhammad Rifky Afandi, SpKj',
      imageUrl: 'assets/images/dokter-portrait.png',
      specialization: 'Spesialis Kulit',
      rating: 4.5,
    ),
    // Add more doctors here
  ];

  final List<String> scheduleDays = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jum\'at',
    'Sabtu',
    'Minggu',
  ];
  int selectedDayIndex = -1;
  var selectedTime = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Dokter Spesialis ...',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.pin_drop,
                      size: 24,
                      color: Color(0xff0165fc),
                    ),
                    Text(
                      widget.data.nama,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                const Text(
                  'Pilih Jadwal',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 5,
                ),
              ],
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pilih Hari',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: (1 / .4),
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: scheduleDays.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedDayIndex = index;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.0),
                          borderRadius: BorderRadius.circular(8.0),
                          color: selectedDayIndex == index
                              ? Color(0xff0165fc)
                              : Colors.white,
                        ),
                        child: Text(
                          scheduleDays[index],
                          style: TextStyle(
                            color: selectedDayIndex == index
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 8),
                Text(
                  'Pilih Waktu',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.black, width: 1.0),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: selectedTime,
                      hint: Text('Select Time'),
                      items: [
                        DropdownMenuItem<String>(
                          value: '09.00',
                          child: Text('09.00'),
                        ),
                        DropdownMenuItem<String>(
                          value: '11.00',
                          child: Text('11.00'),
                        ),
                        DropdownMenuItem<String>(
                          value: '14.00',
                          child: Text('14.00'),
                        ),
                        DropdownMenuItem<String>(
                          value: '16.00',
                          child: Text('16.00'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedTime = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: doctors.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    switch (index) {
                      case 0:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailDokter()),
                        );
                        break;
                      case 1:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailDokter()),
                        );
                        break;
                      case 2:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailDokter()),
                        );
                        break;
                      case 3:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailDokter()),
                        );
                        break;
                      case 4:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailDokter()),
                        );
                        break;
                      case 5:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailDokter()),
                        );
                        break;
                      // Tambahkan case untuk ikon lainnya sesuai kebutuhan
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                doctors[index].imageUrl,
                                width: 60.0,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 12.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(doctors[index].name),
                                SizedBox(height: 4.0),
                                Text(doctors[index].specialization),
                                SizedBox(height: 4.0),
                                Row(
                                  children: [
                                    Icon(Icons.star,
                                        color: Colors.yellow, size: 16.0),
                                    SizedBox(width: 4.0),
                                    Text(doctors[index].rating.toString()),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
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
