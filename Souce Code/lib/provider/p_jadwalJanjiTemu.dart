import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tp2/models/jadwalJanjiTemu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JadwalJanjiTemuProvider extends ChangeNotifier {
  bool isLoading = false;
  List<JadwalJanjiTemu> data_JadwalJanjiTemu = [];
  List<JadwalJanjiTemu> get dataJadwalJanjiTemu => data_JadwalJanjiTemu;

  Future<void> getdataJadwalJanjiTemuByUser() async {
    _setLoading(true);
    try {
      // Mendapatkan user_id dari SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final int? userId = prefs.getInt('user_id');

      if (userId != null) {
        final response = await http.get(Uri.parse('http://127.0.0.1:8000/jadwal_janji_temu_by_user/$userId'));
        if (response.statusCode == 200) {
          data_JadwalJanjiTemu = JadwalJanjiTemuFromJson(response.body);
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
