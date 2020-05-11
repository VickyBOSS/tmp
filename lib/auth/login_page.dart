import 'package:flutter/material.dart';

import 'auth_repos.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var phoneFieldController = TextEditingController();
  var otpFieldController = TextEditingController();

  bool hasOTPSent = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (hasOTPSent) {
          setState(() {
            hasOTPSent = false;
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                hasOTPSent ? _otpField() : _phoneNumField(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _phoneNumField() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Icon(
            Icons.account_circle,
            color: Colors.deepPurple,
            size: 120,
          ),
          SizedBox(
            height: 50,
          ),
          TextField(
            autocorrect: false,
            autofocus: false,
            controller: phoneFieldController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: "Phone",
                prefixText: "+91 "),
          ),
          SizedBox(height: 20),
          isLoading
              ? CircularProgressIndicator()
              : FloatingActionButton(
                  child: Icon(
                    Icons.send,
                  ),
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                    });
                    FocusScope.of(context).unfocus();
                    String phone = "+91${phoneFieldController.text.trim()}";
                    AuthRepos.instance.sendPhoneVerificationCode(phone,
                        onCodeSent: () {
                      print("Code Sent");
                      setState(() {
                        hasOTPSent = true;
                        isLoading = false;
                      });
                    }, onVerificationFailed: (e) {
                      showError(e.message);
                      setState(() {
                        isLoading = false;
                      });
                    });
                  },
                ),
          SizedBox(height: 50)
        ],
      ),
    );
  }

  Widget _otpField() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Icon(
            Icons.lock,
            color: Colors.deepPurple,
            size: 120,
          ),
          SizedBox(
            height: 50,
          ),
          TextField(
            autocorrect: false,
            autofocus: false,
            controller: otpFieldController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              labelText: "OTP",
            ),
          ),
          SizedBox(height: 20),
          isLoading
              ? CircularProgressIndicator()
              : FloatingActionButton(
                  child: Icon(Icons.check),
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                    });
                    FocusScope.of(context).unfocus();

                    String code = otpFieldController.text.trim();
                    AuthRepos.instance.verifyPhoneCode(code,
                        onLoginFailed: (e) {
                      setState(() {
                        isLoading = false;
                      });
                      showError(e.message);
                    });
                  },
                ),
          SizedBox(height: 50)
        ],
      ),
    );
  }

  void showError(String error) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Center(
            child: Icon(
          Icons.error_outline,
        )),
        content: Text(
          error,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
