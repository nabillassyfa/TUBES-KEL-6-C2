import 'package:flutter/material.dart';

class PemeriksaanLabDetail extends StatefulWidget {
  final Map<String, dynamic> labExam;

  const PemeriksaanLabDetail({Key? key, required this.labExam})
      : super(key: key);

  @override
  State<PemeriksaanLabDetail> createState() => _PemeriksaanLabDetailState();
}

class _PemeriksaanLabDetailState extends State<PemeriksaanLabDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.labExam['name'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Kategori: ${widget.labExam['category']}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Deskripsi:',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${widget.labExam['deskripsi']}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Harga: Rp. ${widget.labExam['price'].toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle 'Beli' button press
                  },
                  child: const Text('Beli'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
