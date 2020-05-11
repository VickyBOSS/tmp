import 'package:flutter/material.dart';
import 'package:quiki/tabs/local_quizes_tab.dart';

class LocalQuizesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Quizes"),
      ),
      body: SafeArea(child: LocalQuizesTab()),
    );
  }
}
