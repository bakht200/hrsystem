import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hr_system/view/leave.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

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
        title: const Text('Hour Tracker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Start Time: $formattedStartTime',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 16.0),
            Text(
              'End Time: $formattedEndTime',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Logged Time: $formattedLoggedTime',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 32.0),
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
          title: const Text('Change Button Text on Tap'),
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

List<Map> list = [];

class _MyButtonState extends State<MyButton> {
  String buttonText = 'Check in';
  int arraylenght = 0;
  Color buttonColor = const Color(0xFF30475E);
  List<Map<String, dynamic>> fetchResultList = [];
  //Length
  Future<int> getLastIndexNumber() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (snapshot.exists) {
      Map<String, dynamic>? userData = snapshot.data() as Map<String, dynamic>?;

      if (userData != null && userData.containsKey('list')) {
        List<dynamic> dataList = userData['list'] as List<dynamic>;

        int lastIndex = dataList.length - 1;
        return lastIndex;
      }
    }

    // Return -1 if the list is empty or the data is not found
    return -1;
  }

  //check in button
  Future<void> addUserCollection() async {
    List<Map<String, dynamic>> updatedList = await getListFromFirestore();
    var temp = DateFormat.Hm().format(DateTime.now());
    Map<String, dynamic> map = {
      'CHECKIN': DateTime.now().toIso8601String(),
      'CHECKOUT': DateTime.now().toIso8601String(),
      'AVERAGE': Duration(seconds: 0).toString(),
      'user': FirebaseAuth.instance.currentUser!.uid
    };
    updatedList.add(map);
    int lastIndex = await getLastIndexNumber();

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({'list': updatedList});

      print("Student data added successfully");
    } catch (error) {
      print("Student couldn't be added: $error");
    }

    setState(() {
      list = updatedList;
    });
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    String formattedDuration =
        "${twoDigits(duration.inHours)}:${twoDigitMinutes}:${twoDigitSeconds}";
    return formattedDuration;
  }

  //checked in button
  signout() async {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
    DocumentReference userDocRef =
        usersCollection.doc(FirebaseAuth.instance.currentUser!.uid);

    DocumentSnapshot snapshot = await userDocRef.get();

    if (snapshot.exists) {
      Map<String, dynamic>? userData = snapshot.data() as Map<String, dynamic>?;

      if (userData != null && userData.containsKey('list')) {
        List<dynamic> dataList = userData['list'] as List<dynamic>;

        List<Map<String, dynamic>> resultList =
            dataList.map((item) => item as Map<String, dynamic>).toList();

        DateTime checkinDateTime = DateTime.parse(resultList.last['CHECKIN']);
        DateTime checkoutDateTime = DateTime.now();
        Duration averageDateTime = checkoutDateTime.difference(checkinDateTime);
        Map<String, dynamic> lastIndex = {
          'AVERAGE': averageDateTime.toString(),
          'CHECKIN': checkinDateTime.toIso8601String(),
          'CHECKOUT': checkoutDateTime.toIso8601String(),
          'user': FirebaseAuth.instance.currentUser?.uid,
        };
//
        resultList.removeLast();
        resultList.add(lastIndex);

        await userDocRef.update({'list': resultList});
      }
    }
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

        buttonText = 'Checked in, Check out';
        buttonColor = Colors.green;
      } else {
        signout();
        buttonText = 'Check in';
        buttonColor = const Color(0xFF30475E);
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
            style: const TextStyle(
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

  List<String> weekdays = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 244, 244),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Row(
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
              const SizedBox(
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
                      TimerBuilder.periodic(const Duration(seconds: 1),
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
                            builder: (context) => const LeaveScreen(),
                          ),
                        );
                      },
                      child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: const Color(0xFFF05454),
                              border: Border.all(
                                color: const Color(0xFFF05454),
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
                  const SizedBox(
                    width: 0,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
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
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFD5E6F7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: StreamBuilder(
                        stream: getDataStream(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: 6,
                              itemBuilder: (context, index) {
                                Map<String, dynamic> itemData = snapshot
                                    .data![snapshot.data!.length - 1 - index];

                                DateTime checkIn =
                                    DateTime.parse(itemData['CHECKIN']);
                                String average = itemData['AVERAGE'];
                                DateTime checkOut =
                                    DateTime.parse(itemData['CHECKOUT']);

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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Text(
                                                weekdays[checkIn
                                                    .weekday], // Subtract 1 since weekday values start from 1
                                                style: const TextStyle(
                                                  color: Color(0xff2d386b),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${checkIn.hour} - ${checkOut.hour}',
                                                style: const TextStyle(
                                                  color: Color(0xff2d386b),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Text(
                                                '${((checkOut.difference(checkIn).inSeconds) / 3600).floor()}hr ${((checkOut.difference(checkIn).inSeconds) % 3600 ~/ 60).toString().padLeft(2, '0')}min ${((checkOut.difference(checkIn).inSeconds) % 60).toString().padLeft(2, '0')}sec',
                                                style: const TextStyle(
                                                  color: Color(0xff2d386b),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else if (ConnectionState.waiting ==
                              snapshot.connectionState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return const Center(
                              child: Text('Data not found'),
                            );
                          }
                        })),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Stream<List<dynamic>> getDataStream() {
  return Stream.periodic(Duration(seconds: 5), (_) {
    return getListFromFirestore(); // Call your asynchronous function here
  }).asyncMap((event) async => await event);
}

Future<List<Map<String, dynamic>>> getListFromFirestore() async {
  String userId = FirebaseAuth.instance.currentUser!.uid;

  DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('users').doc(userId).get();

  if (snapshot.exists) {
    Map<String, dynamic>? userData = snapshot.data();

    if (userData != null && userData.containsKey('list')) {
      List<dynamic> dataList = userData['list'];
      List<Map<String, dynamic>> resultList =
          dataList.map((item) => item as Map<String, dynamic>).toList();
      return resultList;
    }
  }

  return [];
}
