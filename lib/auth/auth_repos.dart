import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:quiki/auth/user.dart';

enum AuthEvent { AppInit, LoggedIn, LoggedOut }

typedef void LoginSuccess();
typedef void LoginFailed(PlatformException exception);
typedef void OnCodeSent();
typedef void OnVerificationFailed(AuthException e);

class AuthRepos {
  static final _instance = AuthRepos._();
  static AuthRepos get instance => _instance;
  AuthRepos._();

  StreamController<AuthEvent> _userStream = new StreamController();

  void dispose() {
    _userStream.close();
    _authChangeListener.cancel();
  }

  FirebaseUser _user;

  FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseReference _db = FirebaseDatabase.instance.reference();

  StreamSubscription<FirebaseUser> _authChangeListener;

  void addAuthStateListener() {
    if (_authChangeListener == null) {
      _authChangeListener = _auth.onAuthStateChanged.listen((user) {
        _user = user;
        if (_user != null) {
          _userStream.add(AuthEvent.LoggedIn);

          _db.child("users").child(_user.uid).once().then((snapshot) {
            _userStream.add(AuthEvent.LoggedIn);

            if (snapshot.value == null) {
              _db
                  .child("users")
                  .child(_user.uid)
                  .set({"phone": _user.phoneNumber, "uid": _user.uid});
            }
          });
        } else {
          _userStream.add(AuthEvent.LoggedOut);
        }
      });
    }
  }

  Future<User> doesUserExists() async {
    User user;

    if (_user != null) {
      DataSnapshot snapshot = await _db.child("users").child(_user.uid).once();
      if (snapshot.value != null) {
        user = User(
            name: snapshot.value['n'],
            image: snapshot.value['i'],
            thumb: snapshot.value['t'],
            uid: snapshot.key,
            phone: _user.phoneNumber);
      }
    }

    return user;
  }

  // void showProfileEditingDialog(context){
  //   showDialog();
  // }

  var _verificationId;

  Stream<AuthEvent> getUserAuthStatus() {
    return _userStream.stream;
  }

  void signOut() {
    _auth.signOut();
    _userStream.add(AuthEvent.LoggedOut);
  }

  void sendPhoneVerificationCode(String phone,
      {OnCodeSent onCodeSent,
      OnVerificationFailed onVerificationFailed}) async {
    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (credential) {
          print("verification Completed");
        },
        verificationFailed: (exception) {
          print(exception.message);
          onVerificationFailed(exception);
        },
        codeSent: (verificationId, [forceResendToken]) {
          _verificationId = verificationId;
          onCodeSent();
        },
        codeAutoRetrievalTimeout: (verificationId) {
          _verificationId = verificationId;
          print("codeAutoRetrivalTimeout");
        });
  }

  void verifyPhoneCode(String code, {LoginFailed onLoginFailed}) {
    AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: _verificationId, smsCode: code);

    _auth.signInWithCredential(credential).catchError((error) {
      onLoginFailed(error);
    });
  }

  Future<void> saveUserName(String name) async {
    return await _db.child('users').child(_user.uid).update({"name": name});
  }

  String getCurrentUserId() {
    if (_user != null) {
      return _user.uid;
    } else {
      return null;
    }

    // if (snapshot.value != null) {
    //   var name = snapshot.value["name"];
    //   var phone = snapshot.value["phone"];
    //   var image = snapshot.value["image"];
    //   var thumb = snapshot.value["thumb"];
    //   var uid = snapshot.value["uid"];

    //   return User(
    //       name: name, phone: phone, image: image, thumb: thumb, uid: uid);
    // } else {
    //   return null;
    // }
  }

  saveUserImage(File file) async {
    StorageReference ref = FirebaseStorage.instance.ref().child("users_img");

    StorageMetadata metadata = StorageMetadata();
    StorageTaskSnapshot storageTaskSnapshot =
        await ref.child("${_user.uid}.jpg").putFile(file).onComplete;
    final String url = await storageTaskSnapshot.ref.getDownloadURL();

    //final String thumb = await ref.child("${_user.uid}_200x200.jpg").getDownloadURL();

    _db.child("users").child(_user.uid).update({"image": url});
  }
}
