import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp2/provider/p_jadwalObat.dart';

class JadwalObat extends StatefulWidget {
  final bool notifobat;
  final Function(bool) onNotifChanged;

  const JadwalObat({
    Key? key,
    required this.notifobat,
    required this.onNotifChanged,
  }) : super(key: key);

  @override
  _JadwalObatState createState() => _JadwalObatState();
}

class _JadwalObatState extends State<JadwalObat> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<JadwalObatProvider>(context, listen: false)
            .getdataJadwalObatByUser());
  }

  void _deleteJadwalObat(int idJadwalObat) {
  Provider.of<JadwalObatProvider>(context, listen: false)
      .deleteJadwalObat(idJadwalObat);
}

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<JadwalObatProvider>(context);
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                const Text('Notifikasi'),
                const SizedBox(width: 10),
                Switch(
                  splashRadius: 0,
                  value: widget.notifobat,
                  activeColor: Color.fromARGB(255, 1, 101, 252),
                  onChanged: widget.onNotifChanged,
                ),
              ],
            ),
            provider.isLoading
                ? Center(child: CircularProgressIndicator())
                : provider.dataJadwalObat.isEmpty
                    ? Column(
                      children: [
                        SizedBox(height: 40,),
                        Text('Saat ini tidak memiliki jadwal minum obat'),
                      ],
                    )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: provider.dataJadwalObat.length,
                        itemBuilder: (context, index) {
                          final jadwal = provider.dataJadwalObat[index];
                          return Container(
                            margin: EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 1, 101, 252),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.medication_liquid,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            jadwal.nama_obat,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                jadwal.kondisi_makan,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                ' - ',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                jadwal.takaran,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                     GestureDetector(
                                      onTap: () {
                                        _deleteJadwalObat(jadwal.id); // Assuming jadwal has an id property
                                      },
                                      child: Icon(
                                        Icons.cancel_outlined,
                                        color: Colors.white,
                                      ),
                                    ),

                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Jadwal konsumsi',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Divider(
                                  thickness: 1,
                                  color: Colors.black,
                                  indent: 120,
                                  endIndent: 120,
                                ),
                                SizedBox(height: 10),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 25),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: jadwal.waktu_konsumsi
                                        .map(
                                          (waktu) => Text(
                                            waktu,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          );
                        },
                      ),
          ],
        ),
      ),
    );
  }
}
