import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp2/provider/p_dokter.dart';
import 'detail_dokter.dart';
import '../models/dataRS.dart';

class PilihDokter extends StatefulWidget {
  const PilihDokter({
    Key? key,
    required this.dataRS,
    required this.idSpesialis,
  }) : super(key: key);

  final RS dataRS;
  final int idSpesialis;

  @override
  State<PilihDokter> createState() => _PilihDokterState();
}

class _PilihDokterState extends State<PilihDokter> {
  final List<String> scheduleDays = [
    "Senin",
    "Selasa",
    "Rabu",
    "Kamis",
    "Jumat",
    "Sabtu",
    "Minggu",
  ];
  int selectedDayIndex = -1;
  String selectedDay = "";

  @override
  void initState() {
    super.initState();
    _loadDokter();
  }

  void _loadDokter() {
    final dokterProvider = Provider.of<DokterProvider>(context, listen: false);
    if (selectedDay.isEmpty) {
      print(widget.dataRS.id);
      print(widget.idSpesialis);
      dokterProvider.getdataDokterbyRSSpesialis(
          widget.dataRS.id, widget.idSpesialis);
    } else {
      print(selectedDay);
      dokterProvider.getdataDokterbyJadwal(
          widget.dataRS.id, widget.idSpesialis, selectedDay);
    }
  }

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
                Row(
                  children: [
                    Icon(
                      Icons.pin_drop,
                      size: 24,
                      color: Color(0xff0165fc),
                    ),
                    Text(
                      widget.dataRS.nama,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                const Text(
                  'Pilih Jadwal',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                  color: Colors.grey, width: 1.0), // Added gray border
              boxShadow: [
                BoxShadow(
                  color:
                      Colors.grey.withOpacity(0.3), // Reduced opacity of shadow
                  spreadRadius: 2, // Reduced spread radius
                  blurRadius: 4, // Reduced blur radius
                  offset: Offset(0, 2), // Moved shadow slightly downwards
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
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: (0.75 / .25),
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: scheduleDays.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedDayIndex = index;
                          selectedDay = scheduleDays[index];
                          _loadDokter();
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
              ],
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: Consumer<DokterProvider>(
              builder: (context, dokterProvider, _) {
                if (dokterProvider.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                if (dokterProvider.dataDokter.isEmpty) {
                  return Center(child: Text("Tidak ada data dokter."));
                }

                return ListView.builder(
                  itemCount: dokterProvider.dataDokter.length,
                  itemBuilder: (context, index) {
                    final dokter = dokterProvider.dataDokter[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailDokter(dokter: dokter),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Card(
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        dokter.imageUrl,
                                        width: 60.0,
                                        height: 80.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(width: 12.0),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            dokter.nama,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(dokter.namaSpesialis),
                                          SizedBox(height: 8.0),
                                          Row(
                                            children: [
                                              Icon(Icons.star,
                                                  color: Colors.yellow),
                                              Icon(Icons.star,
                                                  color: Colors.yellow),
                                              Icon(Icons.star,
                                                  color: Colors.yellow),
                                              Icon(Icons.star,
                                                  color: Colors.yellow),
                                              Icon(Icons.star_border,
                                                  color: Colors.yellow),
                                            ],
                                          ),
                                        ],
                                      ),
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
