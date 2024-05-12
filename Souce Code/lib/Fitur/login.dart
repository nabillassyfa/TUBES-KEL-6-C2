import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tp2/provider/p_user.dart';
import 'signup.dart';
import 'bottomNavBar.dart';

class LoginMenu extends StatefulWidget {
  @override
  _LoginMenuState createState() => _LoginMenuState();
}

class _LoginMenuState extends State<LoginMenu> {
  bool _isObscure = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        "Masuk",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Hai! Selamat datang kembali.",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: <Widget>[
                        inputFile(label: "Email"),
                        inputFile(label: "Password", obscureText: _isObscure)
                      ],
                    ),
                  ),
                  SizedBox(height: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Add your onTap functionality here
                          print("Circular container tapped!");
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(width: 1, color: Colors.black),
                          ),
                          margin: EdgeInsets.only(left: 21),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Ingatkan Password",
                        style: TextStyle(fontSize: 10),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SignupPage()),
                              );
                            },
                            child: Text(
                              "Lupa password?",
                              style: TextStyle(
                                color: Color.fromARGB(255, 1, 101, 252),
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      padding: EdgeInsets.only(top: 3, left: 3),
                      child: MaterialButton(
                        minWidth: 300,
                        height: 60,
                        onPressed: () async {
                          try {
                            Map<String, dynamic> loginResponse = await userProvider.login(
                              emailController.text.trim(), // Ambil email dari input field
                              passwordController.text.trim(), // Ambil password dari input field
                            );
                            print('Login successful: $loginResponse');
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => const BottomNavBar(idx: 0)),
                              (Route<dynamic> route) => false,
                            );
                          } catch (e) {
                            print('Login failed: $e');
                            // Handle login failure, show error message, etc.
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Email atau password tidak sesuai'),
                                duration: Duration(seconds: 2), // Durasi pemberitahuan
                              ),
                            );
                          }
                        },
                        color: Color.fromARGB(255, 1, 101, 252),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          "Masuk",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  //Lainnya
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     Expanded(
                         child: Divider(
                          color: Colors.black,
                          height: 36, // Tinggi garis
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "Lainnya",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.black,
                          height: 36, // Tinggi garis
                        ),
                      ),
                    ],
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 250,
                          height: 35,
                          padding: EdgeInsets.all(8), // Menambahkan padding
                          margin: EdgeInsets.all(8), // Menambahkan margin
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10), // Memberikan border radius
                            border: Border.all(
                              color: Colors.black, // Warna border
                              width: 1, // Ketebalan border
                            ),
                          ),
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: const [
                              Image(
                                image: AssetImage("assets/images/google.png"),
                                width: 20,
                                height: 20,
                              ),
                              SizedBox(width: 12),
                              Text('Masuk dengan Google', style: TextStyle(fontSize: 10),),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 0.25),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 250,
                          height: 35,
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: const [
                              Image(
                                image: AssetImage("assets/images/facebook (1).png"),
                                width: 20,
                                height: 20,
                              ),
                              SizedBox(width: 12),
                              Text('Masuk dengan Facebook', style: TextStyle(fontSize: 10),),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 0.25),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 250,
                          height: 35,
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: const [
                              Image(
                                image: AssetImage("assets/images/apple.png"),
                                width: 20,
                                height: 20,
                              ),
                              SizedBox(width: 12),
                              Text('Masuk dengan Apple', style: TextStyle(fontSize: 10),),
                            ],
                          ),
                        ),
                      ),
                      Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Belum punya akun?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignupPage()),
                          );
                        },
                        child: Text(
                          "Daftar",
                          style: TextStyle(
                            color: Color.fromARGB(255, 1, 101, 252), // Menambahkan warna teks
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            decoration: TextDecoration.underline, // Menambahkan garis bawah
                          ),
                        ),
                      ),
                    ],
                  ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Widget untuk input field
  Widget inputFile({label, obscureText = false}) {
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
          controller: label == "Email" ? emailController : passwordController, // Sesuaikan controller
          obscureText: label == "Password" ? _isObscure : false,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            suffixIcon: icon,
          ),
        ),
        SizedBox(height: 1),
      ],
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

