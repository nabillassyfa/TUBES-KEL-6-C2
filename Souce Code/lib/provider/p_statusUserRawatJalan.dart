import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/statusUserRawatJalan.dart';
import 'dart:convert';

class StatusUserRawatJalanProvider extends ChangeNotifier {
  bool isLoading = false;
  StatusUserRawatJalan? dataStatusUserRawatJalan;

  StatusUserRawatJalan? get dataStatus => dataStatusUserRawatJalan;

  Future<void> getDataStatusUserRawatJalan(int idJanjiTemu) async {
    isLoading = true;
    notifyListeners();

    final response = await http.get(Uri.parse('http://127.0.0.1:8000/status_rawat_jalan_user/$idJanjiTemu'));

    if (response.statusCode == 200) {
      dataStatusUserRawatJalan = StatusUserRawatJalan.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load status rawat jalan');
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> updateStatusUserRawatJalan(int idJanjiTemu, int newStatus) async {
    isLoading = true;
    notifyListeners();

    final response = await http.patch(
      Uri.parse('http://127.0.0.1:8000/status_rawat_jalan_user/$idJanjiTemu'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "id_statusRawatJalan": newStatus,
      }),
    );

    if (response.statusCode == 200) {
      // dataStatusUserRawatJalan = StatusUserRawatJalan.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update status rawat jalan');
    }

    isLoading = false;
    notifyListeners();
  }
}
