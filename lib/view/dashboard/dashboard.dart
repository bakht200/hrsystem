import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hr_system/view/leave.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';

String buttonText = 'Check in';

class HourTrackerPage extends StatefulWidget {
  @override
  _HourTrackerPageState createState() => _HourTrackerPageState();
}

class _HourTrackerPageState extends State<HourTrackerPage> {
  DateTime? startTime;
  DateTime? endTime;
  Duration? loggedTime;

  void startLogging() {
    setState(() {
      startTime = DateTime.now();
      endTime = null;
      loggedTime = null;
    });
  }

  void stopLogging() {
    setState(() {
      endTime = DateTime.now();
      loggedTime = endTime!.difference(startTime!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final formattedStartTime = startTime != null
        ? DateFormat('HH:mm:ss').format(startTime!)
        : 'Not started';
    final formattedEndTime = endTime != null
        ? DateFormat('HH:mm:ss').format(endTime!)
        : 'Not stopped';
    final formattedLoggedTime = loggedTime != null
        ? '${loggedTime!.inHours}h ${loggedTime!.inMinutes.remainder(60)}m'
        : 'Not logged';

    return Scaffold(
      appBar: AppBar(
        title: Text('Hour Tracker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Start Time: $formattedStartTime',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'End Time: $formattedEndTime',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Logged Time: $formattedLoggedTime',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: startTime == null ? startLogging : stopLogging,
              child: Text(startTime == null ? 'Start Logging' : 'Stop Logging'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Change Button Text on Tap'),
        ),
        body: Center(
          child: MyButton(),
        ),
      ),
    );
  }
}

class MyButton extends StatefulWidget {
  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  String buttonText = 'Check in';
  Color buttonColor = Color(0xFF30475E);

  Future<void> addUserCollection() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc()
        .collection('attendance')
        .add({
      'CHECKIN': '123123123123',
      'id': '1234',
      'CHECKOUT': '0',
      'AVERAGE': '0'
    }).then((value) {
      print("Student data Added");
    }).catchError((error) {
      print("Student couldn't be added.");
    });
  }

  signout() {
    FirebaseFirestore.instance
        .collection('users')
        .doc()
        .collection('attendance')
        .doc()
        .update({'CHECKOUT': '0', 'AVERAGE': '0'}).then((value) {
      print("Student data Added");
    }).catchError((error) {
      print("Student couldn't be added.");
    });
  }

  void changeButtonText() {
    setState(() {
      if (buttonText == 'Check in') {
        addUserCollection();

        Fluttertoast.showToast(
            msg: "Signed in at " + DateTime.now().toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);

        buttonText = 'Checked in';
        buttonColor = Colors.green;
      } else {
        buttonText = 'Check in';
        buttonColor = Color(0xFF30475E);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: changeButtonText,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: buttonColor,
          border: Border.all(
            color: buttonColor,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String buttonText = 'Check in';

  void changeButtonText() {
    setState(() {
      if (buttonText == 'Check in') {
        buttonText = 'Checked in';
      } else {
        buttonText = 'Check in';
      }
    });
  }

  String getSystemTime() {
    var now = new DateTime.now();
    return new DateFormat("hh:mm:ss a").format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 244, 244, 244),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww&w=1000&q=80'),
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Home',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF30475E),
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Icon(Icons.notifications)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 140,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TimerBuilder.periodic(Duration(seconds: 1),
                        builder: (context) {
                      return Text(
                        "${getSystemTime()}",
                        style: const TextStyle(
                            color: Color(0xff2d386b),
                            fontSize: 50,
                            fontWeight: FontWeight.w300),
                      );
                    }),
                    Text(
                      "${DateFormat.yMMMMd('en_US').format(DateTime.now())}",
                      style: const TextStyle(
                          color: Color(0xff2d386b),
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            MyButton(),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LeaveScreen(),
                        ),
                      );
                    },
                    child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color(0xFFF05454),
                            border: Border.all(
                              color: Color(0xFFF05454),
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: const Center(
                            child: Text(
                          "Request Leave",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ))),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color(0xFF121212),
                            border: Border.all(
                              color: Color(0xFF121212),
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Center(
                            child: Text(
                          "WFH",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ))),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  'Record',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFD5E6F7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                    itemCount: 10,
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      'Thursday',
                                      style: TextStyle(
                                          color: Color(0xff2d386b),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '9 - 5 pm',
                                      style: TextStyle(
                                          color: Color(0xff2d386b),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Work from home',
                                      style: TextStyle(
                                          color: Color(0xff2d386b),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      '9 hours',
                                      style: TextStyle(
                                          color: Color(0xff2d386b),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    })),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
