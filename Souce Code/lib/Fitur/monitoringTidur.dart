import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monitoring Waktu Tidur',
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
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

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

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _startTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _startTime) {
      setState(() {
        _startTime = picked;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _endTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _endTime) {
      setState(() {
        _endTime = picked;
      });
    }
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final format = DateFormat.jm(); // 'jm' for '6:00 AM'
    return format.format(dt);
  }

  String _calculateDuration() {
    if (_startTime == null || _endTime == null) {
      return '';
    }

    final start = DateTime(0, 1, 1, _startTime!.hour, _startTime!.minute);
    final end = DateTime(0, 1, 1, _endTime!.hour, _endTime!.minute);

    Duration duration;
    if (end.isAfter(start)) {
      duration = end.difference(start);
    } else {
      // If end time is before start time, it means the end time is on the next day
      duration = end.add(Duration(days: 1)).difference(start);
    }

    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);

    return '$hours hours $minutes minutes';
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
          SizedBox(height: 20.0),
          Container(
            height: 2.0,
            color: Colors.blue,
          ),
          SizedBox(height: 20.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    'Start',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _selectStartTime(context),
                    child: Text(
                      _startTime == null ? 'Select' : _formatTimeOfDay(_startTime!),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Icon(Icons.access_time, size: 24.0),
              SizedBox(height: 20.0),
              Column(
                children: [
                  Text(
                    'End',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _selectEndTime(context),
                    child: Text(
                      _endTime == null ? 'Select' : _formatTimeOfDay(_endTime!),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              if (_startTime != null && _endTime != null)
                Text(
                  'Duration: ${_calculateDuration()}',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
