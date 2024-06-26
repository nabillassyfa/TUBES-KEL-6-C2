import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/spesialis.dart';

class SpesialisProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Spesialis> data_Spesialis = [];
  List<Spesialis> get dataSpesialis => data_Spesialis;

  Future<void> getdataSpesialis() async {
    isLoading = true;
    notifyListeners();

    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/spesialis/'));

    data_Spesialis = SpesialisFromJson(response.body);
    isLoading = false;
    notifyListeners();
  }

  Future<void> getdataSpesialisbyRS(int id) async {
    isLoading = true;
    notifyListeners();

    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/daftar_spesialis/$id'));

    data_Spesialis = SpesialisFromJson(response.body);
    isLoading = false;
    notifyListeners();
  }

  Future<void> getdataSpesialisbyID(int id) async {
    isLoading = true;
    notifyListeners();

    final response = await http
        .get(Uri.parse('http://127.0.0.1:8000/daftar_spesialis_by_id/$id'));

    data_Spesialis = SpesialisFromJson(response.body);
    isLoading = false;
    notifyListeners();
  }
}
