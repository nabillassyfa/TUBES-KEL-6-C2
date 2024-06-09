import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/statusRawatJalan.dart';

class StatusRawatJalanProvider extends ChangeNotifier {
  bool isLoading = false;
  List<StatusRawatJalan> dataStatusRawatJalan = [];
  List<StatusRawatJalan> get dataStatus => dataStatusRawatJalan;

  Future<void> getDataStatusRawatJalan() async {
    isLoading = true;
    notifyListeners();

    final response = await http.get(Uri.parse('http://127.0.0.1:8000/status_rawat_jalan/'));

    if (response.statusCode == 200) {
      dataStatusRawatJalan = statusRawatJalanFromJson(response.body);
    } else {
      // Handle the error accordingly
      throw Exception('Failed to load status rawat jalan');
    }

    isLoading = false;
    notifyListeners();
  }
}
