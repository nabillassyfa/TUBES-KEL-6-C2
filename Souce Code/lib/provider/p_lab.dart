import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/lab.dart';
import '../models/jadwalLab.dart';


class LabProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Lab> data_lab = [];
  List<Lab> get dataLab => data_lab;
  List<JadwalLab> data_Jadwal_Lab = [];
  List<JadwalLab> get dataJadwalLab => data_Jadwal_Lab;

  Future<void> getdataLab() async {
    _setLoading(true);
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:8000/daftar_lab'));
      if (response.statusCode == 200) {
        data_lab = LabFromJson(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> getdataLabByRs(int rs, int lab) async {
    _setLoading(true);
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:8000/jadwal_lab_by_idrs/$rs/$lab/'));
      if (response.statusCode == 200) {
        data_Jadwal_Lab = JadwalLabFromJson(response.body);
      } else {
        throw Exception('Failed to load data');
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
