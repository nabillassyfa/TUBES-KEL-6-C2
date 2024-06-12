import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tp2/models/jadwalPanggilDokter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class JadwalPanggilDokterProvider extends ChangeNotifier {
  bool isLoading = false;
  List<JadwalPanggilDokter> data_JadwalPanggilDokter = [];
  List<JadwalPanggilDokter> get dataJadwalPanggilDokter => data_JadwalPanggilDokter;

  Future<void> getdataJadwalPanggilDokterByUser() async {
    _setLoading(true);
    try {
      // Mendapatkan user_id dari SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final int? userId = prefs.getInt('user_id');

      if (userId != null) {
        final response = await http.get(Uri.parse('http://127.0.0.1:8000/jadwal_panggil_dokter_by_user/$userId'));
        if (response.statusCode == 200) {
          data_JadwalPanggilDokter = JadwalPanggilDokterFromJson(response.body);
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

  Future<void> postdataJadwalPanggilDokter(int id_jadwal_dokter_panggil_dokter, String tanggal, String alamat) async {
    _setLoading(true);
    try {
      // Mendapatkan user_id dari SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final int? userId = prefs.getInt('user_id');
      print(userId);

      if (userId != null) {
        final response = await http.post(
          Uri.parse('http://127.0.0.1:8000/jadwal_panggil_dokter/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'id_user': userId,
            'tanggal': tanggal,
            'id_jadwal_dokter_panggil_dokter': id_jadwal_dokter_panggil_dokter,
            'alamat': alamat, 
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

  Future<void> deleteJadwalPanggilDokter(int id) async {
    _setLoading(true);
    try {
        final response = await http.delete(
          Uri.parse('http://127.0.0.1:8000/hapus_jadwal_panggil_dokter/$id'),
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

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
