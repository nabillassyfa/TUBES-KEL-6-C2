// import 'package:example_app/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';


class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(

        title: Text('Profil'),
      ),
      body: Center(
        child: Text('Halaman Profil'),
      ),
    );
  }
}