import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quiki/settings/profile_editing_page.dart';
import 'package:quiki/utils/nav.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var info =
      "John Nommensen Duchac (born February 25, 1953), known professionally as John Doe, is an American singer, songwriter, actor, poet, guitarist and bass player";

  var settingsBox = Hive.box("settings");
  @override
  Widget build(BuildContext context) {
    info = '${info.substring(0, 50)} ...';

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: SafeArea(
          child: Container(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                minRadius: 40,
                maxRadius: 40,
                backgroundColor: Colors.deepOrange,
              ),
              title: Text("John Doe"),
              subtitle: Text(info),
            ),
            Divider(),
            ListTile(
              title: Text("Edit Profile"),
              trailing: IconButton(icon: Icon(Icons.edit), onPressed: () {}),
              onTap: () {
                Nav.push(context, ProfileEditingPage());
              },
            ),
            Divider(),
            ValueListenableBuilder(
              valueListenable: settingsBox.listenable(keys: ["darkMode"]),
              builder: (_, Box box, child) => SwitchListTile(
                  title: Text("Dark Mode"),
                  value: box.get("darkMode") ?? false,
                  onChanged: (val) {
                    box.put("darkMode", val);
                  }),
            ),
            Divider(),
            ValueListenableBuilder(
              valueListenable: settingsBox.listenable(keys: ["pm"]),
              builder: (_, Box box, child) => SwitchListTile(
                  title: Text("Publisher Mode"),
                  value: box.get("pm") ?? false,
                  onChanged: (val) {
                    box.put("pm", val);
                  }),
            ),
          ],
        ),
      )),
    );
  }
}
