import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/artikel.dart';

class ArtikelProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Artikel> data_Artikel = [];
  List<Artikel> get dataArtikel => data_Artikel;

  Future<void> getdataArtikel() async {
    isLoading = true;
    notifyListeners();

    final response = await http.get(Uri.parse(
        'http://127.0.0.1:8000/artikel/'));

    data_Artikel = ArtikelFromJson(response.body);
    isLoading = false;
    notifyListeners();
  }
}
