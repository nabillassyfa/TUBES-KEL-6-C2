import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tp2/models/jadwalPanggilDokter.dart';
import 'package:tp2/models/metodePembayaran.dart';
import 'package:tp2/provider/p_infoUser.dart';
import 'package:tp2/provider/p_jadwalJanjiTemu.dart';
import 'package:tp2/provider/p_jadwalPanggilDokter.dart';
import 'package:tp2/provider/p_jadwalVideoCall.dart';
import 'package:tp2/provider/p_metodePembayaran.dart';
import 'package:tp2/provider/p_pembayaran.dart';
import 'pembayaranSukses.dart';

class Pembayaran extends StatefulWidget {
  final String itemNama;
  final String itemDeskripsi;
  String? itemDeskripsi2;
  final String itemLayanan;
  String? tanggal;
  String? waktu;
  final int biaya;
  int? id_jadwal;
  String? unformattedDate;
  int? durasi;
  String? link_video_call;

  Pembayaran(
      {super.key,
      required this.itemNama,
      required this.itemDeskripsi,
      this.itemDeskripsi2,
      required this.itemLayanan,
      this.tanggal,
      this.waktu,
      required this.biaya,
      this.id_jadwal,
      this.unformattedDate,
      this.durasi,
      this.link_video_call});

  @override
  State<Pembayaran> createState() => _PembayaranState();
}

class _PembayaranState extends State<Pembayaran> {
  InfoUserProvider? infoUserProvider;
  String namaPasien = "";
  String alamat = "";
  MetodePembayaranProvider? metodePembayaranProvider;
  MetodePembayaran? selectedMetodePembayaran;
  bool isProcessing = false; // State to track loading state

  @override
  void initState() {
    super.initState();
    infoUserProvider = Provider.of<InfoUserProvider>(context, listen: false);
    infoUserProvider!.getdataInfoUser().then((_) {
      setState(() {
        namaPasien = infoUserProvider!.dataInfoUser.first.nama_lengkap!;
        alamat = infoUserProvider!.dataInfoUser.first.alamat;
        print(namaPasien);
        print(alamat);
        print(widget.id_jadwal);
        print(widget.itemLayanan);
      });
    });
    metodePembayaranProvider =
        Provider.of<MetodePembayaranProvider>(context, listen: false);
    metodePembayaranProvider!.getdataMetodePembayaran();
  }

