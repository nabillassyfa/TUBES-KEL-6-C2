import 'package:flutter/material.dart';
import '../Fitur/pemeriksaanLabDetail.dart';

class PemeriksaanLab extends StatefulWidget {
  const PemeriksaanLab({Key? key}) : super(key: key);

  @override
  State<PemeriksaanLab> createState() => _PemeriksaanLabState();
}

class _PemeriksaanLabState extends State<PemeriksaanLab> {
  // Sample data for lab examinations
  final List<Map<String, dynamic>> labExams = [
    {
      'name': 'Complete Blood Count (CBC)',
      'category': 'Hematology',
      'price': 50000,
      'deskripsi':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod, nisl eget aliquam tincidunt, nisl nisl aliquam nisl, eget aliquam nisl nisl eget nisl.',
    },
    {
      'name': 'Lipid Profile',
      'category': 'Biochemistry',
      'price': 75000,
      'deskripsi':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod, nisl eget aliquam tincidunt, nisl nisl aliquam nisl, eget aliquam nisl nisl eget nisl.',
    },
    {
      'name': 'Liver Function Test (LFT)',
      'category': 'Biochemistry',
      'price': 80000,
      'deskripsi':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod, nisl eget aliquam tincidunt, nisl nisl aliquam nisl, eget aliquam nisl nisl eget nisl.',
    },
    {
      'name': 'Kidney Function Test (KFT)',
      'category': 'Biochemistry',
      'price': 90000,
      'deskripsi':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod, nisl eget aliquam tincidunt, nisl nisl aliquam nisl, eget aliquam nisl nisl eget nisl.',
    },
  ];

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
              child: ListView.builder(
                itemCount: labExams.length,
                itemBuilder: (context, index) {
                  final exam = labExams[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            exam['name'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text('${exam['category']}'),
                          const SizedBox(height: 16),
                          const Divider(
                            thickness: 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Rp. ${exam['price'].toStringAsFixed(0)}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PemeriksaanLabDetail(
                                              labExam: exam,
                                            )),
                                  );
                                },
                                child: const Text('Lihat Detail'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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