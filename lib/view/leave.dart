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

  void changeBackgroundColor() {
    setState(() {
      _backgroundColor =
          _backgroundColor == Colors.grey ? Colors.blue : Colors.grey;
    });
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
                        'Request Leave',
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
                height: 4,
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
                  buildSquareButton(Colors.red, Icons.star, ("Sick")),
                  buildSquareButton(Colors.blue, Icons.favorite, ("Sick")),
                  buildSquareButton(Colors.green, Icons.thumb_up, ("Sick")),
                  buildSquareButton(Colors.orange, Icons.thumb_down, ("Sick")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSquareButton(Color color, IconData icon, String reason) {
    return GestureDetector(
      onTap: () {
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
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
        ;
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