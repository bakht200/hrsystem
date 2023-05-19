import 'package:flutter/material.dart';

SnackBar snackBar(title, icon, color) {
  return SnackBar(
    duration: Duration(seconds: 1),
    content: Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          title,
          style: TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.all(30.0),
    backgroundColor: color,
  );
}
