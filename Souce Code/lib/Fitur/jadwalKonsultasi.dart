import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp2/provider/p_jadwalJanjiTemu.dart';
import 'package:tp2/provider/p_jadwalPanggilDokter.dart';
import 'package:tp2/provider/p_jadwalVideoCall.dart';
import 'package:tp2/widget/jadwalJanjitemu_widget.dart';
import 'package:tp2/widget/jadwalPanggilDokter_widget.dart';
import 'package:tp2/widget/jadwalVideoCall_widget.dart';

class JadwalKonsultasi extends StatefulWidget {
  final bool notifkonsul;
  final Function(bool) onNotifChanged;

  JadwalKonsultasi({
    Key? key,
    required this.notifkonsul,
    required this.onNotifChanged,
  }) : super(key: key);

  @override
  _JadwalKonsultasiState createState() => _JadwalKonsultasiState();
}

class _JadwalKonsultasiState extends State<JadwalKonsultasi> {
  @override
  void initState() {
    super.initState();
    final providerjanjitemu = Provider.of<JadwalJanjiTemuProvider>(context, listen: false);
    providerjanjitemu.getdataJadwalJanjiTemuByUser(); // Contoh ID user, ganti dengan yang sesuai
    final providerVideoCall = Provider.of<JadwalVideoCallProvider>(context, listen: false);
    providerVideoCall.getdataJadwalVideoCallByUser(); // Contoh ID user, ganti dengan yang sesuai
    final providerPanggilDokter = Provider.of<JadwalPanggilDokterProvider>(context, listen: false);
    providerPanggilDokter.getdataJadwalPanggilDokterByUser(); // Contoh ID user, ganti dengan yang sesuai
  }

  @override
  Widget build(BuildContext context) {
    final providerjanjitemu = Provider.of<JadwalJanjiTemuProvider>(context);
    final providerVideoCall = Provider.of<JadwalVideoCallProvider>(context);
    final providerPanggilDokter = Provider.of<JadwalPanggilDokterProvider>(context);
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  const Text('Notifikasi'),
                  const SizedBox(
                    width: 10,
                  ),
                  Switch(
                    splashRadius: 0,
                    value: widget.notifkonsul,
                    activeColor: Color.fromARGB(255, 1, 101, 252),
                    onChanged: widget.onNotifChanged,
                  ),
                ],
              ),
            ),
            providerjanjitemu.data_JadwalJanjiTemu.isEmpty && providerVideoCall.data_JadwalVideoCall.isEmpty && providerPanggilDokter.data_JadwalPanggilDokter.isEmpty
            ? Text('Saat ini Anda tidak memiliki jadwal apapun')
            :
            providerjanjitemu.isLoading
                ? CircularProgressIndicator()
                : WidgetJadwalJanjiTemu(
                        jadwalJanjiTemu: providerjanjitemu.data_JadwalJanjiTemu),
            providerVideoCall.isLoading
                ? CircularProgressIndicator()
                : WidgetJadwalVideoCall(
                        jadwalVideoCall: providerVideoCall.data_JadwalVideoCall),
            providerPanggilDokter.isLoading
                ? CircularProgressIndicator()
                : WidgetJadwalPanggilDokter(
                        jadwalPanggilDokter: providerPanggilDokter.data_JadwalPanggilDokter),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
