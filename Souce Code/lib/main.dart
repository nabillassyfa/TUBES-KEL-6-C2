import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp2/provider/p_RS.dart';
import 'package:tp2/provider/p_dokter.dart';
import 'package:tp2/provider/p_jadwalDokter.dart';
import 'package:tp2/provider/p_jadwalJanjiTemu.dart';
import 'package:tp2/provider/p_spesialis.dart';
import 'package:tp2/provider/p_user.dart';
import 'Fitur/landingPage1.dart';
import 'package:intl/date_symbol_data_local.dart'; // Import untuk inisialisasi data lokal


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting(); // Inisialisasi data lokal untuk DateFormat
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => SpesialisProvider()),
        ChangeNotifierProvider(create: (_) => RSProvider()),
        ChangeNotifierProvider(create: (_) => DokterProvider()),
        ChangeNotifierProvider(create: (_) => JadwalDokterProvider()),
        ChangeNotifierProvider(create: (_) => JadwalJanjiTemuProvider()),
      ],            
      child: const MyApp(), 
    ) 
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DI Hospital',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'inter',
      ),
      home: LP1(),
    );
  }
}