import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/obat.dart';

class ObatProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Obat> data_Obat = [];
  List<Obat> get dataObat => data_Obat;

  Future<void> getdataObat() async {
    isLoading = true;
    notifyListeners();

    final response = await http.get(Uri.parse(
        'http://127.0.0.1:8000/obat/'));

    data_Obat = ObatFromJson(response.body);
    isLoading = false;
    notifyListeners();
  }
}
