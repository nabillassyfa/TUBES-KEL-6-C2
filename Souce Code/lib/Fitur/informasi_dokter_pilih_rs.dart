import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widget/Rs_widget.dart';
import '../provider/p_rs.dart';

class SpecializationPageSelectRS extends StatefulWidget {
  const SpecializationPageSelectRS({
    Key? key,
    required this.idSpesialis,
  }) : super(key: key);

  final int idSpesialis;

  @override
  State<SpecializationPageSelectRS> createState() => _SpecializationPageSelectRSState();
}

class _SpecializationPageSelectRSState extends State<SpecializationPageSelectRS> {
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RSProvider()..getdataRSbySpesialis(widget.idSpesialis),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pilih Rumah Sakit'),
        ),
        body: Consumer<RSProvider>(
          builder: (context, value, child) {
            if (value.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (value.dataRS.isEmpty) {
              return const Center(child: Text('Tidak ada data rumah sakit yang tersedia.'));
            } else {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/banner.png',
                      width: 400,
                      height: 160,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Pilih Rumah Sakit',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Berikut Rumah Sakit yang tersedia Spesialis tersebut',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: MediaQuery.of(context).size.height -
                          kToolbarHeight -
                          MediaQuery.of(context).padding.top -
                          MediaQuery.of(context).padding.bottom,
                      padding: const EdgeInsets.all(10),
                      child: ListView.builder(
                        itemCount: value.dataRS.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: RSWidget(
                              data: value.dataRS[index],
                              asal: "dokter",
                              idPrev: widget.idSpesialis,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
