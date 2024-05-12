import 'package:flutter/material.dart';
import 'profile.dart';

class EditBiodataPage extends StatefulWidget {
  final String name = 'Celine Rodriguez';
  final String address =
      'Jln. Geger Kalong Girang, Gg. Cempaka, Kec. Sukasari, Bandung';
  final String phoneNumber = '081234567890';
  final String gender = 'Wanita';
  final int age = 35;
  final String bloodType = 'A+';
  final DateTime dateOfBirth = DateTime(1989, 8, 12);
  final double weight = 56.2;
  final double height = 154.7;

  @override
  _EditBiodataPageState createState() => _EditBiodataPageState();
}

class _EditBiodataPageState extends State<EditBiodataPage> {
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _genderController;
  late TextEditingController _ageController;
  late TextEditingController _bloodTypeController;
  late TextEditingController _dateOfBirthController;
  late TextEditingController _weightController;
  late TextEditingController _heightController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _addressController = TextEditingController(text: widget.address);
    _phoneNumberController = TextEditingController(text: widget.phoneNumber);
    _genderController = TextEditingController(text: widget.gender);
    _ageController = TextEditingController(text: widget.age.toString());
    _bloodTypeController = TextEditingController(text: widget.bloodType);
    _dateOfBirthController =
        TextEditingController(text: widget.dateOfBirth.toString());
    _weightController = TextEditingController(text: widget.weight.toString());
    _heightController = TextEditingController(text: widget.height.toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();
    _genderController.dispose();
    _ageController.dispose();
    _bloodTypeController.dispose();
    _dateOfBirthController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Biodata'),
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
                        'https://images.pexels.com/photos/762020/pexels-photo-762020.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
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
              TextFormField(
                controller: _genderController,
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
              TextFormField(
                controller: _dateOfBirthController,
                decoration: InputDecoration(
                  labelText: 'Tanggal Lahir',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _ageController,
                      decoration: InputDecoration(
                        labelText: 'Umur',
                        border: OutlineInputBorder(),
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
                height: 40,
                child: ElevatedButton(
                  child: Text('Simpan Perubahan'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff0165fc),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          32.0), // Mengatur sudut melengkung menjadi 10.0
                    ),
                  ),
                  onPressed: () {
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                        builder: (context) => ProfilePage()));
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
