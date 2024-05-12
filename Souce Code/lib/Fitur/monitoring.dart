// import 'package:example_app/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';


class Monitoring extends StatefulWidget {
  const Monitoring({super.key});

  @override
  State<Monitoring> createState() => _MonitoringState();
}

class _MonitoringState extends State<Monitoring> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(

        title: Text('Monitoring'),
      ),
      body: Center(
        child: Text('Halaman Monitoring'),
      ),
    );
  }
}