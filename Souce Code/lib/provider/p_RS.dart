import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/dataRS.dart';

class RSProvider extends ChangeNotifier {
  bool isLoading = false;
  List<RS> data_RS = [];
  List<RS> get dataRS => data_RS;

  Future<void> getdataRS() async {
    isLoading = true;
    notifyListeners();

    final response = await http.get(Uri.parse(
        'http://127.0.0.1:8000/RS/'));

    data_RS = RSFromJson(response.body);
    isLoading = false;
    notifyListeners();
  }

  Future<void> getdataRSbySpesialis(int id) async {
    isLoading = true;
    notifyListeners();

    final response = await http.get(Uri.parse(
        'http://127.0.0.1:8000/daftar_RS/$id'));

    data_RS = RSFromJson(response.body);
    isLoading = false;
    notifyListeners();
  }
  Future<void> getdataRsByLab(int lab) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:8000/daftar_RS_by_idLab/$lab/'));
      if (response.statusCode == 200) {
        data_RS = RSFromJson(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
