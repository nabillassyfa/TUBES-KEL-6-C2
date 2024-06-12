import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tp2/models/jadwalObat.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class JadwalObatProvider extends ChangeNotifier {
  bool isLoading = false;
  List<JadwalObat> data_JadwalObat = [];
  List<JadwalObat> get dataJadwalObat => data_JadwalObat;

  Future<void> getdataJadwalObatByUser() async {
    _setLoading(true);
    try {
      // Mendapatkan user_id dari SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final int? userId = prefs.getInt('user_id');

      if (userId != null) {
        final response = await http.get(Uri.parse('http://127.0.0.1:8000/jadwal_obat/$userId'));
        if (response.statusCode == 200) {
          data_JadwalObat = JadwalObatFromJson(response.body);
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

  Future<void> deleteJadwalObat(int idJadwalObat) async {
    _setLoading(true);
    try {
        final response = await http.delete(
          Uri.parse('http://127.0.0.1:8000/hapus_obat/$idJadwalObat'),
        );

        if (response.statusCode == 200) {
          print('Medication deleted successfully');
        } else {
          throw Exception('Failed to delete medication');
        }
    } catch (e) {
      print(e);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> postdataJadwalObat(int id_obat) async {
    _setLoading(true);
    try {
      // Mendapatkan user_id dari SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final int? userId = prefs.getInt('user_id');

      if (userId != null) {
        final response = await http.post(
          Uri.parse('http://127.0.0.1:8000/create_jadwal_obat/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'id_obat': id_obat,
            'kondisi_makan': 'Setelah makan',
            'takaran': '1 tablet',
            'id_user': userId,
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
