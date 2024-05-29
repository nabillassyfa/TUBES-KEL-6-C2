import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tp2/Fitur/detailRS.dart';
import 'package:tp2/Fitur/pilih_dokter.dart';
import '../models/dataRS.dart';

class RSWidget extends StatelessWidget {
  const RSWidget({
    Key? key,
    required this.data,
    required this.asal,
  }) : super(key: key);
  final RS data;
  final String asal;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (asal == "rs") {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return detailRS(
              data: data,
            );
          }));
        }
        if (asal == "dokter") {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return PilihDokter(
              data: data,
            );
          }));
        }
      },
      child: Container(
        color: Color.fromARGB(0, 0, 0, 0),
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 4,
              ),
            ],
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(data.imageUrl),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      data.nama,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      data.lokasi,
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      "18 menit",
                      style: TextStyle(fontSize: 14),
                    ),
                    if (asal == "rs")
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Lihat detail',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.blue,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_right_outlined,
                            color: Colors.blue,
                            size: 24,
                          ),
                        ],
                      ),
                    if (asal == "emergency")
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Lihat petunjuk arah',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.arrow_circle_right,
                            color: Colors.blue,
                            size: 24,
                          ),
                        ],
                      ),
                    if (asal == "dokter")
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Pilih',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.arrow_circle_right,
                            color: Colors.blue,
                            size: 24,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
