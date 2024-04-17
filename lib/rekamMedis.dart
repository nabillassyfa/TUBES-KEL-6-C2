// import 'package:example_app/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';


class RekamMedis extends StatefulWidget {
  const RekamMedis({super.key});

  @override
  State<RekamMedis> createState() => _RekamMedisState();
}

class _RekamMedisState extends State<RekamMedis> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RekamMedis'),
      ),
      body: Center(
        child: Text('Halaman RekamMedis'),
      ),
    );
  }
}