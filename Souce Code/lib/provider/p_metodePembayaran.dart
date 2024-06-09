import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/metodePembayaran.dart';

class MetodePembayaranProvider extends ChangeNotifier {
  bool isLoading = false;
  List<MetodePembayaran> data_MetodePembayaran = [];
  List<MetodePembayaran> get dataMetodePembayaran => data_MetodePembayaran;

  Future<void> getdataMetodePembayaran() async {
    isLoading = true;
    notifyListeners();

    final response = await http.get(Uri.parse(
        'http://127.0.0.1:8000/metode_pembayaran/'));

    data_MetodePembayaran = MetodePembayaranFromJson(response.body);
    isLoading = false;
    notifyListeners();
  }
}
