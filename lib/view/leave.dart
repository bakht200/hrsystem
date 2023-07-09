import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Reason',
        hintText: "Enter the reason why you would like a leave",
        border: OutlineInputBorder(),
      ),
    );
  }
}

class MyDatePicker extends StatefulWidget {
  @override
  _MyDatePickerState createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  DateTime? selectedDate;
  TextEditingController? _dateController;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2024),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dateController?.text = DateFormat('dd-MM-yyyy').format(selectedDate!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          onPressed: () => _selectDate(context),
          child: Text('Select Date'),
        ),
        SizedBox(height: 16.0),
        Text(
          selectedDate != null ? 'Selected Date: ' : 'No date selected',
          style: TextStyle(fontSize: 12),
        ),
        SizedBox(
          height: 6,
        ),
        Text(
          selectedDate != null
              ? '${DateFormat('yMMMEd').format(selectedDate!)}'
              : 'No date selected',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class MyPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Reason'),
              content: Column(
                children: [
                  Text('This is a popup message.'),
                  MyDatePicker(),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Confirm'),
                ),
              ],
            );
          },
        );
      },
      child: Text('Show Popup'),
    );
  }
}

class LeaveScreen extends StatefulWidget {
  const LeaveScreen({super.key});

  @override
  State<LeaveScreen> createState() => _LeaveScreenState();
}

class _LeaveScreenState extends State<LeaveScreen> {
  Color _backgroundColor = Colors.grey;
  TextEditingController _textEditingController = TextEditingController();
  bool isTodaySelected = true;
  DateTime currentDate = DateTime.now();
  String? formattedDate;

  void changeBackgroundColor() {
    setState(() {
      _backgroundColor =
          _backgroundColor == Colors.grey ? Colors.blue : Colors.grey;
    });
  }

  @override
  void initState() {
    formattedDate =
        "${currentDate.day}-${currentDate.month}-${currentDate.year}";
    super.initState();
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
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Request Leave',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF30475E),
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 100,
              ),
              Text(
                "State the reason for taking a leave",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              GridView.count(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                crossAxisCount: 2, // Number of columns
                children: <Widget>[
                  buildSquareButton(
                      Colors.red, Icons.pending_actions, ("Urgent")),
                  buildSquareButton(
                    Colors.blue,
                    Icons.sick,
                    ("Sick"),
                  ),
                  buildSquareButton(
                    Colors.green,
                    Icons.self_improvement,
                    ("PTO"),
                  ),
                  buildSquareButton(Color.fromARGB(255, 237, 139, 46),
                      Icons.more_horiz, ("Other")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSquareButton(
    Color color,
    IconData icon,
    String reason,
  ) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Select date for leave'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isTodaySelected = true;
                            _textEditingController.text = "Today's Date";
                          });

                          DateTime today = DateTime.now();
                          formattedDate =
                              "${today.day}-${today.month}-${today.year}";
                          print(
                              formattedDate); // You can replace this with your desired logic
                        },
                        child: Text("Today"),
                        style: ElevatedButton.styleFrom(
                          primary: isTodaySelected ? Colors.blue : Colors.grey,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isTodaySelected = false;
                            _textEditingController.text = "Tomorrow's Date";
                          });

                          DateTime tomorrow =
                              DateTime.now().add(Duration(days: 1));
                          formattedDate =
                              "${tomorrow.day}-${tomorrow.month}-${tomorrow.year}";
                          print(
                              formattedDate); // You can replace this with your desired logic
                        },
                        child: Text("Tomorrow"),
                        style: ElevatedButton.styleFrom(
                          primary: !isTodaySelected ? Colors.blue : Colors.grey,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    print(formattedDate);
                    final FirebaseAuth auth = FirebaseAuth.instance;
                    User? user = auth.currentUser;
                    final uid = user!.uid;
                    CollectionReference users = FirebaseFirestore.instance
                        .collection('user_leave_request');

                    // Call the user's CollectionReference to add a new user
                    users.add({
                      'status': 'no response',
                      'reason': reason, // John Doe
                      'date': formattedDate, // Stokes and Sons
                      'user': uid,
                      'email': user.email,
                    }).then((value) {
                      print("User Added");
                      Navigator.of(context).pop();
                    }).catchError((error) {
                      Navigator.of(context).pop();

                      print("Failed to add user: $error");
                    });
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            );
          },
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), color: color),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Icon(
                    icon,
                    size: 48.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  reason,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            margin: EdgeInsets.all(8.0),
            width: 150,
            height: 150,
          ),
        ],
      ),
    );
  }
}

class TodayDateButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        DateTime today = DateTime.now();
        String formattedDate = "${today.day}-${today.month}-${today.year}";
        print(formattedDate); // You can replace this with your desired logic
      },
      child: Text("Today's Date"),
      style: ElevatedButton.styleFrom(
        primary: Colors.blue,
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
