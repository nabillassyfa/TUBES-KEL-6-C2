import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tp2/models/pembayaran.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PembayaranProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Pembayaran> data_Pembayaran = [];
  List<Pembayaran> get dataPembayaran => data_Pembayaran;

  Future<void> getdataPembayaranByUser() async {
    _setLoading(true);
    try {
      // Mendapatkan user_id dari SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final int? userId = prefs.getInt('user_id');

      if (userId != null) {
        final response = await http.get(Uri.parse('http://127.0.0.1:8000/jadwal_janji_temu_by_user/$userId'));
        if (response.statusCode == 200) {
          data_Pembayaran = PembayaranFromJson(response.body);
        } else {
          // Handle server error
          throw Exception('Failed to load data');
        }
      } else {
        // Handle missing user_id
        throw Exception('User ID not found');
      }
    } catch (e) {
      // Handle network or parsing error
      print(e);
    } finally {
      _setLoading(false);
    }
  }
  
  
  Future<void> postdataPembayaran(String metode_pembayaran, int total_pembayaran, String item) async {
    _setLoading(true);
    try {
      // Mendapatkan user_id dari SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final int? userId = prefs.getInt('user_id');

      String status;
      if (metode_pembayaran == "Bayar ditempat") {
        status = "Belum lunas";
      } else {
        status = "Lunas";
        await Future.delayed(Duration(seconds: 2));
      }

      if (userId != null) {
        final response = await http.post(
          Uri.parse('http://127.0.0.1:8000/create_pembayaran/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'id_user': userId,
            'waktu_pembayaran': DateTime.now().toIso8601String(), // Convert DateTime to string
            'metode_pembayaran': metode_pembayaran,
            'total_pembayaran': total_pembayaran,
            'status': status,
            'item': item,
          }),
        );
        if (response.statusCode == 200) {
          var responseData = jsonDecode(response.body);
          return responseData;
        } else {
          // Handle server error
          throw Exception('Failed to load data');
        }
      } else {
        // Handle missing user_id
        throw Exception('User ID not found');
      }
    } catch (e) {
      // Handle network or parsing error
      print(e);
    } finally {
      _setLoading(false);
    }
  }


  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
