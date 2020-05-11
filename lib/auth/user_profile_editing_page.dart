import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:quiki/auth/auth_repos.dart';
import 'package:quiki/auth/user_provider.dart';

class UserProfileEditingPage extends StatefulWidget {
  @override
  _UserProfileEditingPageState createState() => _UserProfileEditingPageState();
}

class _UserProfileEditingPageState extends State<UserProfileEditingPage> {
  UserProvider provider;

  String name, imageUrl;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    provider = Provider.of<UserProvider>(context);

    if (provider != null) {
      if (provider.user != null) {
        name = provider.user.name;
        imageUrl = provider.user.image;

        if (name != null) {
          nameFieldController.text = name;
        }
      }
    }
  }

  var nameFieldController = TextEditingController();
  String errorText = "";
  var imgFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              (imgFile != null)
                  ? GestureDetector(
                      child: CircleAvatar(
                        radius: 100,
                        backgroundImage: FileImage(imgFile),
                      ),
                      onTap: () async {
                        imgFile = await ImagePicker.pickImage(
                            source: ImageSource.gallery);

                        setState(() {});
                      },
                    )
                  : (imageUrl != null)
                      ? GestureDetector(
                          child: CircleAvatar(
                            radius: 100,
                            backgroundImage: NetworkImage(imageUrl),
                          ),
                          onTap: () async {
                            imgFile = await ImagePicker.pickImage(
                                source: ImageSource.gallery);

                            setState(() {});
                          },
                        )
                      : OutlineButton(
                          child: Text("Choose Image"),
                          onPressed: () async {
                            imgFile = await ImagePicker.pickImage(
                                source: ImageSource.gallery);

                            setState(() {});
                          },
                        ),
              SizedBox(
                height: 30,
              ),
              TextField(
                autocorrect: false,
                autofocus: false,
                controller: nameFieldController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.green)),
                    labelText: "Name",
                    errorText: errorText),
                onChanged: (newText) {
                  if (newText.isEmpty) {
                    setState(() {
                      errorText = "Name can not be empty !";
                    });
                  } else {
                    setState(() {
                      errorText = "";
                    });
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                child: Text("Save"),
                onPressed: saveProfile,
              )
            ],
          ),
        ),
      ),
    );
  }

  void saveProfile() {
    if (imgFile != null) {
      AuthRepos.instance.saveUserImage(imgFile);
    }

    String name = nameFieldController.text.trim();

    if (name.isEmpty) {
      setState(() {
        errorText = "Name can not be empty !";
      });
    }

    AuthRepos.instance.saveUserName(name).catchError((e) {
      showError(e.message);
    });
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
            ));
  }
}
