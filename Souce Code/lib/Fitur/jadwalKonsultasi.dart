import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp2/provider/p_jadwalJanjiTemu.dart';
import 'package:tp2/widget/jadwalJanjitemu_widget.dart';

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
    final provider = Provider.of<JadwalJanjiTemuProvider>(context, listen: false);
    provider.getdataJadwalJanjiTemuByUser(); // Contoh ID user, ganti dengan yang sesuai
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<JadwalJanjiTemuProvider>(context);
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  const Text('Notifikasi'),
                  const SizedBox(width: 10,),
                  Switch(
                    splashRadius: 0,
                    value: widget.notifkonsul,
                    activeColor: Color.fromARGB(255, 1, 101, 252),
                    onChanged: widget.onNotifChanged,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            provider.isLoading 
              ? CircularProgressIndicator()
              : provider.data_JadwalJanjiTemu.isEmpty
                ? Text('Saat ini Anda tidak memiliki jadwal apapun')
                : WidgetJadwalJanjiTemu(jadwalJanjiTemu: provider.data_JadwalJanjiTemu),
            // WidgetJadwalPanggilDokter(),
            // WidgetJadwalVideoCall(),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}
