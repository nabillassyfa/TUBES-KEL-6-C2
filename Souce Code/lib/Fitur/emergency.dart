import 'package:flutter/material.dart';
import 'dart:ui';
import '../widget/Rs_widget.dart';
import '../provider/P_RS.dart';
import 'package:provider/provider.dart';

class Emergency extends StatelessWidget {
  const Emergency({Key? key}) : super(key: key);

  // Emergency phone number
  static const String emergencyNumber = '1-12345-123';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RSProvider()..getdataRS(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
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
        ),
        body: Consumer<RSProvider>(
          builder: (context, value, child) {
            if (value.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            // Display product grid
            return SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          'Panggilan Darurat',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Dapatkan bantuan gawat darurat dari Doa Ibu Hospital',
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                    const SizedBox(height: 90),
                    Column(
                      children: <Widget>[
                        TextField(
                          readOnly: true, // Make the TextField read-only
                          decoration: InputDecoration(
                            hintText: emergencyNumber, // Display emergency number
                            labelText: 'Hubungi Kami',
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              color: Colors.red,
                              onPressed: () {
                               
                              },
                              icon: Icon(Icons.call),
                            ),
                          ),
                          keyboardType: TextInputType.phone,
                      
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: MediaQuery.of(context).size.height - kToolbarHeight - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
                      padding: const EdgeInsets.all(10),
                      child: ListView.builder(
                        itemCount: value.dataRS.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: RSWidget(data: value.dataRS[index], asal: "emergency",),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}