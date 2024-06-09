import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tp2/models/metodePembayaran.dart';
import 'package:tp2/provider/p_infoUser.dart';
import 'package:tp2/provider/p_metodePembayaran.dart';
import 'pembayaranSukses.dart';

class Pembayaran extends StatefulWidget {
  final String itemNama;
  final String itemDeskripsi;
  String? itemDeskripsi2;
  final String itemLayanan;
  String? tanggal;
  String? waktu;
  final int biaya;

  Pembayaran({
    super.key,
    required this.itemNama,
    required this.itemDeskripsi,
    this.itemDeskripsi2,
    required this.itemLayanan,
    this.tanggal,
    this.waktu,
    required this.biaya,
  });

  @override
  State<Pembayaran> createState() => _PembayaranState();
}

class _PembayaranState extends State<Pembayaran> {
  InfoUserProvider? infoUserProvider;
  String? namaPasien;
  MetodePembayaranProvider? metodePembayaranProvider;
  MetodePembayaran? selectedMetodePembayaran;

  @override
  void initState() {
    super.initState();
    infoUserProvider = Provider.of<InfoUserProvider>(context, listen: false);
    infoUserProvider!.getdataInfoUser().then((_) {
      setState(() {
          namaPasien = infoUserProvider!.dataInfoUser.first.nama_lengkap;
          print(namaPasien);
      });
    });
    metodePembayaranProvider = Provider.of<MetodePembayaranProvider>(context, listen: false);
    metodePembayaranProvider!.getdataMetodePembayaran();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_circle_left_outlined,
            size: 40,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Center(
              child: Text(
                'Pembayaran',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              color: Color.fromARGB(255, 1, 101, 252),
              thickness: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Color.fromARGB(255, 1, 101, 252),
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Nama Pasien:',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(namaPasien ?? 'Loading...'),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 1, 101, 252),
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 4),
                          child: Center(
                            child: Text(
                              'Ringkasan Pembayaran',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          color: Color.fromARGB(255, 1, 101, 252),
                        ),
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.itemNama,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.itemDeskripsi2 != null
                                    ? '${widget.itemDeskripsi} - ${widget.itemDeskripsi2}'
                                    : widget.itemDeskripsi,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 10,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              widget.tanggal != null
                                  ? Text(
                                      'Tanggal : ${widget.tanggal}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 10,
                                      ),
                                    )
                                  : Container(),
                              widget.waktu != null
                                  ? Text(
                                      'Waktu   : ${widget.waktu}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 10,
                                      ),
                                    )
                                  : Container(),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Layanan: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 10,
                                    ),
                                  ),
                                  Text(
                                    widget.itemLayanan,
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Biaya Konsultasi: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 10,
                                    ),
                                  ),
                                  Text(
                                    '${NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 2).format(widget.biaya)}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                color: Color.fromARGB(255, 1, 101, 252),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total Pembayaran: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 10,
                                    ),
                                  ),
                                  Text(
                                    '${NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 2).format(widget.biaya)}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 1, 101, 252),
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Consumer<MetodePembayaranProvider>(
                              builder: (context, provider, child) {
                                if (provider.isLoading) {
                                  return Center(child: CircularProgressIndicator());
                                } else {
                                  return ListView.builder(
                                    itemCount: provider.dataMetodePembayaran.length,
                                    itemBuilder: (context, index) {
                                      MetodePembayaran metode = provider.dataMetodePembayaran[index];
                                      return ListTile(
                                        title: Text(metode.nama_pembayaran),
                                        onTap: () {
                                          setState(() {
                                            selectedMetodePembayaran = metode;
                                          });
                                          Navigator.pop(context);
                                        },
                                      );
                                    },
                                  );
                                }
                              },
                            );
                          },
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedMetodePembayaran != null
                                ? selectedMetodePembayaran!.nama_pembayaran
                                : 'Pilih Metode Pembayaran',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 92, 92, 92),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey[900],
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            selectedMetodePembayaran != null ?
            MaterialButton(
              minWidth: 380,
              height: 50,
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PembayaranSukses(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              color: Color.fromARGB(255, 1, 101, 252),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                "Konfirmasi",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ) : Text('Silahkan pilih metode pembayaran')
          ],
        ),
      ),
    );
  }
}
