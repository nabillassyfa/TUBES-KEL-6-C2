import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Fitur/pembayaran.dart';
import '../provider/P_RS.dart';
import '../models/dataRS.dart';

class PemeriksaanLabDetail extends StatefulWidget {
  final Map<String, dynamic> labExam;

  const PemeriksaanLabDetail({Key? key, required this.labExam})
      : super(key: key);

  @override
  State<PemeriksaanLabDetail> createState() => _PemeriksaanLabDetailState();
}

class _PemeriksaanLabDetailState extends State<PemeriksaanLabDetail> {
  String? selectedHospital;
  final RSProvider _rsProvider = RSProvider();

  @override
  void initState() {
    super.initState();
    _rsProvider.getdataRS();
  }

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
            ChangeNotifierProvider(
              create: (_) => _rsProvider,
              child: Consumer<RSProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const CircularProgressIndicator();
                  }
                  if (provider.dataRS.isEmpty) {
                    return const Text("No Rumah Sakit found");
                  }
                  return dropdownInput(
                    context: context,
                    label: "Pilih Rumah Sakit",
                    hintText: "Pilih Rumah Sakit",
                    items: provider.dataRS.map((rs) => rs.nama).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedHospital = value;
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 4),
            const Divider(
              thickness: 2,
            ),
            SizedBox(
              height: 4,
            ),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Pembayaran(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 1, 101, 252),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text('Pesan'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget dropdownInput({
    required BuildContext context,
    required String label,
    required String hintText,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        const SizedBox(height: 8.0),
        DropdownButtonFormField<String>(
          value: selectedHospital,
          hint: Text(hintText),
          items: items
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  ))
              .toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
