import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp2/Fitur/bottomNavBar.dart';
import 'package:tp2/models/jadwalJanjiTemu.dart';
import 'package:tp2/provider/p_rating.dart';

class DoctorAddReviewsPage extends StatefulWidget {
  final JadwalJanjiTemu beri_review;

  DoctorAddReviewsPage({super.key, required this.beri_review});

  @override
  State<DoctorAddReviewsPage> createState() => DoctorAddReviewsState();
}

class DoctorAddReviewsState extends State<DoctorAddReviewsPage> {
  int _selectedRating = 0; // State variable to keep track of selected rating
  final TextEditingController _pesanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Reviews'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Image.network(
                  widget.beri_review.imageUrl,
                  width: 120.0,
                  height: 120.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              widget.beri_review.nama_dokter,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.beri_review.nama_spesialis,
              style: TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
            SizedBox(height: 16.0),
            Text(
              'Bagaimana pengalaman Anda dengan ${widget.beri_review.nama_dokter}?',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            Divider(thickness: 2),
            SizedBox(height: 16.0),
            Text(
              'Rating yang diberikan',
              style: TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _selectedRating
                        ? Icons.star
                        : Icons.star_border,
                    color: Colors.yellow,
                    size: 48,
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedRating = index + 1; // Update the rating
                    });
                  },
                );
              }),
            ),
            SizedBox(height: 16.0),
            Divider(thickness: 2),
            SizedBox(height: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tambahkan Review',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 80.0,
                  child: TextFormField(
                    controller: _pesanController,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'Review Anda',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                child: Text(
                  'Kirim',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff0165fc),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Konfirmasi'),
                        content:
                            Text('Apakah Anda yakin ingin dengan reviewnya?'),
                        actions: [
                          TextButton(
                            child: Text('Batal'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Kirim'),
                            onPressed: () async {
                              try {
                                await Provider.of<RatingProvider>(context, listen: false)
                                    .beriRating(
                                  _pesanController.text,
                                  _selectedRating.toDouble(),
                                  widget.beri_review.id_user,
                                  widget.beri_review.id_dokter,
                                );
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BottomNavBar(idx: 0),
                                  ),
                                  (Route<dynamic> route) => false,
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Failed to submit rating: $e'),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
