import 'package:flutter/material.dart';


class Denah extends StatefulWidget {
  @override
  _DenahState createState() => _DenahState();
}

class _DenahState extends State<Denah> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      leading: Container(
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_circle_left_outlined,
            size: 30,
            color: Colors.black,
          ),
        ),
      ),
      title: const Text('Denah',
          style: TextStyle(fontWeight: FontWeight.w700), textAlign: TextAlign.center),
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
              image: AssetImage('assets/images/denah1.png'),
              // fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SizedBox(height: 10,),
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
              ]
            ),
          ),
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
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Lantai 1",
                        style: TextStyle(fontSize: 25),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(250, 206, 222, 245),
                          border: Border.all(
                            color: Color.fromARGB(255, 1, 101, 252)
                          ),
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: IconButton(
                          iconSize: 35,
                          onPressed: () {},
                          icon: Icon(
                            Icons.filter_none_rounded,
                            color: Color.fromARGB(255, 1, 101, 252),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}