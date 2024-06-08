import 'package:flutter/material.dart';
import 'package:tp2/Fitur/pembayaran.dart';
import 'package:tp2/provider/p_jadwalDokter.dart';  
import 'package:intl/date_symbol_data_local.dart';
import 'package:tp2/provider/p_spesialis.dart';
import 'package:provider/provider.dart';

class BuatJanjiKonsulBefore extends StatefulWidget {
  @override
  State<BuatJanjiKonsulBefore> createState() => BuatJanjiKonsulBeforeState();
}

class BuatJanjiKonsulBeforeState extends State<BuatJanjiKonsulBefore> {
  int? selectedSpesialisId;
  String? selectedDay;
  String? selectedTime;
  int? selectedDokterId;
  String? selectedDokterName;

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id_ID', null).then((_) {
      Provider.of<SpesialisProvider>(context, listen: false).getdataSpesialis();
    });
  }

  void _fetchFilteredDokters(String? selectedDay, String? selectedTime, int? selectedSpesialisId) {
    if (selectedDay != null && selectedTime != null && selectedSpesialisId != null) {
      Provider.of<JadwalDokterProvider>(context, listen: false).getJadwalDaring(selectedDay, selectedTime, selectedSpesialisId);
    }
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 20), // Add spacing here
              Column(
                children: <Widget>[
                  Text(
                    "Video Call Dokter",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Center(
                    // Center the text
                    child: Text(
                      "Buat janji konsultasi online berdasarkan spesialis dan waktu yang Anda inginkan.",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[700],
                      ),
                      textAlign: TextAlign.center, // Center align the text
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40), // Add spacing here
              Consumer<SpesialisProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return CircularProgressIndicator();
                  }
                  if (provider.dataSpesialis.isEmpty) {
                    return Text("No Spesialis found");
                  }
                  return dropdownInput(
                    context: context,
                    label: "Pilih Spesialis",
                    hintText: "Semua Spesialis",
                    items: provider.dataSpesialis.map((spesialis) => spesialis.nama).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedSpesialisId = provider.dataSpesialis.firstWhere((spesialis) => spesialis.nama == value).id;
                        selectedDay = null;
                        selectedTime = null;
                        selectedDokterId = null;
                        selectedDokterName = null;
                        dateController.clear();
                        timeController.clear();
                        _fetchFilteredDokters(selectedDay, selectedTime, selectedSpesialisId);
                      });
                    },
                  );
                },
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Pilih Tanggal",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
                  ),
                  SizedBox(height: 10), // Jarak antara judul dan kotak tanggal
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          controller: dateController,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(Duration(days: 365)),
                            );
                            if (pickedDate != null) {
                              setState(() {
                                selectedDay = _formatDate(pickedDate);
                                dateController.text = selectedDay!;
                                _fetchFilteredDokters(selectedDay, selectedTime, selectedSpesialisId);
                              });
                            }
                          },
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: 'Pilih Tanggal',
                            suffixIcon: Icon(Icons.calendar_today, color: Color.fromARGB(255, 1, 101, 252),), // Icon kalender
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Pilih Waktu",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
                  ),
                  SizedBox(height: 10), // Jarak antara judul dan kotak waktu
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          controller: timeController,
                          onTap: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (pickedTime != null) {
                              setState(() {
                                selectedTime = "${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}";
                                timeController.text = selectedTime!;
                                _fetchFilteredDokters(selectedDay, selectedTime, selectedSpesialisId);
                              });
                            }
                          },
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: 'Pilih Waktu',
                            suffixIcon: Icon(Icons.access_time, color: Color.fromARGB(255, 1, 101, 252),), // Icon waktu
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Consumer<JadwalDokterProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return CircularProgressIndicator();
                  }
                  if (provider.data_Jadwal_dokter.isEmpty) {
                    return Text("No Dokters found");
                  }

                  // Extract unique doctor names using a Set
                  final uniqueDokterNames = provider.data_Jadwal_dokter.map((dokter) => dokter.nama).toSet().toList();

                  return dropdownInput(
                    context: context,
                    label: "Pilih Dokter",
                    hintText: "Pilih dokter",
                    items: uniqueDokterNames,
                    value: selectedDokterName,
                    onChanged: (value) {
                      setState(() {
                        selectedDokterName = value;
                        selectedDokterId = provider.data_Jadwal_dokter.firstWhere((dokter) => dokter.nama == value).id;
                      });
                    },
                  );
                },
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.only(top: 3, left: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () {
                    if (selectedDay != null && selectedTime != null && selectedSpesialisId != null && selectedDokterId != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Pembayaran()),
                      );
                    } else {
                      // Tampilkan peringatan jika ada variabel yang kosong
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Peringatan"),
                            content: Text("Silakan lengkapi semua informasi sebelum melanjutkan."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // Tutup dialog
                                },
                                child: Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  color: Color.fromARGB(255, 1, 101, 252),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    "Buat Janji Konsultasi Online",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30), // Add spacing to avoid overflow
            ],
          ),
        ),
      ),
    );
  }

 String _formatDate(DateTime date) {
  return "${_getDayName(date.weekday)}, ${date.day} ${_getMonthName(date.month)} ${date.year}";
}

  Widget dropdownInput({
    required BuildContext context,
    required String label,
    required String hintText,
    required List<String> items,
    String? value,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 10),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(),
          ),
          value: value,
          onChanged: onChanged,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
        ),
      ],
    );
  }
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