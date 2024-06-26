import 'package:flutter/material.dart';
import 'package:tp2/models/lab.dart';
import '../Fitur/pemeriksaanLabDetail.dart';
import 'package:provider/provider.dart';
import 'package:tp2/provider/p_lab.dart';

class PemeriksaanLab extends StatefulWidget {
  @override
  State<PemeriksaanLab> createState() => _PemeriksaanLabState();
}

class _PemeriksaanLabState extends State<PemeriksaanLab> {
  void initState() {
    super.initState();
    Provider.of<LabProvider>(context, listen: false).getdataLab();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Pemeriksaan Lab',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Consumer<LabProvider>(
                builder: (context, labProvider, child) {
                  final labExams = labProvider.dataLab;
                  return ListView.builder(
                    itemCount: labExams.length,
                    itemBuilder: (context, index) {
                      final exam = labExams[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.grey.shade400, width: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  exam.nama,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text('${exam.kategori}'),
                                const SizedBox(height: 16),
                                const Divider(
                                  thickness: 2,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Rp. ${exam.harga}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PemeriksaanLabDetail(
                                              labExam: exam,
                                            ),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xff0165fc),
                                        foregroundColor: Colors.white,
                                      ),
                                      child: const Text('Lihat Detail'),
                                    ),
                                  ],
                                ),
                              ],
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
      ),
    );
  }
}
