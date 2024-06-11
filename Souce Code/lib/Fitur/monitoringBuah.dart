import 'package:flutter/material.dart';

void main() {
  runApp(MyFruit());
}

class MyFruit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_circle_left_outlined,
            size: 40,
            color: Colors.black,
          ),
        ),
          title: Text(
            'Makan Buah',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          elevation: 0, // Menghilangkan shadow
        ),
        body: Column(
          children: [
            SizedBox(height: 20), // Jarak antara judul dan garis biru
            Container(
              height: 2, // Ketebalan garis
              color: Colors.blue,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Cari Buah',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(
                          Icons.search,
                          color:
                              Colors.blue, // Mengubah warna ikon menjadi biru
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20), // Jarak antara kolom cari dan kontainer buah
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  FruitContainer(
                    imagePath: 'assets/images/fruit.jpg',
                    fruitName: 'Jeruk',
                    description: 'Jeruk Segar',
                  ),
                  SizedBox(height: 20),
                  FruitContainer(
                    imagePath: 'assets/images/fruit.jpg',
                    fruitName: 'Apel',
                    description: 'Apel Manis',
                  ),
                  SizedBox(height: 20),
                  FruitContainer(
                    imagePath: 'assets/images/fruit.jpg',
                    fruitName: 'Pisang',
                    description: 'Pisang Matang',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FruitContainer extends StatelessWidget {
  final String imagePath;
  final String fruitName;
  final String description;

  FruitContainer({
    required this.imagePath,
    required this.fruitName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Container(
            width: 80.0,
            height: 80.0,
            child: Image.asset(imagePath),
          ),
          SizedBox(width: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fruitName,
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 5.0),
              Text(
                description,
                style: TextStyle(fontSize: 14.0, color: Colors.grey),
              ),
            ],
          ),
          Spacer(),
          Checkbox(
            value: false, // Tandai sesuai kebutuhan
            onChanged: (value) {
              // Tambahkan fungsi ketika checkbox berubah
            },
          ),
        ],
      ),
    );
  }
}
