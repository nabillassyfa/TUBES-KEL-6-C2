import 'package:flutter/material.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          child: IconButton(
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
        title: const Text('Maps',
            style: TextStyle(fontWeight: FontWeight.w700),
            textAlign: TextAlign.center),
        elevation: 10,
        shadowColor: Colors.white,
      ),
      body: Stack(
        children: <Widget>[
          // Container dengan gambar di latar belakang
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/maps.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(children: [
              TextField(
                decoration: InputDecoration(
                  hintText: "Cari ",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  contentPadding: EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ),
            ]),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MaterialButton(
                    onPressed: () {},
                    color: Color.fromARGB(255, 1, 101, 252),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    height: 50,
                    child: Text(
                      "Mulai",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
