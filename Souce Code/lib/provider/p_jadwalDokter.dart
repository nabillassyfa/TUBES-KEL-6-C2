import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/jadwalDokter.dart';
import '../models/jadwalDokterOnline.dart';


class JadwalDokterProvider extends ChangeNotifier {
  bool isLoading = false;
  List<JadwalDokter> data_Jadwal_dokter = [];
  List<JadwalDokter> get dataJadwalDokter => data_Jadwal_dokter;
  List<JadwalDokterDaring> data_Jadwal_dokter_Daring = [];
  List<JadwalDokterDaring> get dataJadwalDokterDaring => data_Jadwal_dokter_Daring;

  Future<void> getdataJadwalDokterByDokterRS(int id_dokter, int id_rs) async {
    _setLoading(true);
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:8000/jadwal_dokter/$id_dokter/$id_rs'));
      if (response.statusCode == 200) {
        data_Jadwal_dokter = JadwalDokterFromJson(response.body);
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

  Future<void> getdataJadwalDokterByDokter(int id_dokter) async {
    _setLoading(true);
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:8000/jadwal_dokter_online/$id_dokter/'));
      if (response.statusCode == 200) {
        data_Jadwal_dokter_Daring = JadwalDokterDaringFromJson(response.body);
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

  Future<void> getdataJadwalPanggilDokter(String day, String time) async {
    _setLoading(true);
    print (day);
    print (time);
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:8000/jadwal_panggil_dokter/$day/$time'));
      if (response.statusCode == 200) {
        data_Jadwal_dokter_Daring = JadwalDokterDaringFromJson(response.body);
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

  Future<void> getdataJadwalDokterByDokterRSHari(int id_dokter, int id_rs, String hari) async {
    _setLoading(true);
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:8000/jadwal_dokter_by_hari/$id_dokter/$id_rs/$hari'));
      if (response.statusCode == 200) {
        data_Jadwal_dokter = JadwalDokterFromJson(response.body);
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

  Future<void> getFilteredDokters(int rsId, String day, String time, int SpesialisId) async {
    _setLoading(true);
    print('day: $day');
    print('time: $time');
    print('rsId: $rsId');
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:8000/jadwal_dokter_by_hari_jam/$time/$rsId/$day/$SpesialisId/'));
      if (response.statusCode == 200) {
        data_Jadwal_dokter = JadwalDokterFromJson(response.body);
        
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

  Future<void> getJadwalDaring(String day, String time, int SpesialisId) async {
    _setLoading(true);
    

    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:8000/jadwal_dokter_daring/$time/$day/$SpesialisId/'));
      if (response.statusCode == 200) {
        data_Jadwal_dokter_Daring = JadwalDokterDaringFromJson(response.body);
        print('day: $day');
        print('time: $time');
      } else {
        throw Exception('Failed to load data');
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
