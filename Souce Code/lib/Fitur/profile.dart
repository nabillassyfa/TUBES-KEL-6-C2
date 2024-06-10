import 'package:flutter/material.dart';
import 'package:tp2/Fitur/syarat_dan_ketentuan.dart';
import 'package:tp2/Fitur/kebijakan_privasi.dart';
import 'package:tp2/Fitur/edit_biodata.dart';
import 'package:tp2/Fitur/pengaturan.dart';
import 'package:tp2/Fitur/pusat_bantuan.dart';
import 'package:tp2/Fitur/login.dart';
import 'package:tp2/models/infoUser.dart';
import '../provider/p_infoUser.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late InfoUserProvider infoUserProvider;

  @override
  void initState() {
    super.initState();
    infoUserProvider = Provider.of<InfoUserProvider>(context, listen: false);
    infoUserProvider.getdataInfoUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xff0165fc),
        title: Row(
          children: [
            Icon(
              Icons.person,
              color: Colors.white,
            ),
            SizedBox(width: 8.0),
            Text(
              'Profil Saya',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
      body: Consumer<InfoUserProvider>(
        builder: (context, infoUserProvider, child) {
          if (infoUserProvider.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final InfoUser user = infoUserProvider.dataInfoUser.single;
          return SingleChildScrollView(
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
                                    user.imageUrl),
                              ),
                            ),
                          ),
                          SizedBox(width: 4),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.nama_lengkap!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
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
                                    user.no_telp!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
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
                                  if (user.alamat != '')
                                    Text(
                                      user.alamat,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  if (user.alamat == '')
                                    Text(
                                      'Belum di set',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
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
                                                EditBiodataPage(data: user)));
                                  },
                                ),
                              ),
                            ],
                          ),
                          Divider(thickness: 2, height: 14),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Gender : ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  if (user.jenis_kelamin != '')
                                    Text(
                                      user.jenis_kelamin.toString(),
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  if (user.jenis_kelamin == '')
                                    Text(
                                      'Belum di set',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Berat Badan: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  if (user.berat_badan != 0)
                                    Text(
                                      user.berat_badan.toString() + ' Kg',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  if (user.berat_badan == 0)
                                    Text(
                                      'Belum di set',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Tinggi Badan: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  if (user.tinggi_badan != 0)
                                    Text(
                                      user.tinggi_badan.toString() + ' Cm',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  if (user.tinggi_badan == 0)
                                    Text(
                                      'Belum di set',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Umur : ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  if (user.umur != 0)
                                    Text(
                                      user.umur.toString() + ' Tahun',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  if (user.umur == 0)
                                    Text(
                                      'Belum di set',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Tanggal Lahir: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                     DateFormat('dd-MM-yyyy').format(user.tanggal_lahir!),
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Golongan Darah : ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  if (user.golongan_darah != '')
                                    Text(
                                      user.golongan_darah.toString(),
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  if (user.golongan_darah == '')
                                    Text(
                                      'Belum di set',
                                      style: TextStyle(fontSize: 14),
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
                                  SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.settings,
                                            size: 24,
                                            color: Color(0xff0165fc),
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'Pengaturan',
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 24,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                        builder: (context) =>
                                            PengaturanPage()));
                              },
                            ),
                          ),
                          Divider(),
                          Material(
                            type: MaterialType.transparency,
                            child: InkWell(
                              child: const Column(
                                children: [
                                  SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.text_snippet,
                                            size: 24,
                                            color: Color(0xff0165fc),
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'Syarat & Ketentuan',
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 24,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
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
                          Divider(),
                          Material(
                            type: MaterialType.transparency,
                            child: InkWell(
                              child: const Column(
                                children: [
                                  SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.info,
                                            size: 24,
                                            color: Color(0xff0165fc),
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'Kebijakan Privasi',
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 24,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
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
                          Divider(),
                          Material(
                            type: MaterialType.transparency,
                            child: InkWell(
                              child: const Column(
                                children: [
                                  SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.help,
                                            size: 24,
                                            color: Color(0xff0165fc),
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'Pusat Bantuan',
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 24,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                        builder: (context) =>
                                            PusatBantuanPage()));
                              },
                            ),
                          ),
                          Divider(),
                          Material(
                            type: MaterialType.transparency,
                            child: InkWell(
                              child: const Column(
                                children: [
                                  SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.logout,
                                            size: 24,
                                            color: Colors.red,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'Keluar',
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 24,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
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
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginMenu()),
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
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
