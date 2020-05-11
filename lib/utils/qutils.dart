import 'package:flutter/material.dart';

class QUtils {
  static SnackBar errorSnackBar({@required String message}) {
    return SnackBar(
      backgroundColor: Colors.white10,
      content: Row(
        children: <Widget>[
          // SizedBox(
          //   width: 10,
          // ),
          Icon(
            Icons.error,
            color: Colors.red,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "Error ! $message",
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }
}
