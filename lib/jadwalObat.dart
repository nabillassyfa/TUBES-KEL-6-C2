import 'package:flutter/material.dart';
class JadwalObat extends StatelessWidget {
  final bool notifobat;
  final Function(bool) onNotifChanged;

  const JadwalObat({
    Key? key,
    required this.notifobat,
    required this.onNotifChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  const Text(
                    'Notifikasi',
                  ),
                  const SizedBox(width: 10,),
                  Switch(
                    splashRadius: 0,
                    value: notifobat,
                    activeColor: Color.fromARGB(255, 1, 101, 252),
                    onChanged: onNotifChanged,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey,
                  width: 2
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [ BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 1)
                )]
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 1, 101, 252),
                      
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                     
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.medication_liquid,
                          color: Colors.white,
                        ),
                        SizedBox(width: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Obat tablet',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  'Setelah makan',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  ' - ',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '2 tablet',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  const Text(
                    'Jadwal konsumsi',
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                    
                  ),
                  const Divider(
                    thickness: 1,
                    color: Colors.black,
                    indent: 120,
                    endIndent: 120,
                  ),
                  SizedBox(height: 10,),
                  Container(
                    margin: EdgeInsets.only(left: 25, right: 25),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '08.00',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          '13.00',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          '19.00',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey,
                  width: 2
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [ BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 1)
                )]
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 1, 101, 252),
                      
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.medication_liquid,
                          color: Colors.white,
                        ),
                        SizedBox(width: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Obat antibiotik',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  'Setelah makan',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  ' - ',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '2 sendok maakan',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  const Text(
                    'Jadwal konsumsi',
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                    
                  ),
                  const Divider(
                    thickness: 1,
                    color: Colors.black,
                    indent: 120,
                    endIndent: 120,
                  ),
                  SizedBox(height: 10,),
                  Container(
                    margin: EdgeInsets.only(left: 25, right: 25),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '08.00',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          '19.00',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}