import 'package:flutter/material.dart';
import 'package:quiki/pollings/polls_repos.dart';
import 'package:quiki/utils/qutils.dart';

class CreateSimplePoll extends StatefulWidget {
  @override
  _CreateSimplePollState createState() => _CreateSimplePollState();
}

class _CreateSimplePollState extends State<CreateSimplePoll> {
  static const MIN_OPTIONS = 2;
  static const MAX_OPTIONS = 10;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var questionFieldController = TextEditingController();
  List<TextEditingController> controllers = [];

  var optionsLength = 2;

  var isLoading = false;

  @override
  void initState() {
    super.initState();
    controllers.add(TextEditingController());
    controllers.add(TextEditingController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Create Question"),
        actions: <Widget>[
          isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : FlatButton(
                  onPressed: publishQuestion,
                  child: Icon(Icons.save),
                )
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 5),
                  TextFormField(
                    controller: questionFieldController,
                    decoration: inputDecoration(label: "Question"),
                    validator: (text) {
                      if (text.trim() == "") return "Insert Question !";
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Column(
                    children: buildOptionsView(),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FloatingActionButton(
                          heroTag: "dsfgsdfsd",
                          child: Icon(
                            Icons.remove,
                          ),
                          backgroundColor: Colors.red,
                          onPressed: removeOption),
                      SizedBox(
                        width: 20,
                      ),
                      FloatingActionButton(
                        heroTag: "asdhuaisd",
                        child: Icon(Icons.add),
                        onPressed: addOption,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildOptionsView() {
    List<Widget> options = [];

    for (var i = 0; i < optionsLength; i++) {
      options.add(getOptionView(
          textFieldLabel: "Option ${i + 1}",
          textFieldController: controllers[i]));
    }

    return options;
  }

  Widget getOptionView({var textFieldController, String textFieldLabel}) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: TextFormField(
        controller: textFieldController,
        decoration: InputDecoration(
            labelText: textFieldLabel,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )),
        validator: (text) {
          return text.trim() == "" ? "Insert $textFieldLabel !" : null;
        },
      ),
    );
  }

  inputDecoration({String label}) {
    return InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)));
  }

  void publishQuestion() {
    if (formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();
      setState(() {
        isLoading = true;
      });
      List<String> options = [];
      for (var i = 0; i < controllers.length; i++) {
        options.add(controllers[i].text.trim());
      }

      Map<String, dynamic> questionData = {
        "tp": 1,
        "q": questionFieldController.text.trim(),
        "o": options
      };

      print(questionData);

      PollsRepos.instance.publishSimplePoll(questionData).then((onValue) {
        setState(() {
          isLoading = false;
        });
        Navigator.pop(context);
      });
    }
  }

  void showErrorSnackbar() {
    scaffoldKey.currentState
        .showSnackBar(QUtils.errorSnackBar(message: "Check the answer"));
  }

  void addOption() {
    if (optionsLength < 10) {
      setState(() {
        controllers.add(TextEditingController());
        optionsLength++;
      });
    } else {
      snack("Sorry ! You cannot create more options");
    }
  }

  void removeOption() {
    if (optionsLength >= 3) {
      setState(() {
        controllers.removeLast();
        optionsLength--;
      });
    } else {
      snack("Minimum two options are required !");
    }
  }

  void snack(String message) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}
