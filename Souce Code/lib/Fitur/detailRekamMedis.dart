import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../models/rekamMedis.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tp2/models/infoUser.dart';
import '../provider/p_infoUser.dart';

class DetailRekamMedis extends StatefulWidget {
  const DetailRekamMedis({
    Key? key,
    required this.data,
  }) : super(key: key);

  final RekamMedis data;

  @override
  State<DetailRekamMedis> createState() => _DetailRekamMedisState();
}

class _DetailRekamMedisState extends State<DetailRekamMedis> {
  late InfoUserProvider infoUserProvider;

  @override
  void initState() {
    super.initState();
    infoUserProvider = Provider.of<InfoUserProvider>(context, listen: false);
    infoUserProvider.getdataInfoUser();
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
    final DateFormat timeFormatter = DateFormat('HH:mm:ss');

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            size: 24,
            color: Colors.black,
          ),
        ),
        title: Text('Rekam Medis'),
      ),
      body: Consumer<InfoUserProvider>(
        builder: (context, infoUserProvider, child) {
          if (infoUserProvider.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final InfoUser user = infoUserProvider.dataInfoUser.single;
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(250, 206, 222,
                            245), // Latar belakang chat berwarna biru
                        border: Border.all(color: Color(0xff0165fc), width: 1),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.grey.withOpacity(0.5), // Warna bayangan
                            blurRadius: 2,
                            spreadRadius: 2,
                            offset: Offset(0, 2),
                          )
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Pasien : ',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.data.user_nama,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              'Alamat : ',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              user.alamat,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              'Umur : ',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              user.umur.toString() + 'Tahun',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              'Berat Badan : ',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              user.berat_badan.toString() + 'Kg',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              'Tinggi Badan : ',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              user.tinggi_badan.toString() + 'Cm',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              'Golongan Darah : ',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              user.golongan_darah,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Text(
                              widget.data.dokter_nama,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          widget.data.spesialis,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Text(
                              'Tanggal: ',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Text(
                              dateFormatter
                                  .format(widget.data.tanggal), //tanggal
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Waktu: ',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Text(
                              timeFormatter.format(widget.data.tanggal), //waktu
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        const Text(
                          'Keterangan : ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Container(
                          width: double.infinity,
                          height: 80,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey, width: 2),
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            widget.data.keterangan,
                            // style: TextStyle(color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Obat : ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Container(
                          width: double.infinity,
                          height: 80,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey, width: 2),
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            widget.data.obat,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'Catatan dokter : ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Container(
                          width: double.infinity,
                          height: 120,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey, width: 2),
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            widget.data.catatan_dokter,
                          ),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
