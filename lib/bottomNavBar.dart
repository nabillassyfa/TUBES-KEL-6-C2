import 'package:flutter/material.dart';
import 'beranda.dart';
import 'jadwal.dart';
import 'rekamMedis.dart';
import 'monitoring.dart';
import 'profil.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key, required this.idx});

  final int idx;
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Beranda(),
    Jadwal(),
    RekamMedis(),
    Monitoring(),
    Profil()
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.idx; // Inisialisasi _selectedIndex dari properti initialIndex
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month),
                label: 'Jadwal',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.content_paste),
                label: 'Rekam Medis',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.insert_chart),
                label: 'Monitoring',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profil',
              ),
            ],
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            selectedItemColor: const Color.fromARGB(255, 1, 101, 252),
            unselectedItemColor: const Color.fromARGB(128, 0, 0, 0),
            selectedFontSize: 12,
            unselectedFontSize: 12,
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            iconSize: 34,
            onTap: _onItemTapped,
          ),
        )
      )
    );
  }
}
