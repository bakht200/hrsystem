import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hr_system/view/edit_screen.dart';

import 'authentication/login.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  TextEditingController nameEditingController = TextEditingController();

  bool? loading;

  @override
  void initState() {
    super.initState();
    // fetchUserData();
  }

  // Future fetchUserData() async {
  //   setState(() {
  //     loading = true;
  //   });
  //   await profileController.getUserData();

  //   setState(() {
  //     loading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFF30475E),
          title: Text(
            "Settings",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 4.0),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(
                          "https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Zain Tariq',
                              style: TextStyle(color: Colors.black),
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                            )
                          ],
                        ),
                        Text(
                          'zaintariq@gmail.com',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (builder) => EditProfilePage()));
              },
              leading: Icon(Icons.person),
              title: Text('Account Settings',
                  style: TextStyle(color: Colors.black)),
              trailing: Wrap(
                spacing: 5,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Icon(
                      Icons.navigate_next,
                      size: 35,
                      color: (Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            ListTile(
              onTap: () {
                // Logout and navigate to the login screen
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false,
                );
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (builder) => EditProfilePage()));
              },
              leading: Icon(Icons.logout),
              title: Text('Logout', style: TextStyle(color: Colors.black)),
            ),
            // ListTile(
            //   leading: Icon(
            //     Icons.notifications,
            //     color: Color(AppTheme.primaryColor),
            //     size: 25.h,
            //   ),
            //   title: Text('Notification',
            //       style: AppTheme.settingListTileHeadingStyle),
            //   trailing: Wrap(
            //     spacing: 5,
            //     children: <Widget>[
            //       Padding(
            //         padding: EdgeInsets.only(top: 5.0.h),
            //         child: Icon(
            //           Icons.navigate_next,
            //           size: 35.sp,
            //           color: Color(AppTheme.primaryColor),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // ListTile(
            //   leading: Icon(
            //     Icons.remove_red_eye,
            //     color: Color(AppTheme.primaryColor),
            //     size: 25.h,
            //   ),
            //   title: Text('Appearance',
            //       style: AppTheme.settingListTileHeadingStyle),
            //   trailing: Wrap(
            //     spacing: 5,
            //     children: <Widget>[
            //       Padding(
            //         padding: EdgeInsets.only(top: 5.0.h),
            //         child: Icon(
            //           Icons.navigate_next,
            //           size: 35.sp,
            //           color: Color(AppTheme.primaryColor),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            // GestureDetector(
            //   onTap: () {
            //     Navigator.of(context).push(MaterialPageRoute(
            //         builder: (builder) => PrivacyScreen()));
            //   },
            //   child: ListTile(
            //     leading: Icon(
            //       Icons.lock,
            //       color: Color(AppTheme.primaryColor),
            //       size: 25.h,
            //     ),
            //     title: Text('Privacy & Security',
            //         style: AppTheme.settingListTileHeadingStyle),
            //     trailing: Wrap(
            //       spacing: 5,
            //       children: <Widget>[
            //         Padding(
            //           padding: EdgeInsets.only(top: 5.0.h),
            //           child: Icon(
            //             Icons.navigate_next,
            //             size: 35.sp,
            //             color: Color(AppTheme.primaryColor),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.of(context).push(MaterialPageRoute(
            //         builder: (builder) => HelpScreen()));
            //   },
            //   child: ListTile(
            //     leading: Icon(
            //       Icons.headphones,
            //       color: Color(AppTheme.primaryColor),
            //       size: 25.h,
            //     ),
            //     title: Text('Help & Support',
            //         style: AppTheme.settingListTileHeadingStyle),
            //     trailing: Wrap(
            //       spacing: 5,
            //       children: <Widget>[
            //         Padding(
            //           padding: EdgeInsets.only(top: 5.0.h),
            //           child: Icon(
            //             Icons.navigate_next,
            //             size: 35.sp,
            //             color: Color(AppTheme.primaryColor),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.of(context).push(MaterialPageRoute(
            //         builder: (builder) => FeedbackScreen()));
            //   },
            //   child: ListTile(
            //     leading: Icon(
            //       Icons.help_center,
            //       color: Color(AppTheme.primaryColor),
            //       size: 25.h,
            //     ),
            //     title: Text('About',
            //         style: AppTheme.settingListTileHeadingStyle),
            //     trailing: Wrap(
            //       spacing: 5,
            //       children: <Widget>[
            //         Padding(
            //           padding: EdgeInsets.only(top: 5.0.h),
            //           child: Icon(
            //             Icons.navigate_next,
            //             size: 35.sp,
            //             color: Color(AppTheme.primaryColor),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // Divider(),
            // Padding(
            //   padding: EdgeInsets.all(8.0.w),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Padding(
            //         padding: EdgeInsets.only(left: 8.0.w),
            //         child: GestureDetector(
            //           child: Text(
            //             '',
            //             style: AppTheme.appBarSubHeadingStyle,
            //           ),
            //         ),
            //       ),
            //       Padding(
            //         padding: EdgeInsets.all(8.0.w),
            //         child: Row(
            //           children: [
            //             Text(
            //               "Version: 0.1",
            //               style: AppTheme.tabBarHeadingStyle,
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
