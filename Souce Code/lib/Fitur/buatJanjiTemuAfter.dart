import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp2/Fitur/pembayaran.dart';
import 'package:tp2/models/dokter.dart';
import 'package:tp2/models/jadwalDokter.dart';
import 'package:tp2/provider/p_jadwalDokter.dart';

class BuatJanjiTemuAfter extends StatefulWidget {
  final Dokter dokter;

  BuatJanjiTemuAfter({required this.dokter});

  @override
  State<BuatJanjiTemuAfter> createState() => _BuatJanjiTemuAfterState();
}

class _BuatJanjiTemuAfterState extends State<BuatJanjiTemuAfter> {
  late JadwalDokterProvider jadwalDokterProvider;
  DateTime? pickedDate;
  String? selectedTime;
  List<String> waktuGabung = [];

  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    jadwalDokterProvider = Provider.of<JadwalDokterProvider>(context, listen: false);
    jadwalDokterProvider.getdataJadwalDokterByDokterRS(widget.dokter.id, widget.dokter.id_rs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_circle_left_outlined,
            size: 40,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Buat Janji Temu",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Buat janji temu Anda berdasarkan spesialis dan waktu yang Anda inginkan.",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[700],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  inputFile(context: context, label: "Spesialis", hintText: "${widget.dokter.namaSpesialis}"),
                  SizedBox(height: 2),
                  inputFile(context: context, label: "Rumah Sakit", hintText: "${widget.dokter.namaRs}"),
                  SizedBox(height: 5),
                  inputFile(context: context, label: "Dokter", hintText: "${widget.dokter.nama}"),
                  SizedBox(height: 5),
                  inputFile(context: context, label: "Pilih Tanggal", hintText: "Hari, Tgl - Bln - Thn", hintTextColor: Colors.grey, controller: dateController),
                  SizedBox(height: 5),
                  pickedDate != null ? inputFile(context: context, label: "Pilih Waktu", hintText: "00:00", hintTextColor: Colors.grey, controller: timeController) : Container(),
                ],
              ),
              SizedBox(height: 40),
              Container(
                padding: EdgeInsets.only(top: 3, left: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Pembayaran()),
                    );
                  },
                  color: Color.fromARGB(255, 1, 101, 252),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    "Buat Janji Temu",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20), // Tambahkan SizedBox untuk menambahkan jarak
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk input field
  Widget inputFile({
    required BuildContext context,
    required String label,
    required String hintText,
    TextEditingController? controller,
    Color hintTextColor = Colors.black,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 1),
        TextFormField(
          controller: controller,
          onTap: () async {
            if (label == "Pilih Tanggal") {
              pickedDate = await _selectDate(context, jadwalDokterProvider.dataJadwalDokter);
              if (pickedDate != null) {
                setState(() {
                  controller?.text = "${_formatDate(pickedDate)}";
                  _updateWaktuGabung();
                });
              }
            } else if (label == "Pilih Waktu") {
              showTimePickerDialog(context);
            }
          },
          readOnly: true,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: hintTextColor), // Atur warna hintText
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            suffixIcon: label == "Pilih Tanggal"
                ? Icon(Icons.calendar_today, color: Color.fromARGB(255, 1, 101, 252))
                : (label == "Pilih Waktu"
                    ? Icon(Icons.access_time_filled_rounded, color: Color.fromARGB(255, 1, 101, 252))
                    : null),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Future<DateTime?> _selectDate(BuildContext context, List<JadwalDokter> jadwalDokter) async {
    DateTime? pickedDate;
    pickedDate = await showDatePicker(
      context: context,
      initialDate: null,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 31)),
      selectableDayPredicate: (DateTime date) {
        String dayName = _getDayName(date.weekday);
        return jadwalDokter.any((jadwal) => jadwal.hari == dayName);
      },
    );
    return pickedDate;
  }

  void _updateWaktuGabung() {
    List<JadwalDokter> filteredJadwal = jadwalDokterProvider.data_Jadwal_dokter
        .where((jadwal) => jadwal.hari == _getDayName(pickedDate?.weekday ?? 0))
        .toList();

    List<String> waktuMulai = filteredJadwal.map((jadwal) => jadwal.waktu_mulai).toList();
    List<String> waktuBerakhir = filteredJadwal.map((jadwal) => jadwal.waktu_berakhir).toList();

    waktuGabung.clear();
    for (int i = 0; i < waktuMulai.length; i++) {
      waktuGabung.add("${waktuMulai[i]} - ${waktuBerakhir[i]}");
    }

    if (waktuGabung.isNotEmpty) {
      selectedTime = waktuGabung[0];
      timeController.text = selectedTime!;
    } else {
      selectedTime = null;
      timeController.text = "";
    }
  }

  void showTimePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Pilih Waktu"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              DropdownButtonFormField<String>(
                value: selectedTime,
                onChanged: (value) {
                  setState(() {
                    selectedTime = value;
                    timeController.text = value!;
                  });
                  Navigator.of(context).pop();
                },
                items: waktuGabung.map((String waktu) {
                  return DropdownMenuItem<String>(
                    value: waktu,
                    child: Text(waktu),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) {
      return 'Belum dipilih';
    }
    return "${_getDayName(date.weekday)}, ${date.day} ${_getMonthName(date.month)} ${date.year}";
  }

  String _getDayName(int day) {
    switch (day) {
      case 1:
        return "Senin";
      case 2:
        return "Selasa";
      case 3:
        return "Rabu";
      case 4:
        return "Kamis";
      case 5:
        return "Jumat";
      case 6:
        return "Sabtu";
      case 7:
        return "Minggu";
      default:
        return "";
    }
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return "Januari";
      case 2:
        return "Februari";
      case 3:
        return "Maret";
      case 4:
        return "April";
      case 5:
        return "Mei";
      case 6:
        return "Juni";
      case 7:
        return "Juli";
      case 8:
        return "Agustus";
      case 9:
        return "September";
      case 10:
        return "Oktober";
      case 11:
        return "November";
      case 12:
        return "Desember";
      default:
        return "";
    }
  }
}
