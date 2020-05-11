import 'package:flutter/material.dart';
import 'package:moor/moor.dart' hide Column;
import 'package:quiki/db/quizer_db.dart';

class QuizCreatingPage extends StatefulWidget {
  QuizCreatingPage({Key key}) : super(key: key);

  @override
  _QuizCreatingPageState createState() => _QuizCreatingPageState();
}

class _QuizCreatingPageState extends State<QuizCreatingPage> {
  var quizForm = GlobalKey<FormState>();

  var categories = [
    "Raj GK",
    "Raj History",
    "Raj Geography",
    "Raj Culture",
    "Constitution",
    "Hindi",
    "India GK",
    "Indian History",
    "Indian Geography",
    "Indian Culture",
    "World GK"
  ];

  var lengthes = [3, 10, 20, 30, 40, 50];
  var durations = [1, 5, 10, 15, 20, 25, 30];

  var quizCat;
  var quizLength;
  var quizDuration;

  var quizTitleField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Quiz"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save), onPressed: createQuiz)
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Form(
              key: quizForm,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: quizTitleField,
                    autofocus: false,
                    decoration: inputDecoration(label: "Title"),
                    validator: (text) {
                      if (text.trim() == "" || text.length < 5) {
                        return "Invalid Quiz Title !";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DropdownButtonFormField<String>(
                    value: quizCat,
                    items: categories
                        .map(
                          (cat) => DropdownMenuItem<String>(
                              child: Text(cat), value: cat),
                        )
                        .toList(),
                    onChanged: (val) {
                      FocusScope.of(context).unfocus();
                      setState(() {
                        quizCat = val;
                      });
                    },
                    decoration: inputDecoration(label: "Category"),
                    validator: (val) {
                      if (val == null) {
                        return "Select Quiz Category !";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          value: quizLength,
                          items: lengthes
                              .map(
                                (length) => DropdownMenuItem<int>(
                                    child: Text(length.toString()),
                                    value: length),
                              )
                              .toList(),
                          onChanged: (val) {
                            FocusScope.of(context).unfocus();

                            setState(() {
                              quizLength = val;
                            });
                          },
                          decoration: inputDecoration(label: "Quiz Length"),
                          validator: (val) {
                            if (val == null) {
                              return "Select Quiz Category !";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          value: quizDuration,
                          items: durations
                              .map(
                                (duration) => DropdownMenuItem<int>(
                                    child: Text(duration.toString()),
                                    value: duration),
                              )
                              .toList(),
                          onChanged: (val) {
                            FocusScope.of(context).unfocus();

                            setState(() {
                              quizDuration = val;
                            });
                          },
                          decoration: inputDecoration(label: "Quiz Duration"),
                          validator: (val) {
                            if (val == null) {
                              return "Select Quiz Duration !";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  inputDecoration({@required String label}) => InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      );

  void createQuiz() {
    FocusScope.of(context).unfocus();

    String quizId = DateTime.now().millisecondsSinceEpoch.toString();

    if (quizForm.currentState.validate()) {
      QuizerDB.instance
          .addQuiz(QuizesCompanion(
        id: Value(quizId),
        title: Value(quizTitleField.text.trim()),
        quizCategoryCode: Value(categories.indexOf(quizCat)),
        quizTypeCode: Value(1),
        quizLength: Value(quizLength),
        quizDuration: Value(quizDuration),
      ))
          .then((v) {
        print(v);
        Navigator.of(context).pop();
      }).catchError((e) {
        print(e);
      });
    }
  }
}
