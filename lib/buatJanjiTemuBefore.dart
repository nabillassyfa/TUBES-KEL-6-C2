import 'package:flutter/material.dart';

class BuatJanjiTemuBefore extends StatefulWidget {
  @override
  State<BuatJanjiTemuBefore> createState() => BuatJanjiTemuBeforeState();
}

class BuatJanjiTemuBeforeState extends State<BuatJanjiTemuBefore> {
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
            color: Colors.blue, // Mengubah warna ikon menjadi biru
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center the content vertically
            children: <Widget>[
              SizedBox(height: 10), // Smaller spacing here
              Column(
                children: <Widget>[
                  Text(
                    "Buat Janji Temu",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
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
              SizedBox(height: 30), // Add spacing here
              Column(
                children: <Widget>[
                  dropdownInput(
                      context: context,
                      label: "Pilih Spesialis",
                      items: [
                        "Spesialis Jantung",
                        "Spesialis Kulit",
                        "Spesialis Kandungan",
                        "Spesialis Anak",
                        "Spesialis Saraf",
                        "Spesialis Mata",
                        "Spesialis Ortopedi",
                        "Spesialis Jiwa",
                        "Spesialis Urologi",
                        "Spesialis THT",
                        "Spesialis Kanker",
                        "Spesialis Endokrin",
                      ]),
                  SizedBox(height: 10), // Add spacing here
                  dropdownInput(
                      context: context,
                      label: "Pilih Rumah Sakit",
                      items: [
                        "Rumah Sakit Doa Ibu A",
                        "Rumah Sakit Doa Ibu B",
                        "Rumah Sakit Doa Ibu C",
                      ]),
                  SizedBox(height: 10), // Add spacing here
                  inputFile(context: context, label: "Pilih Tanggal"),
                  SizedBox(height: 10), // Add spacing here
                  inputFile(context: context, label: "Pilih Waktu"),
                  SizedBox(height: 10), // Add spacing here
                  dropdownInput(context: context, label: "Pilih Dokter", items: [
                    "Dr. John Doe",
                    "Dr. Jane Smith",
                    "Dr. Rifky Afandi",
                  ]),
                ],
              ),
              SizedBox(height: 40), // Add spacing here
              Container(
                padding: EdgeInsets.only(top: 3, left: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () {},
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
            ],
          ),
        ),
      ),
    );
  }
}

// Widget untuk dropdown input
Widget dropdownInput(
    {required BuildContext context,
    required String label,
    required List<String> items}) {
  String hintText = '$label'; // Tambahkan hintText berdasarkan label
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      SizedBox(height: 1),
      DropdownButtonFormField(
        value: null, // Ubah nilai default menjadi null
        hint: Text(hintText), // Tambahkan hintText
        items: items.map((String value) {
          return DropdownMenuItem(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          // Handle dropdown value change
        },
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
      SizedBox(height: 1),
    ],
  );
}

// Widget untuk input field
Widget inputFile({required BuildContext context, label, obscureText = false}) {
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  String hintText = '$label'; // Tambahkan hintText berdasarkan label
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: TextStyle(
          fontSize: 11,
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
