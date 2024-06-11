import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/p_dokter.dart';
import '../provider/p_rating.dart';
import '../models/dokter.dart';

class DoctorReviewsPage extends StatefulWidget {
  final Dokter dokter;

  DoctorReviewsPage({required this.dokter});

  @override
  State<DoctorReviewsPage> createState() => DoctorReviewsState();
}

class DoctorReviewsState extends State<DoctorReviewsPage> {
  @override
  void initState() {
    super.initState();
    final dokterProvider = Provider.of<DokterProvider>(context, listen: false);
    dokterProvider.getdataDokterbyIdwithS(widget.dokter.id);

    final ratingProvider = Provider.of<RatingProvider>(context, listen: false);
    ratingProvider.getdataRatingbyDokter(widget.dokter.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Reviews'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Image.network(
                  widget.dokter.imageUrl,
                  width: 120.0,
                  height: 120.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              widget.dokter.nama,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.dokter.namaSpesialis,
              style: TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
            SizedBox(height: 16.0),
            Consumer<RatingProvider>(
              builder: (context, ratingProvider, child) {
                if (ratingProvider.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                double averageRating = ratingProvider.averageRating;
                int reviewCount = ratingProvider.reviewCount;

                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          averageRating.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: 36.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 4.0),
                        Icon(
                          Icons.star_rate_rounded,
                          color: Colors.yellow,
                          size: 48,
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      '($reviewCount Reviews)',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Divider(
                      thickness: 3,
                      color: const Color(0xff0165fc),
                    ),
                    // Use ConstrainedBox to set minimum height constraints
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height - 300,
                      ),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: ratingProvider.dataRating.length,
                        itemBuilder: (context, index) {
                          final review = ratingProvider.dataRating[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(review.imageUrl),
                                  radius: 30.0,
                                ),
                                title: Text(
                                  review.nama_user,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Row(
                                  children: [
                                    Icon(Icons.star_rate_rounded,
                                        color: Colors.yellow, size: 16.0),
                                    SizedBox(width: 4.0),
                                    Text(
                                      review.rating.toString(),
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      review.pesan,
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                    SizedBox(height: 4.0),
                                    Divider(thickness: 2),
                                    SizedBox(height: 4.0),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
