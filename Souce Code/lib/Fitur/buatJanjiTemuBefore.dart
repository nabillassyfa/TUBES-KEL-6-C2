import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp2/Fitur/pembayaran.dart';
import 'package:tp2/provider/p_RS.dart';
import 'package:tp2/provider/p_spesialis.dart';
import 'package:tp2/provider/p_jadwalDokter.dart';  
import 'package:intl/date_symbol_data_local.dart';

class BuatJanjiTemuBefore extends StatefulWidget {
  @override
  State<BuatJanjiTemuBefore> createState() => BuatJanjiTemuBeforeState();
}

class BuatJanjiTemuBeforeState extends State<BuatJanjiTemuBefore> {
  int? selectedSpesialisId;
  int? selectedRSId;
  String? selectedDay;
  String? selectedTime;
  int? selectedDokterId;

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id_ID', null).then((_) {
      Provider.of<SpesialisProvider>(context, listen: false).getdataSpesialis();
    });
  }

  void _fetchFilteredDokters(int? selectedRSId, String? selectedDay, String? selectedTime, int? selectedSpesialisId) {
    if (selectedRSId != null && selectedDay != null && selectedTime != null && selectedSpesialisId != null) {
      Provider.of<JadwalDokterProvider>(context, listen: false).getFilteredDokters(selectedRSId, selectedDay, selectedTime, selectedSpesialisId);
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
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "Buat Janji Temu",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: Text(
                      "Buat janji temu Anda berdasarkan spesialis dan waktu yang Anda inginkan.",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[700],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
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
                        selectedRSId = null;
                        selectedDay = null;
                        selectedTime = null;
                        selectedDokterId = null;
                        dateController.clear();
                        timeController.clear();
                        Provider.of<RSProvider>(context, listen: false).getdataRSbySpesialis(selectedSpesialisId!);
                         _fetchFilteredDokters(selectedRSId, selectedDay, selectedTime, selectedSpesialisId);
                      });
                    },
                  );
                },
              ),
              SizedBox(height: 10),
              Consumer<RSProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return CircularProgressIndicator();
                  }
                  if (provider.dataRS.isEmpty) {
                    return Text("No Rumah Sakit found");
                  }
                  return dropdownInput(
                    context: context,
                    label: "Pilih Rumah Sakit",
                    hintText: "Pilih Rumah Sakit",
                    items: provider.dataRS.map((rs) => rs.nama).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedRSId = provider.dataRS.firstWhere((rs) => rs.nama == value).id;
                        _fetchFilteredDokters(selectedRSId, selectedDay, selectedTime, selectedSpesialisId);
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
                  SizedBox(height: 5), // Jarak antara judul dan kotak tanggal
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
                                _fetchFilteredDokters(selectedRSId, selectedDay, selectedTime, selectedSpesialisId);
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
                  SizedBox(height: 5), // Jarak antara judul dan kotak waktu
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
                                _fetchFilteredDokters(selectedRSId, selectedDay, selectedTime, selectedSpesialisId);
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
                  return dropdownInput(
                    context: context,
                    label: "Pilih Dokter",
                    hintText: "Pilih dokter",
                    items: provider.data_Jadwal_dokter.map((dokter) => dokter.nama).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedDokterId = provider.data_Jadwal_dokter.firstWhere((dokter) => dokter.nama == value).id;
                      });
                    },
                  );
                },
              ),
              SizedBox(height: 50),
              Container(
                padding: EdgeInsets.only(top: 3, left: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () {
                    if (selectedRSId != null && selectedDay != null && selectedTime != null && selectedSpesialisId != null && selectedDokterId != null) {
                      final selectedDokter = Provider.of<JadwalDokterProvider>(context, listen: false).data_Jadwal_dokter.firstWhere((dokter) => dokter.id == selectedDokterId);
                      final selectedSpesialis = Provider.of<SpesialisProvider>(context, listen: false).dataSpesialis.firstWhere((spesialis) => spesialis.id == selectedSpesialisId);
                      final selectedRS = Provider.of<RSProvider>(context, listen: false).data_RS.firstWhere((RS) => RS.id == selectedRSId);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Pembayaran(
                                itemNama: selectedDokter.nama,
                                itemDeskripsi: selectedSpesialis.nama,
                                itemDeskripsi2: selectedRS.nama,
                                itemLayanan: 'Janji Temu',
                                biaya: 400000,
                                tanggal: selectedDay!,
                                waktu: selectedTime!,
                              
                            ),
                          ),
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
                    "Buat Janji Temu",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget untuk dropdown input
Widget dropdownInput({
  required BuildContext context,
  required String label,
  required String hintText,
  required List<String> items,
  void Function(String?)? onChanged,
}) {
  String? selectedValue;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      SizedBox(height: 5),
      DropdownButtonFormField<String>(
        isExpanded: true,
        value: selectedValue,
        hint: Text(hintText),
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 10,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    ],
  );
}

String _formatDate(DateTime date) {
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