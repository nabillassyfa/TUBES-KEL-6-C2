import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp2/provider/p_user.dart';
import 'login.dart'; // Import halaman login.dart jika belum diimport
import 'syarat_dan_ketentuan.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _isObscure = true;
  final TextEditingController namaController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController noTelpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

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
          icon: Icon(
            Icons.arrow_circle_left_outlined,
            size: 40,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "Daftar",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Hai! Selamat Datang. ",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  inputFile(label: "Nama Lengkap", controller: namaController),
                  SizedBox(height: 12),
                  inputFile(label: "Username", controller: usernameController),
                  SizedBox(height: 12),
                  inputFile(
                      label: "Password",
                      obscureText: _isObscure,
                      controller: passwordController),
                  SizedBox(height: 12),
                  inputFile(label: "Email", controller: emailController),
                  SizedBox(height: 12),
                  inputFile(
                      label: "No Handphone", controller: noTelpController),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, // Shape set to circle
                      color: Colors.white, // Background color
                      border: Border.all(width: 1, color: Colors.black),
                    ),
                  ),
                  SizedBox(width: 8),
                  Row(
                    // Wrap the text widgets in a column
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Saya menyetujui",
                        style: TextStyle(fontSize: 14),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SyaratDanKetentuanPage()),
                          );
                        },
                        child: Text(
                          "Syarat dan ketentuan",
                          style: TextStyle(
                            color: Color.fromARGB(
                                255, 1, 101, 252), // Menambahkan warna teks
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            decoration: TextDecoration
                                .underline, // Menambahkan garis bawah
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 3, left: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () async {
                    try {
                      Map<String, dynamic> signupResponse =
                          await userProvider.signUp(
                        namaController.text.trim(),
                        usernameController.text.trim(),
                        emailController.text.trim(),
                        passwordController.text.trim(),
                        noTelpController.text.trim(),
                      );
                      print('Signup successful: $signupResponse');
                      // Add navigation or show success message
                      // Tampilkan dialog akun terdaftar
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Akun Telah Terdaftar'),
                            content: Text('Silahkan login untuk melanjutkan.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // Tutup dialog
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginMenu()),
                                  ); // Pindah ke halaman login
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    } catch (e) {
                      print('Signup failed: $e');
                      // Handle signup failure, show error message, etc.
                    }
                  },
                  color: Color.fromARGB(255, 1, 101, 252),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    "Daftar",
                    style: TextStyle(
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
                        color: Color.fromARGB(
                            255, 1, 101, 252), // Menambahkan warna teks
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        decoration:
                            TextDecoration.underline, // Menambahkan garis bawah
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

  // Widget untuk input field
  Widget inputFile(
      {label, obscureText = false, required TextEditingController controller}) {
    Widget? icon;
    if (label == "Password") {
      icon = IconButton(
        icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
        onPressed: () {
          setState(() {
            _isObscure = !_isObscure;
          });
        },
      );
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
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: 8, horizontal: 10), // Adjusted vertical padding
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
}
