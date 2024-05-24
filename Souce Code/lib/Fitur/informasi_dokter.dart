import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui';
import 'package:provider/provider.dart';
import '../provider/p_spesialis.dart';
import '../widget/spesialis.dart';

class SpecializationPage extends StatefulWidget {
  @override
  _SpecializationPageState createState() => _SpecializationPageState();
}

class _SpecializationPageState extends State<SpecializationPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SpesialisProvider()..getdataSpesialis(),
      child: Scaffold(
        appBar: AppBar(),
        body: Consumer<SpesialisProvider>(
          builder: (context, value, child) {
            if (value.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
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
                        itemCount: value.dataSpesialis.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1.0,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: SpesialisWidget(data: value.dataSpesialis[index]),
                          );
                        }
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
