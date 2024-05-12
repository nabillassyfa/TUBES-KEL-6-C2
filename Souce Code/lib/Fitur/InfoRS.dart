import 'package:flutter/material.dart';
import 'package:tp2/Fitur/bottomNavBar.dart';
import 'dart:ui';
import '../widget/Rs_widget.dart';
import '../provider/P_RS.dart';
import 'package:provider/provider.dart';

class InfoRS extends StatefulWidget {
  @override
  _InfoRSState createState() => _InfoRSState();
}

class _InfoRSState extends State<InfoRS> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RSProvider()..getdataRS(),
      child: Scaffold(
      appBar: AppBar(
        leading: Container(
        child: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                  BottomNavBar(idx: 0,)
              ),
            );
          },
          icon: Icon(
            Icons.arrow_circle_left_outlined,
            size: 30,
            color: Colors.black,
          ),
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
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height / 12,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/logo.png"),
                            ),
                          ),
                        ),
                        Text(
                          "Informasi Rumah Sakit",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10), // Add space between text and icon
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16, left: 16, right: 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Cari Rumah Sakit",
                hintStyle: TextStyle(color: Colors.grey.shade600),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade600,
                  size: 20,
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: EdgeInsets.all(8),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Colors.grey.shade100,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Column(
              children: [
                Text(
                  "Rumah Sakit Terdekat",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Product grid
          Container(
            height: MediaQuery.of(context).size.height - kToolbarHeight - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: value.dataRS.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: RSWidget(data: value.dataRS[index], asal: "rs",),
                );
              },
            ),
          ),
        ],
      ),
    );
  },
),
      ),
    );
  }
}
