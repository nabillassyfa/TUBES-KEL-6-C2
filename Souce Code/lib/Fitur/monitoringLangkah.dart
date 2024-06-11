import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perhitungan Langkah',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _count = 0;
  bool _isGoogleFitConnected = false;
  bool _isFitBitConnected = false;

  void _incrementCount() {
    setState(() {
      _count++;
    });
  }

  void _decrementCount() {
    setState(() {
      if (_count > 0) {
        _count--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perhitungan Langkah'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Container(
              height: 2.0,
              color: Colors.blue,
            ),
          ),
          Text(
            'Atur Target Harianmu',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: _decrementCount,
              ),
              Text(
                '$_count',
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: _incrementCount,
              ),
            ],
          ),
          SizedBox(height: 40.0),
          Container(
            height: 2.0,
            color: Colors.blue,
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SwitchListTile(
                  title: Text('Hubungkan Google Fit'),
                  value: _isGoogleFitConnected,
                  onChanged: (bool value) {
                    setState(() {
                      _isGoogleFitConnected = value;
                    });
                  },
                ),
                SwitchListTile(
                  title: Text('Hubungkan FitBit'),
                  value: _isFitBitConnected,
                  onChanged: (bool value) {
                    setState(() {
                      _isFitBitConnected = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
