import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:quiki/auth/user.dart';
import 'auth_repos.dart';

class UserProvider extends ChangeNotifier {
  User _user;

  User get user => _user;

  UserProvider() {
    var uid = AuthRepos.instance.getCurrentUserId();
    if (uid != null) {
      FirebaseDatabase.instance
          .reference()
          .child("users")
          .child(uid)
          .onValue
          .listen((event) {
        if (event.snapshot.value != null) {
          _user = User(
              uid: event.snapshot.value['uid'],
              name: event.snapshot.value['n'],
              phone: event.snapshot.value['p'],
              image: event.snapshot.value['i'],
              thumb: event.snapshot.value['t']);
        }
        notifyListeners();
      });
    }
  }
}
