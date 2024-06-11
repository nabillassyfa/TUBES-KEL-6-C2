import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/p_rekamMedis.dart';
import '../widget/rekamMedis_widget.dart';

class RekamMedis extends StatefulWidget {
  @override
  State<RekamMedis> createState() => _RekamMedisState();
}

class _RekamMedisState extends State<RekamMedis> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => RekamMedisProvider()..getdataRekamMedis(context),
        child: Scaffold(body:
            Consumer<RekamMedisProvider>(builder: (context, value, child) {
          if (value.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Column(
                    children: [
                      const Text(
                        'Rekam Medis',
                        style: TextStyle(
                            fontSize: 36, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 300,
                        child: Text(
                          'Lihat rekam medis anda setelah melakukan konsultasi dengan dokter',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                          maxLines: 2, // Batas jumlah baris
                          overflow: TextOverflow
                              .ellipsis, // Menggunakan elipsis (...) jika teks melebihi batas
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: const Row(
                                children: [
                                  Icon(Icons.filter_list_alt),
                                  Text(
                                    'Filter',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Row(
                                children: [
                                  Icon(Icons.sort),
                                  Text(
                                    'Urutkan',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 500,
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 20),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xffd3e6ff),
                          border:
                              Border.all(color: Color(0xff0165fc), width: 1),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 2,
                              spreadRadius: 2,
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: value.dataRekamMedis.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: RMWidget(
                                      data: value.dataRekamMedis[index],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        })));
  }
}
