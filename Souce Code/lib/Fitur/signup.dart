import 'package:flutter/material.dart';
import 'login.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_circle_left_outlined,
            size: 40,
            color: Colors.black,),


        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text("Daftar",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,

                  ),),
                  SizedBox(height: 10,),
                  Text("Hai! Selamat Datang. ",
                    style: TextStyle(
                        fontSize: 15,
                        color:Colors.grey[700]),)


                ],
              ),
              Column(
                children: <Widget>[
                  inputFile(label: "Nama Lengkap"),
                  inputFile(label: "Username"),
                  inputFile(label: "Password", obscureText: true),
                  inputFile(label: "Email"),
                  inputFile(label: "No Handphone"),
                ],
              ),
              
               Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, // Shape set to circle
                      color: Colors.white, // Background color
                      border: Border.all(width: 1, color: Colors.black),
                    ),
                    margin: EdgeInsets.only(left: 21), 
                  ),
                  SizedBox(width: 8),
                  Row( // Wrap the text widgets in a column
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Saya menyetujui",
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(width: 8,),
                      Text(
                        "Syarat dan ketentuan",
                        style: TextStyle(
                          color: Color.fromARGB(255, 1, 101, 252), // Menambahkan warna teks
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          decoration: TextDecoration.underline, // Menambahkan garis bawah
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
                 
              Container(
                padding: EdgeInsets.only(top: 3, left: 3),
                decoration:
                BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                ),
                
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () {},
                  color: Color.fromARGB(255, 1, 101, 252),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),

                  ),
                  
                  child: Text(
                    "Daftar", style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.white,

                  ),
                  ),

                ),



              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Sudah punya akun?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginMenu()),
                      );
                    },
                    child: Text(
                      "Masuk",
                      style: TextStyle(
                        color: Color.fromARGB(255, 1, 101, 252), // Menambahkan warna teks
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        decoration: TextDecoration.underline, // Menambahkan garis bawah
                      ),
                    ),
                  ),
                ],
              ),



            ],

          ),


        ),

      ),

    );
  }
}


  // Widget untuk input field
  Widget inputFile({label, obscureText = false}) {
    Widget? icon;
    if (label == "Password") {
      icon = Icon(Icons.visibility_off); // Assign lock icon if true
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 1),
        TextField(
            obscureText: obscureText,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10), // Adjusted vertical padding
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              suffixIcon: icon, // Assign icon to suffixIcon
            ),
          ),
          SizedBox(height: 1), // Adjusted height
      ],
    );
  }
