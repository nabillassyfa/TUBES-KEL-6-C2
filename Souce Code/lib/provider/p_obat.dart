import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/obat.dart';  // Sesuaikan dengan path model Obat

class ObatProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Obat> _dataObat = [];
  int _totalHarga = 0;

  List<Obat> get dataObat => _dataObat;
  int get totalHarga => _totalHarga;

  Future<void> getDataObat() async {
    isLoading = true;
    notifyListeners();

    final response = await http.get(Uri.parse('http://127.0.0.1:8000/obat/'));

    if (response.statusCode == 200) {
      _dataObat = ObatFromJson(response.body);
      _totalHarga = _dataObat.fold(0, (sum, item) => sum + item.harga);
    } else {
      throw Exception('Failed to load obat');
    }

    isLoading = false;
    notifyListeners();
  }
}
