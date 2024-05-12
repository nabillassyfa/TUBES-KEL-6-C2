import 'dart:ui';

import 'package:flutter/material.dart';
import 'landingPage3.dart';
import 'login.dart';


class LP2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: Container(
            width: 10, // Menyesuaikan lebar kotak
            height: 10, // Menyesuaikan tinggi kotak
            decoration: BoxDecoration(
              shape: BoxShape.circle, // Mengatur bentuk kotak menjadi lingkaran
              color: Colors.white, // Warna latar belakang
              border: Border.all(width: 0, color: Colors.white),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.black,
              ),
            ),
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10),
              width: 70, // Atur lebar kotak menjadi 20
              height: 30, // Atur tinggi kotak menjadi 10
              child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginMenu()));
                },
                child: Text(
                  "Lewati",
                  style: TextStyle(color: Color.fromARGB(255, 1, 101, 252), fontSize: 10),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(width: 1, color: Color.fromARGB(255, 1, 101, 252)), 
              ),
            ),
          ],
        ),
      body: SafeArea(
        child: Container(

          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            // even space distribution
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/image-5.png")
                      )
                    ),
                  ),
                  RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Dapat Dengan Mudah Membuat ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.black, // Adjust color as needed
                        ),
                      ),
                      TextSpan(
                        text: "Janji Temu",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Color.fromARGB(255, 1, 101, 252), // Change to your preferred color
                        ),
                      ),
                    ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Membuat janji temu beberapa hari sebelum, dari rumah tanpa harus datang langsung ke rumah sakit. Mudah dan cepat. ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 12,

                  ),)
                ],
              ),
              

              Column(
                children: <Widget>[
                  SizedBox(height:20),
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> LP3()));

                    },
                    color: Color.fromARGB(255, 1, 101, 252),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: Text(
                      "Selanjutnya",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18
                      ),
                    ),
                  )

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

