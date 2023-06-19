import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class HoursTracker extends StatefulWidget {
  @override
  _HoursTrackerState createState() => _HoursTrackerState();
}

class _HoursTrackerState extends State<HoursTracker> {
  late DateTime startTime;
  DateTime? endTime;
  Duration totalHours = Duration.zero;
  Duration pausedDuration = Duration.zero;
  bool isTracking = false;
  bool isPaused = false;

  void startTracking() {
    setState(() {
      startTime = DateTime.now();
      endTime = null;
      isTracking = true;
      isPaused = false;
    });
  }

  void stopTracking() {
    setState(() {
      endTime = DateTime.now();
      totalHours += endTime!.difference(startTime) - pausedDuration;
      startTime = DateTime.now();
      pausedDuration = Duration.zero;
      isTracking = false;
      isPaused = false;
      saveTotalHours();
    });
  }

  void pauseTracking() {
    setState(() {
      if (isTracking && !isPaused) {
        pausedDuration += DateTime.now().difference(startTime);
        isPaused = true;
      } else if (isTracking && isPaused) {
        startTime = DateTime.now();
        isPaused = false;
      }
    });
  }

  Future<void> saveTotalHours() async {
    try {
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final user = FirebaseFirestore.instance.collection('users').doc('user1');

      await user.collection('hours').doc(today).set({
        'totalHours': totalHours.inHours,
      });

      print('Total hours saved successfully!');
    } catch (e) {
      print('Error saving total hours: $e');
    }
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '${duration.inHours}:$twoDigitMinutes:$twoDigitSeconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hours Tracker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isTracking && !isPaused) Text('Tracking in progress...'),
            if (isTracking && isPaused) Text('Tracking paused...'),
            if (!isTracking)
              Text('Total hours logged: ${formatDuration(totalHours)}'),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => isTracking ? pauseTracking() : startTracking(),
              child: Text(isTracking && !isPaused ? 'Pause' : 'Start'),
            ),
            SizedBox(height: 10.0),
            if (isTracking && isPaused)
              ElevatedButton(
                onPressed: pauseTracking,
                child: Text('Resume'),
              ),
            if (isTracking && !isPaused)
              ElevatedButton(
                onPressed: stopTracking,
                child: Text('Stop'),
              ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HoursTracker(),
  ));
}
