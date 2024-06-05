import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/dokter.dart';

class DokterProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Dokter> data_dokter = [];
  List<Dokter> get dataDokter => data_dokter;

  Future<void> getdataDokter() async {
    _setLoading(true);
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:8000/daftar_dokter/'));
      if (response.statusCode == 200) {
        data_dokter = DokterFromJson(response.body);
      } else {
        // Handle server error
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Handle network or parsing error
      print(e);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> getdataDokterbyRSSpesialis(int id_rs, int id_spesialis) async {
    _setLoading(true);
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:8000/daftar_dokter_by_RS_Spesialis/$id_rs/$id_spesialis'));
      if (response.statusCode == 200) {
        data_dokter = DokterFromJson(response.body);
      } else {
        // Handle server error
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Handle network or parsing error
      print("aaaaeerrrrooorrr");
      print(e);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> getdataDokterbyJadwal(int id_rs, int id_spesialis, String hari) async {
    _setLoading(true);
    try {
      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/daftar_dokter_by_jadwal/$id_rs/$id_spesialis/$hari'),
      );
      if (response.statusCode == 200) {
        data_dokter = DokterFromJson(response.body);
      } else {
        // Handle server error
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Handle network or parsing error
      print('Error: $e');
    } finally {
      _setLoading(false);
    }
  }


  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
