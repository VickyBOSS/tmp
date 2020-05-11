import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:quiki/utils/my_image_picker.dart';

class ProfileEditingPage extends StatefulWidget {
  @override
  _ProfileEditingPageState createState() => _ProfileEditingPageState();
}

class _ProfileEditingPageState extends State<ProfileEditingPage> {
  var profileForm = GlobalKey<FormState>();
  var nameField = TextEditingController();

  var autoValidate = false;

  File imageFile;
  File thumb;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(80),
                //   child: Image.network(
                //     "https://nwsid.net/wp-content/uploads/2015/05/dummy-profile-pic.png",
                //     height: 150,
                //     width: 150,
                //   ),
                // ),
                SizedBox(
                  height: 30,
                ),
                Card(
                  margin: const EdgeInsets.all(10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          child: CircleAvatar(
                              radius: 120,
                              backgroundImage: imageFile == null
                                  ? NetworkImage(
                                      "https://nwsid.net/wp-content/uploads/2015/05/dummy-profile-pic.png")
                                  : FileImage(imageFile)),
                          onTap: () async {
                            log("Picking Image");
                            imageFile = await MyImagePicker.pickImage();
                            thumb = await MyImagePicker.thumbnail(imageFile);
                            setState(() {});
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        OutlineButton(
                            child: Text("Save Image"), onPressed: () {})
                      ],
                    ),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Form(
                      key: profileForm,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: nameField,
                            decoration: InputDecoration(
                                labelText: "Name",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            validator: (val) {
                              if (val.trim().length < 3)
                                return "Name is too short !";
                              return null;
                            },
                            autovalidate: autoValidate,
                            autocorrect: false,
                            autofocus: false,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          OutlineButton(
                              child: Text("Save"), onPressed: saveInfo)
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void saveInfo() {
    setState(() {
      autoValidate = true;
    });
    if (profileForm.currentState.validate()) {}
  }
}
