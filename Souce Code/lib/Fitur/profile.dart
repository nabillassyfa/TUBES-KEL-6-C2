import 'package:flutter/material.dart';
import 'syarat_dan_ketentuan.dart';
import 'kebijakan_privasi.dart';
import 'edit_biodata.dart';
import 'pengaturan.dart';
import 'pusat_bantuan.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0165fc),
        title: Row(
          children: [
            Icon(Icons.person),
            SizedBox(width: 8.0),
            Text(
              'Profil Saya',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.mail),
            onPressed: () {
              // Tindakan ketika tombol email ditekan
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              color: Color(0xff0165fc),
              height: 240,
              width: double.infinity,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 38,
                            backgroundImage: NetworkImage(
                                'https://images.pexels.com/photos/762020/pexels-photo-762020.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Celine Rodriguez',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.phone,
                                color: Colors.white,
                              ),
                              SizedBox(width: 4),
                              Text(
                                '081234567890',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.white,
                              ),
                              SizedBox(width: 4),
                              Text(
                                'Jln. Geger Kalong Girang,',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsetsDirectional.only(
                    start: 16,
                    end: 16,
                    top: 4,
                  ),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Biodata Saya',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Material(
                            type: MaterialType.transparency,
                            child: InkWell(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.edit,
                                    color: Color(0xff0165fc),
                                  ),
                                  Text(
                                    'Edit Biodata',
                                    style: TextStyle(
                                      color: Color(0xff0165fc),
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                        builder: (context) =>
                                            EditBiodataPage()));
                              },
                            ),
                          ),
                        ],
                      ),
                      Divider(thickness: 2, height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Gender : ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Wanita',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Berat Badan: ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '56 Kg',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Tinggi Badan: ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '154 Cm',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Umur : ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '35 Tahun',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Tanggal Lahir: ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '12/8/1989',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Golongan Darah : ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'A+',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsetsDirectional.all(16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Material(
                        type: MaterialType.transparency,
                        child: InkWell(
                          child: const Column(
                            children: [
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.settings,
                                        size: 32,
                                        color: Color(0xff0165fc),
                                      ),
                                      SizedBox(width: 16),
                                      Text(
                                        'Pengaturan',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 28,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                    builder: (context) => PengaturanPage()));
                          },
                        ),
                      ),
                      Divider(thickness: 2),
                      Material(
                        type: MaterialType.transparency,
                        child: InkWell(
                          child: const Column(
                            children: [
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.text_snippet,
                                        size: 32,
                                        color: Color(0xff0165fc),
                                      ),
                                      SizedBox(width: 16),
                                      Text(
                                        'Syarat & Ketentuan',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 28,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                    builder: (context) =>
                                        SyaratDanKetentuanPage()));
                          },
                        ),
                      ),
                      Divider(thickness: 2),
                      Material(
                        type: MaterialType.transparency,
                        child: InkWell(
                          child: const Column(
                            children: [
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.info,
                                        size: 32,
                                        color: Color(0xff0165fc),
                                      ),
                                      SizedBox(width: 16),
                                      Text(
                                        'Kebijakan Privasi',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 28,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                    builder: (context) =>
                                        KebijakanPrivasiPage()));
                          },
                        ),
                      ),
                      Divider(thickness: 2),
                      Material(
                        type: MaterialType.transparency,
                        child: InkWell(
                          child: const Column(
                            children: [
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.help,
                                        size: 32,
                                        color: Color(0xff0165fc),
                                      ),
                                      SizedBox(width: 16),
                                      Text(
                                        'Pusat Bantuan',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 28,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                    builder: (context) => PusatBantuanPage()));
                          },
                        ),
                      ),
                      Divider(thickness: 2),
                      Material(
                        type: MaterialType.transparency,
                        child: InkWell(
                          child: const Column(
                            children: [
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.logout,
                                        size: 32,
                                        color: Colors.red,
                                      ),
                                      SizedBox(width: 16),
                                      Text(
                                        'Keluar',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 28,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                            ],
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Konfirmasi'),
                                  content: Text(
                                      'Apakah Anda yakin ingin keluar akun?'),
                                  actions: [
                                    TextButton(
                                      child: Text('Batal'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Keluar'),
                                      onPressed: () {
                                        // Tambahkan logika untuk keluar akun di sini
                                        Navigator.of(context).pop();
                                        // Tambahkan logika untuk kembali ke halaman login atau halaman utama aplikasi
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
