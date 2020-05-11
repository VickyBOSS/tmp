import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quiki/auth/user_provider.dart';
import 'package:quiki/pages/home_page.dart';
import 'package:quiki/pages/splash_page.dart';
import 'auth/auth_repos.dart';
import 'auth/login_page.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseAdMob.instance
      .initialize(appId: "ca-app-pub-7125762060242443~2612412513");
  var dir = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  await Hive.openBox("settings");
  await Hive.openBox("polls");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var box = Hive.box("settings");
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        )
      ],
      child: ValueListenableBuilder(
        valueListenable: box.listenable(keys: ["darkMode"]),
        builder: (_, Box box, child) => MaterialApp(
          theme: ThemeData(
            brightness: box.get("darkMode") ?? false
                ? Brightness.dark
                : Brightness.light,
            primarySwatch: Colors.deepPurple,
          ),
          home: StreamBuilder(
              stream: AuthRepos.instance.getUserAuthStatus(),
              initialData: AuthEvent.AppInit,
              builder: (
                _,
                snapshot,
              ) {
                _checkUserStatus();
                if (snapshot.data == AuthEvent.LoggedIn) {
                  return HomePage();
                } else if (snapshot.data == AuthEvent.LoggedOut) {
                  return LoginPage();
                } else {
                  return SplashPage();
                }
              }),
        ),
      ),
    );
  }

  _checkUserStatus() async {
    await Future.delayed(Duration(seconds: 1));
    AuthRepos.instance.addAuthStateListener();
  }
}
