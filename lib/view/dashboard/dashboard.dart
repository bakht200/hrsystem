import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
                      "${DateFormat("dd MM yyyy").format(DateTime.now())}",
                      style: const TextStyle(
                          color: Color(0xff2d386b),
                          fontSize: 18,
                          fontWeight: FontWeight.w300),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: const Color(0xFF30475E),
                      border: Border.all(
                        color: const Color(0xFF30475E),
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: const Center(
                      child: Text(
                    "Check in",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ))),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
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
                  width: 20,
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
