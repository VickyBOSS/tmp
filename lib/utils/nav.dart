import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Nav {
  static void push(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}
