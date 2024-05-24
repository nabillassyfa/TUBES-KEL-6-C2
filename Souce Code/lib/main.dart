import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp2/provider/p_user.dart';
import 'Fitur/landingPage1.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider())
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