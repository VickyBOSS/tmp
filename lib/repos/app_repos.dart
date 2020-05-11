import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:meta/meta.dart';

class AppRepos {
  static const APP_INFO_REF = "app_info";

  static final _db = FirebaseDatabase.instance.reference();

  static Future<int> checkForUpdate({@required BuildContext context}) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    log("Build No : $buildNumber \nVersion : $version \nPackage Name : $packageName");

    var snap = await _db.child(APP_INFO_REF).once();
    // TODO : Uncomment latestVersionCode
    // var latestVersionCode = snap.value['vc'];
    var latestVersionCode = 2;
    String whatsNew = snap.value['wn'];
    List<String> list = whatsNew.split('^');
    whatsNew = '';
    list.forEach((i) {
      whatsNew += '$i\n';
    });

    if (latestVersionCode > int.parse(buildNumber)) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text("New Update"),
                content: Text(whatsNew ?? "* Bug fixed !"),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      SystemNavigator.pop();
                    },
                    child: Text(
                      "Exit App",
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      openAppInPlayStore();
                    },
                    child: Text(
                      "Update",
                      style: TextStyle(color: Colors.greenAccent),
                    ),
                  )
                ],
              ));
    }
  }

  static void openAppInPlayStore() {}
}
