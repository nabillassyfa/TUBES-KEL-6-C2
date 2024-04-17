// import 'package:example_app/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';


class Jadwal extends StatefulWidget {
  const Jadwal({super.key});

  @override
  State<Jadwal> createState() => _JadwalState();
}

class _JadwalState extends State<Jadwal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal'),
      ),
      body: Center(
        child: Text('Halaman Jadwal'),
      ),
    );
  }
}