  void _editAlamat() {
    TextEditingController _alamatController =
        TextEditingController(text: alamat);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Alamat'),
          content: TextField(
            controller: _alamatController,
            decoration: InputDecoration(hintText: "Alamat"),
          ),
          actions: [
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Simpan'),
              onPressed: () {
                setState(() {
                  alamat = _alamatController.text;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
            Icons.arrow_back_ios,
            size: 24,
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
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Divider(
              color: Color.fromARGB(255, 1, 101, 252),
              thickness: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Nama Pasien:',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        namaPasien,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  widget.itemLayanan == "Panggil Dokter"
                      ? Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Alamat:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    alamat,
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                    ),
                                    maxLines:
                                        null, // Allow the text to be multiline
                                    overflow: TextOverflow
                                        .visible, // Ensure the text overflows visibly
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: _editAlamat,
                                ),
                              ],
                            ),
                            Text(
                              'Pastikan untuk mengisi alamat dengan lengkap',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 231, 170, 1),
                                  fontSize: 12),
                              textAlign: TextAlign.left,
                            )
                          ],
                        )
                      : Container(),
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
                                fontSize: 16,
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
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                widget.itemDeskripsi2 != null
                                    ? '${widget.itemDeskripsi} - ${widget.itemDeskripsi2}'
                                    : widget.itemDeskripsi,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
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
                                        fontSize: 14,
                                      ),
                                    )
                                  : Container(),
                              widget.waktu != null
                                  ? Text(
                                      'Waktu   : ${widget.waktu}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14,
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
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    widget.itemLayanan,
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Biaya Konsultasi: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    '${NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 2).format(widget.biaya)}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                color: Color.fromARGB(255, 1, 101, 252),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total Pembayaran: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    '${NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 2).format(widget.biaya)}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14,
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
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  List<MetodePembayaran>
                                      filteredMetodePembayaran =
                                      provider.dataMetodePembayaran;
                                  if (widget.itemLayanan ==
                                          "Konsultasi Online" ||
                                      widget.itemLayanan == "Panggil Dokter") {
                                    filteredMetodePembayaran =
                                        filteredMetodePembayaran
                                            .where((metode) =>
                                                metode.nama_pembayaran !=
                                                "Bayar ditempat")
                                            .toList();
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 16.0),
                                    child: ListView.builder(
                                      itemCount:
                                          filteredMetodePembayaran.length,
                                      itemBuilder: (context, index) {
                                        MetodePembayaran metode =
                                            filteredMetodePembayaran[index];
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
                                    ),
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
            selectedMetodePembayaran != null
                ? isProcessing // Display loading indicator if processing

                    ? CircularProgressIndicator()
                    : Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: MaterialButton(
                          minWidth: 380,
                          height: 50,
                          onPressed: () async {
                            if (selectedMetodePembayaran != null) {
                              if (widget.itemLayanan == "Panggil Dokter" &&
                                  alamat == "") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Alamat tidak boleh kosong untuk layanan Panggil Dokter.'),
                                  ),
                                );
                                return;
                              }
                              setState(() {
                                isProcessing = true;
                              });
                              try {
                                // Post data pembayaran
                                await Provider.of<PembayaranProvider>(context,
                                        listen: false)
                                    .postdataPembayaran(
                                        selectedMetodePembayaran!
                                            .nama_pembayaran,
                                        widget.biaya,
                                        widget.itemLayanan);

                                // Post data jadwal janji temu
                                if (widget.id_jadwal != null &&
                                    widget.unformattedDate != null &&
                                    widget.waktu != null) {
                                  if (widget.itemLayanan == "Janji Temu") {
                                    await Provider.of<JadwalJanjiTemuProvider>(
                                            context,
                                            listen: false)
                                        .postdataJadwaljanjitemu(
                                            widget.id_jadwal!,
                                            widget.unformattedDate!,
                                            widget.durasi!);
                                  } else if (widget.itemLayanan ==
                                      "Konsultasi Online") {
                                    await Provider.of<JadwalVideoCallProvider>(
                                            context,
                                            listen: false)
                                        .postdataJadwalVideoCall(
                                            widget.id_jadwal!,
                                            widget.unformattedDate!,
                                            widget.durasi!,
                                            widget.link_video_call!);
                                  } else if (widget.itemLayanan ==
                                      "Panggil Dokter") {
                                    await Provider.of<
                                                JadwalPanggilDokterProvider>(
                                            context,
                                            listen: false)
                                        .postdataJadwalPanggilDokter(
                                            widget.id_jadwal!,
                                            widget.unformattedDate!,
                                            alamat);
                                  }
                                }

                                // Navigate to success screen
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PembayaranSukses(
                                      itemNama: widget.itemNama,
                                      itemDeskripsi: widget.itemDeskripsi,
                                      itemDeskripsi2: widget.itemDeskripsi2,
                                      itemLayanan: widget.itemLayanan,
                                      biaya: widget.biaya,
                                      pasien: namaPasien,
                                      tanggal: widget.tanggal,
                                      waktu: widget.waktu,
                                    ),
                                  ),
                                  (Route<dynamic> route) => false,
                                );
                              } catch (e) {
                                print('herupumi');
                                // Handle error
                              } finally {
                                setState(() {
                                  isProcessing = false;
                                });
                              }
                            }
                          },
                          color: Color.fromARGB(255, 1, 101, 252),
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
                        ),
                      )
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('Silahkan pilih metode pembayaran'),
                  ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
