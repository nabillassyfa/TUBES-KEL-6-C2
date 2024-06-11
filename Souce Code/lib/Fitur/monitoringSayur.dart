import 'package:flutter/material.dart';

class MyVegetable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              size: 24,
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10), // Jarak antara judul dan garis biru
              Text(
                'Makan Sayur',
                style: TextStyle(color: Colors.black, fontSize: 28),
              ),
              SizedBox(height: 10), // Jarak antara judul dan garis biru
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
                          hintText: 'Cari Sayur',
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
              SizedBox(
                  height: 10), // Jarak antara kolom cari dan kontainer sayur
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    VegContainer(
                      imagePath: 'assets/images/vegetable.jpg',
                      vegName: 'Bayam',
                      description: '1 Porsi',
                    ),
                    SizedBox(height: 20),
                    VegContainer(
                      imagePath: 'assets/images/vegetable.jpg',
                      vegName: 'Kangkung',
                      description: '1 Porsi',
                    ),
                    SizedBox(height: 20),
                    VegContainer(
                      imagePath: 'assets/images/vegetable.jpg',
                      vegName: 'Tomat',
                      description: '1 Porsi',
                    ),
                    SizedBox(height: 20),
                    VegContainer(
                      imagePath: 'assets/images/vegetable.jpg',
                      vegName: 'Wortel',
                      description: '1 Porsi',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VegContainer extends StatelessWidget {
  final String imagePath;
  final String vegName;
  final String description;

  VegContainer({
    required this.imagePath,
    required this.vegName,
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
                vegName,
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
