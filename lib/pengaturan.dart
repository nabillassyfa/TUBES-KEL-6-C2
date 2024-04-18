import 'package:flutter/material.dart';

class PengaturanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0165fc),
        title: Text('Pengaturan'),
      ),
      body: SingleChildScrollView(
        child: Container(
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.language,
                                size: 32,
                                color: Color(0xff0165fc),
                              ),
                              SizedBox(width: 16),
                              Text(
                                'Bahasa',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Indonesia',
                                style: TextStyle(
                                    fontSize: 16, color: Color(0xff0165fc)),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 28,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                  onTap: () {},
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.lock,
                                size: 32,
                                color: Color(0xff0165fc),
                              ),
                              SizedBox(width: 16),
                              Text(
                                'Ganti Kata Sandi',
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
                  onTap: () {},
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.link,
                                size: 32,
                                color: Color(0xff0165fc),
                              ),
                              SizedBox(width: 16),
                              Text(
                                'Akun Terhubung',
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
                  onTap: () {},
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.person_remove,
                                size: 32,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 16),
                              Text(
                                'Hapus Akun',
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
                              'Apakah Anda yakin ingin menghapus akun ini?\n\nAkun akan masuk masa penghapusan selama 30 hari, Anda dapat membatalkan penghapusan dalam masa ini. Jika sudah lewat dari 30 hari, maka akun akan benar-benar dihapus!'),
                          actions: [
                            TextButton(
                              child: Text('Batal'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('Hapus'),
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
      ),
    );
  }
}
