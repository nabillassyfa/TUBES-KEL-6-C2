// Harus memilih spesialis dulu lalu rs

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp2/Fitur/pembayaran.dart';
import 'package:tp2/provider/p_RS.dart';
import 'package:tp2/provider/p_spesialis.dart';

class BuatJanjiTemuBefore extends StatefulWidget {
  @override
  State<BuatJanjiTemuBefore> createState() => BuatJanjiTemuBeforeState();
}

class BuatJanjiTemuBeforeState extends State<BuatJanjiTemuBefore> {
  int? selectedSpesialisId;
  int? selectedRSId;

  @override
  void initState() {
    super.initState();
    Provider.of<SpesialisProvider>(context, listen: false).getdataSpesialis();
    
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
            color: Colors.black, // Mengubah warna ikon menjadi hitam
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center the content vertically
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
                    // Center the text
                    child: Text(
                      "Buat janji temu Anda berdasarkan spesialis dan waktu yang Anda inginkan.",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[700],
                      ),
                      textAlign: TextAlign.center, // Center align the text
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20), // Add spacing here
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
                        // Fetch Rumah Sakit based on selected Spesialis
                        Provider.of<RSProvider>(context, listen: false).getdataRSbySpesialis(selectedSpesialisId!);
                      });
                    },
                  );
                },
              ),
              SizedBox(height: 10), // Add spacing here
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
                      });
                    },
                  );
                },
              ),
              SizedBox(height: 10), // Add spacing here
              inputFile(
                  context: context,
                  label: "Pilih Tanggal",
                  hintText: "Hari, Tgl - Bln - Thn"),
              SizedBox(height: 10), // Add spacing here
              inputFile(
                  context: context,
                  label: "Pilih Waktu",
                  hintText: "00:00"),
              SizedBox(height: 10), // Add spacing here
              dropdownInput(
                  context: context,
                  label: "Pilih Dokter",
                  hintText: "Pilih dokter",
                  items: [
                    "Dr. John Doe",
                    "Dr. Jane Smith",
                    "Dr. Rifky Afandi",
                  ]),
              SizedBox(height: 50), // Add spacing here
              Container(
                padding: EdgeInsets.only(top: 3, left: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () {
                    // Navigasi ke halaman baru ketika tombol diklik
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
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20), // Add spacing here
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

// Widget untuk input field
Widget inputFile(
    {required BuildContext context,
    required String label,
    required String hintText,
    obscureText = false}) {
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
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
        controller: label == "Pilih Tanggal" ? dateController : timeController,
        obscureText: obscureText,
        onTap: () async {
          // Tambahkan penanganan onTap
          if (label == "Pilih Tanggal") {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(Duration(days: 365)),
            );
            if (pickedDate != null) {
              dateController.text = "${_formatDate(pickedDate)}";
            }
          } else if (label == "Pilih Waktu") {
            TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (pickedTime != null) {
              timeController.text =
                  "${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}";
            }
          }
        },
        readOnly: true, // Jadikan readOnly true
        decoration: InputDecoration(
          hintText: hintText, // Tambahkan hintText
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          suffixIcon: label == "Pilih Tanggal"
              ? Icon(Icons.calendar_today,
                  color: Color.fromARGB(255, 1, 101, 252))
              : (label == "Pilih Waktu"
                  ? Icon(Icons.access_time_filled_rounded,
                      color: Color.fromARGB(255, 1, 101, 252))
                  : null),
        ),
      ),
      SizedBox(height: 1),
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