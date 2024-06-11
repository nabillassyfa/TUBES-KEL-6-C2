import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/rekamMedis.dart';
import 'p_user.dart'; // Pastikan Anda mengimpor UserProvider

class RekamMedisProvider extends ChangeNotifier {
  bool isLoading = false;
  List<RekamMedis> data_RekamMedis = [];
  List<RekamMedis> get dataRekamMedis => data_RekamMedis;

  Future<void> getdataRekamMedis(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    int? userId = await userProvider.getUserId();

    print(userId);
    isLoading = true;
    notifyListeners();

    final response = await http.get(Uri.parse('http://127.0.0.1:8000/rekam_medis/$userId/'));

    if (response.statusCode == 200) {
      data_RekamMedis = RekamMedisFromJson(response.body);
    } else {
      // Handle error
      print('Failed to load data: ${response.statusCode}');
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> postdataRekamMedis(String obat, DateTime tanggal, int id_dokter) async {
    isLoading = true;
    notifyListeners();
    try {
      // Mendapatkan user_id dari SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final int? userId = prefs.getInt('user_id');

      if (userId != null) {
        final response = await http.post(
          Uri.parse('http://127.0.0.1:8000/rekam_medis/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'keterangan': "Masuk Angin",
            'catatan_dokter': "Jangan lupa makan, jangan hujan-hujanan",
            'obat': obat,
            'tanggal': tanggal.toIso8601String(),
            'id_dokter': id_dokter,
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
      isLoading = false;
      notifyListeners();
    }
  }
}
