import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tp2/models/jadwalLab.dart';
import '../Fitur/pembayaran.dart';
import '../provider/p_lab.dart';
import '../provider/p_RS.dart';
import 'package:tp2/models/lab.dart';

class PemeriksaanLabDetail extends StatefulWidget {
  final Lab labExam;

  PemeriksaanLabDetail({required this.labExam});

  @override
  State<PemeriksaanLabDetail> createState() => _PemeriksaanLabDetailState();
}

class _PemeriksaanLabDetailState extends State<PemeriksaanLabDetail> {
  late LabProvider jadwalLabProvider;
  DateTime? pickedDate;
  List<String> waktuGabung = [];
  int? selectedRSId;
  String? selectedDay;
  String? selectedTime;
  int? selectedLabId;
  String? selectedHospital;
  int? selectedJadwalId;

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedLabId = widget.labExam.id;
    initializeDateFormatting('id_ID', null);
    // Ensure selectedRSId has a value before fetching data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RSProvider>(context, listen: false)
          .getdataRsByLab(selectedLabId!);
    });
  }

  void _fetchFilteredLab(int? selectedRSId, int? selectedLabId) {
    if (selectedRSId != null && selectedLabId != null) {
      Provider.of<LabProvider>(context, listen: false)
          .getdataLabByRs(selectedRSId, selectedLabId);
    }
  }

  @override
  Widget build(BuildContext context) {
    jadwalLabProvider = Provider.of<LabProvider>(context);

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.labExam.nama,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Kategori: ${widget.labExam.kategori}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Deskripsi:',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${widget.labExam.deskripsi}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 36,
              ),
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
                        selectedHospital = value;
                        selectedRSId = provider.dataRS
                            .firstWhere((rs) => rs.nama == value)
                            .id;
                        _fetchFilteredLab(selectedRSId, selectedLabId);
                      });
                    },
                  );
                },
              ),
              SizedBox(height: 5),
              inputFile(
                  context: context,
                  label: "Pilih Tanggal",
                  hintText: "Hari, Tgl - Bln - Thn",
                  hintTextColor: Colors.grey,
                  controller: dateController),
              SizedBox(height: 5),
              pickedDate != null
                  ? inputFile(
                      context: context,
                      label: "Pilih Waktu",
                      hintText: "00:00",
                      hintTextColor: Colors.grey,
                      controller: timeController)
                  : Container(),
              const SizedBox(height: 4),
              const Divider(
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Harga: Rp. ${widget.labExam.harga}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (pickedDate != null && selectedHospital != null)
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Pembayaran(
                                itemNama: widget.labExam.nama,
                                itemDeskripsi: widget.labExam.deskripsi,
                                itemLayanan: widget.labExam.kategori,
                                biaya: int.parse(
                                    widget.labExam.harga.replaceAll('.', '')),
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 1, 101, 252),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text('Pesan'),
                      ),
                    if (pickedDate == null || selectedHospital == null)
                      Text('Isi form untuk memesan!'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<DateTime?> _selectDate(
      BuildContext context, List<JadwalLab> jadwalLab) async {
    DateTime? pickedDate;
    pickedDate = await showDatePicker(
      context: context,
      initialDate: null,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 31)),
      selectableDayPredicate: (DateTime date) {
        String dayName = _getDayName(date.weekday);
        return jadwalLab.any((jadwal) => jadwal.hari == dayName);
      },
    );
    return pickedDate;
  }

  void _updateWaktuGabung() {
    List<JadwalLab> filteredJadwal = jadwalLabProvider.dataJadwalLab
        .where((jadwal) => jadwal.hari == _getDayName(pickedDate?.weekday ?? 0))
        .toList();

    List<String> waktuMulai =
        filteredJadwal.map((jadwal) => jadwal.waktu_mulai).toList();
    List<String> waktuBerakhir =
        filteredJadwal.map((jadwal) => jadwal.waktu_berakhir).toList();

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
                    int index = waktuGabung.indexOf(value!);
                    selectedJadwalId =
                        jadwalLabProvider.dataJadwalLab[index].id;
                    timeController.text = value;
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
              pickedDate =
                  await _selectDate(context, jadwalLabProvider.dataJadwalLab);
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
                ? Icon(Icons.calendar_today,
                    color: Color.fromARGB(255, 1, 101, 252))
                : (label == "Pilih Waktu"
                    ? Icon(Icons.access_time_filled_rounded,
                        color: Color.fromARGB(255, 1, 101, 252))
                    : null),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
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
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
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
}
