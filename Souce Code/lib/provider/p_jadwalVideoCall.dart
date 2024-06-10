import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tp2/models/jadwalVideoCall.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class JadwalVideoCallProvider extends ChangeNotifier {
  bool isLoading = false;
  List<JadwalVideoCall> data_JadwalVideoCall = [];
  List<JadwalVideoCall> get dataJadwalVideoCall => data_JadwalVideoCall;

  Future<void> getdataJadwalVideoCallByUser() async {
    _setLoading(true);
    try {
      // Mendapatkan user_id dari SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final int? userId = prefs.getInt('user_id');

      if (userId != null) {
        final response = await http.get(Uri.parse('http://127.0.0.1:8000/jadwal_konsul_online_by_user/$userId'));
        if (response.statusCode == 200) {
          data_JadwalVideoCall = JadwalVideoCallFromJson(response.body);
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

  Future<void> postdataJadwalVideoCall(int id_jadwal_dokter_online, String tanggal, int durasi, String link_video_call) async {
    _setLoading(true);
    try {
      // Mendapatkan user_id dari SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final int? userId = prefs.getInt('user_id');

      if (userId != null) {
        final response = await http.post(
          Uri.parse('http://127.0.0.1:8000/jadwal_konsul_online/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'id_user': userId,
            'id_jadwal_dokter_online': id_jadwal_dokter_online,
            'tanggal': tanggal,
            'durasi': durasi, 
            'link_video_call': link_video_call,
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
