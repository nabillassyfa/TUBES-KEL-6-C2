import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tp2/Fitur/bottomNavBar.dart';
import 'package:tp2/models/user.dart';
import 'package:tp2/provider/p_infoUser.dart';
import 'package:tp2/provider/p_user.dart';
import 'profile.dart';
import '../models/infoUser.dart';

class EditBiodataPage extends StatefulWidget {
  const EditBiodataPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  final InfoUser data;

  @override
  _EditBiodataPageState createState() => _EditBiodataPageState();
}

class _EditBiodataPageState extends State<EditBiodataPage> {
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _bloodTypeController;
  late TextEditingController _weightController;
  late TextEditingController _heightController;
  String? _selectedGender;
  DateTime? _selectedDateOfBirth;

  final List<String> _genderOptions = ['Laki-laki', 'Perempuan'];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.data.nama_lengkap);
    _addressController = TextEditingController(text: widget.data.alamat);
    _phoneNumberController = TextEditingController(text: widget.data.no_telp);
    _bloodTypeController =
        TextEditingController(text: widget.data.golongan_darah);
    _weightController =
        TextEditingController(text: widget.data.berat_badan.toString());
    _heightController =
        TextEditingController(text: widget.data.tinggi_badan.toString());
        _selectedGender = widget.data.jenis_kelamin;
        _selectedDateOfBirth = widget.data.tanggal_lahir;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();
    _bloodTypeController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  int _calculateAge() {
    if (_selectedDateOfBirth != null) {
      final now = DateTime.now();
      final age = now.year - _selectedDateOfBirth!.year;
      if (now.month < _selectedDateOfBirth!.month ||
          (now.month == _selectedDateOfBirth!.month &&
              now.day < _selectedDateOfBirth!.day)) {
        return age - 1;
      }
      return age;
    }
    return 0;
  }

  void test(){
    print('heyyy');
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDateOfBirth ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDateOfBirth) {
      setState(() {
        _selectedDateOfBirth = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
        title: Row(
          children: [
            Icon(
              Icons.edit,
              color: Colors.white,
            ),
            SizedBox(width: 8.0),
            Text(
              'Edit Biodata',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Color(0xff0165fc),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                child: CircleAvatar(
                  radius: 48,
                  backgroundColor: Colors.grey,
                  child: CircleAvatar(
                    radius: 46,
                    backgroundImage: NetworkImage(
                        widget.data.imageUrl),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.photo),
                    label: Text('Ganti Foto'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xff0165fc),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Nomor Telepon',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: _selectedGender,
                items: _genderOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedGender = newValue;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Jenis Kelamin',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _weightController,
                      decoration: InputDecoration(
                        labelText: 'Berat Badan',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: TextFormField(
                      controller: _heightController,
                      decoration: InputDecoration(
                        labelText: 'Tinggi Badan',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              InkWell(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Tanggal Lahir',
                    border: OutlineInputBorder(),
                  ),
                  child: Text(
                    _selectedDateOfBirth != null
                        ? DateFormat('dd-MM-yyyy').format(_selectedDateOfBirth!)
                        : 'Pilih Tanggal',
                    style: TextStyle(
                      fontSize: 16,
                      color: _selectedDateOfBirth != null
                          ? Colors.black
                          : Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Umur: ${_calculateAge()} tahun',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: TextFormField(
                      controller: _bloodTypeController,
                      decoration: InputDecoration(
                        labelText: 'Golongan Darah',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Container(
                height: 80.0, // Ubah nilai tinggi sesuai kebutuhan Anda
                child: TextFormField(
                  controller: _addressController,
                  maxLines: null, // Mengatur jumlah baris menjadi dinamis
                  decoration: InputDecoration(
                    labelText: 'Alamat',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                height: 60,
                child: ElevatedButton(
                  child: Text(
                    'Simpan Perubahan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xff0165fc),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          32.0), // Mengatur sudut melengkung menjadi 10.0
                    ),
                  ),
                  onPressed: () {
                  final updatedInfoUser = InfoUser(
                    id_user: widget.data.id_user,
                      id: widget.data.id,
                      alamat: _addressController.text,
                      jenis_kelamin: _selectedGender!,
                      umur: _calculateAge(),
                      golongan_darah: _bloodTypeController.text,
                      tanggal_lahir: _selectedDateOfBirth!,
                      berat_badan: double.parse(_weightController.text),
                      tinggi_badan: double.parse(_heightController.text),
                      foto: widget.data.foto
                    );
                    test();

                    Provider.of<InfoUserProvider>(context, listen: false)
                        .updateUserInfo(updatedInfoUser);
                  
                  final updatedUser = User(
                      id: widget.data.id,
                      nama: _nameController.text,
                      noTelp: _phoneNumberController.text,
                      username: widget.data.username!,
                      email: widget.data.email!
                    );

                    Provider.of<UserProvider>(context, listen: false)
                        .updateUserInfo(updatedUser);
                    // Simpan perubahan biodata ke tempat penyimpanan yang sesuai
                    // Misalnya, Anda dapat menggunakan metode penyimpanan data seperti SharedPreferences, SQLite, atau REST API untuk menyimpan biodata yang telah diedit.
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Konfirmasi'),
                          content: Text(
                              'Apakah Anda yakin ingin menyimpan perubahan?'),
                          actions: [
                            TextButton(
                              child: Text('Batal'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('Ubah'),
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const BottomNavBar(idx: 4),
                                  ),
                                  (Route<dynamic> route) => false,
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
