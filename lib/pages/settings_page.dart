import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Box settingsBox = Hive.box("settings");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings Page"),
      ),
      body: SafeArea(
        child: Container(
          child: ListView(
            children: ListTile.divideTiles(
                context: context, tiles: [themeSettingsWidget()]).toList(),
          ),
        ),
      ),
    );
  }

  Widget themeSettingsWidget() => ValueListenableBuilder(
        valueListenable: settingsBox.listenable(),
        builder: (_, Box box, child) {
          return SwitchListTile(
              title: Text("Dark Mode"),
              value: box.get("darkMode") ?? false,
              onChanged: (val) {
                box.put("darkMode", val);
              });
        },
      );
}
