import 'package:flutter/material.dart';

class PengaturanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0165fc),
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
            Text(
              'Pengaturan',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
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
                      SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.language,
                                size: 24,
                                color: Color(0xff0165fc),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Bahasa',
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Indonesia',
                                style: TextStyle(
                                    fontSize: 14, color: Color(0xff0165fc)),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 24,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                    ],
                  ),
                  onTap: () {},
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.lock,
                                size: 24,
                                color: Color(0xff0165fc),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Ganti Kata Sandi',
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
                  onTap: () {},
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.link,
                                size: 24,
                                color: Color(0xff0165fc),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Akun Terhubung',
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
                  onTap: () {},
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.person_remove,
                                size: 24,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Hapus Akun',
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
