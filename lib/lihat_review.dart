import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Doctor {
  final String imageUrl;
  final String name;
  final String specialization;
  final int yearsOfExperience;
  final String hospitalAddress;
  final double rating;
  final int ratingCount;
  final String description;

  Doctor({
    required this.imageUrl,
    required this.name,
    required this.specialization,
    required this.yearsOfExperience,
    required this.hospitalAddress,
    required this.rating,
    required this.ratingCount,
    required this.description,
  });
}

class Review {
  final String userImageUrl;
  final String userName;
  final double rating;
  final String comment;

  Review({
    required this.userImageUrl,
    required this.userName,
    required this.rating,
    required this.comment,
  });
}

class DoctorReviewsPage extends StatefulWidget {
  @override
  State<DoctorReviewsPage> createState() => DoctorReviewsState();
}

class DoctorReviewsState extends State<DoctorReviewsPage> {
  @override
  Widget build(BuildContext context) {
    Doctor doctor = Doctor(
      imageUrl: 'assets/images/dokter2.png',
      name: 'Dr. John Doe',
      specialization: 'Cardiologist',
      yearsOfExperience: 10,
      hospitalAddress: '123 Main St, City',
      rating: 4.5,
      ratingCount: 23,
      description:
          'Muhammad Rifky Afandi adalah seorang dokter spesialis jiwa dengan pengalaman kerja 5 tahun. Beliau menempuh S1 dan spesialis jiwa di Universitas Padjajaran.',
    );
    final List<Review> reviews = [
      Review(
        userImageUrl: 'assets/images/celine.png',
        userName: 'John Doe',
        rating: 4.5,
        comment: 'Dr. Smith is an excellent doctor. Highly recommend!',
      ),
      Review(
        userImageUrl: 'assets/images/celine.png',
        userName: 'Jane Smith',
        rating: 5.0,
        comment: 'Dr. Smith provided exceptional care. Very knowledgeable.',
      ),
      Review(
        userImageUrl: 'assets/images/celine.png',
        userName: 'Jane Smith',
        rating: 5.0,
        comment: 'Dr. Smith provided exceptional care. Very knowledgeable.',
      ),
      Review(
        userImageUrl: 'assets/images/celine.png',
        userName: 'Jane Smith',
        rating: 5.0,
        comment: 'Dr. Smith provided exceptional care. Very knowledgeable.',
      ),
      // Tambahkan review lainnya jika diperlukan
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Reviews'),
      ),
      body: Column(
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: Image.asset(
                doctor.imageUrl,
                width: 120.0,
                height: 120.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            'dr. Muhammad Rifky Afandi, SpKj',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          Text(
            'Spesialis Kejiwaan',
            style: TextStyle(fontSize: 14.0, color: Colors.grey),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                doctor.rating.toString() + ' |',
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
              Icon(
                Icons.star_rate_rounded,
                color: Colors.yellow,
                size: 48,
              ),
              Icon(
                Icons.star_rate_rounded,
                color: Colors.yellow,
                size: 48,
              ),
              Icon(
                Icons.star_rate_rounded,
                color: Colors.yellow,
                size: 48,
              ),
              Icon(
                Icons.star_rate_rounded,
                color: Colors.yellow,
                size: 48,
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Text(
            '(${doctor.ratingCount} Reviews)',
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
          Expanded(
            child: ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(review.userImageUrl),
                        radius: 30.0,
                      ),
                      title: Text(
                        review.userName,
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
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review.comment,
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
      ),
    );
  }
}
