import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moor/moor.dart' hide Column;
import 'package:quiki/db/quizer_db.dart';
import 'package:quiki/utils/qutils.dart';

class QuestionEditor extends StatefulWidget {
  final Quiz quiz;
  QuestionEditor({Key key, @required this.quiz}) : super(key: key);

  @override
  _QuestionEditorState createState() => _QuestionEditorState();
}

class _QuestionEditorState extends State<QuestionEditor> {
  Quiz quiz;

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var questionForm = GlobalKey<FormState>();

  var questionField = TextEditingController();
  var op1Field = TextEditingController();
  var op2Field = TextEditingController();
  var op3Field = TextEditingController();
  var op4Field = TextEditingController();

  var quizLengthes = [20, 30, 40];
  var durations = [10, 20];

  var selectedQuizLength;
  var selectedQuizDuration;

  var selectedOption;

  @override
  void initState() {
    super.initState();
    quiz = widget.quiz;
    //loadQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(quiz.title),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.clear), onPressed: clearTextFields),
          IconButton(icon: Icon(Icons.save), onPressed: saveQuestion)
        ],
      ),
      body: SafeArea(
        child: Container(
          //padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Form(
              key: questionForm,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: TextFormField(
                      controller: questionField,
                      minLines: 1,
                      maxLines: 100,
                      decoration: InputDecoration(
                          labelText: "Question",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      validator: (text) {
                        return text.trim() == "" ? "Insert Question !" : null;
                      },
                    ),
                  ),
                  getOptionsView(
                      value: 1,
                      textFieldController: op1Field,
                      textFieldLabel: "Option 1"),
                  getOptionsView(
                      value: 2,
                      textFieldController: op2Field,
                      textFieldLabel: "Option 2"),
                  getOptionsView(
                      value: 3,
                      textFieldController: op3Field,
                      textFieldLabel: "Option 3"),
                  getOptionsView(
                      value: 4,
                      textFieldController: op4Field,
                      textFieldLabel: "Option 4"),
                ],
              ),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: getQuestionsListView(),
      ),
    );
  }

  Widget getOptionsView(
      {int value, var textFieldController, String textFieldLabel}) {
    return RadioListTile<int>(
      value: value,
      groupValue: selectedOption,
      onChanged: (option) {
        setState(() {
          selectedOption = option;
          FocusScope.of(context).unfocus();
        });
      },
      title: Container(
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
      ),
    );
  }

  String getAnswer() {
    switch (selectedOption) {
      case 1:
        return op1Field.text.trim();
      case 2:
        return op2Field.text.trim();
      case 3:
        return op3Field.text.trim();
      case 4:
        return op4Field.text.trim();
      default:
        return null;
    }
  }

  void saveQuestion() async {
    if (questionForm.currentState.validate()) {
      var questions = await QuizerDB.instance.getQuestionsList(quizId: quiz.id);

      if (questions.length == quiz.quizLength) {
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Quiz is already full !"),
        ));
        return;
      }

      if (selectedOption == null) {
        showErrorSnackbar();
        return;
      }

      String question = questionField.text.trim();
      String answer = getAnswer();
      String op1 = op1Field.text.trim();
      String op2 = op2Field.text.trim();
      String op3 = op3Field.text.trim();
      String op4 = op4Field.text.trim();

      var response = await QuizerDB.instance
          .addQuestion(
        QuestionsCompanion(
          quizId: Value(quiz.id),
          question: Value(question),
          answer: Value(answer),
          op1: Value(op1),
          op2: Value(op2),
          op3: Value(op3),
          op4: Value(op4),
        ),
      )
          .catchError((e) {
        print(e);
      });

      setState(() {
        selectedOption = null;
      });
      print(response);
      //loadQuestions();
    }
  }

  Widget getQuestionsListView() {
    return StreamBuilder(
      stream: QuizerDB.instance.getQuestionsStream(quizId: quiz.id),
      initialData: [],
      builder: (_, snapshot) {
        var questions = snapshot.data;
        return (questions.length == 0)
            ? Center(
                child: Text("No question found !"),
              )
            : ListView.builder(
                itemCount: questions.length,
                itemBuilder: (_, index) => ListTile(
                  onLongPress: () {},
                  title: Text(
                    "${index + 1} ) ${questions[index].question}",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 5, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "A ) ${questions[index].op1}",
                          style: TextStyle(
                            color:
                                questions[index].op1 == questions[index].answer
                                    ? Colors.green
                                    : Colors.grey,
                          ),
                        ),
                        Text(
                          "B ) ${questions[index].op2}",
                          style: TextStyle(
                            color:
                                questions[index].op2 == questions[index].answer
                                    ? Colors.green
                                    : Colors.grey,
                          ),
                        ),
                        Text(
                          "C ) ${questions[index].op3}",
                          style: TextStyle(
                            color:
                                questions[index].op3 == questions[index].answer
                                    ? Colors.green
                                    : Colors.grey,
                          ),
                        ),
                        Text(
                          "D ) ${questions[index].op4}",
                          style: TextStyle(
                            color:
                                questions[index].op4 == questions[index].answer
                                    ? Colors.green
                                    : Colors.grey,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red[400],
                                ),
                                onPressed: () {
                                  deleteQuestion(id: questions[index].id);
                                })
                          ],
                        ),
                        Divider()
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }

  void clearTextFields() {
    questionField.clear();
    op1Field.clear();
    op2Field.clear();
    op3Field.clear();
    op4Field.clear();
  }

  void deleteQuestion({int id}) {
    showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
              title: Text("Warning !"),
              content: Text("You are going to delete the question !"),
              actions: <Widget>[
                FlatButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      int response =
                          await QuizerDB.instance.deleteQuestion(id: id);
                      log(response.toString());
                    },
                    child: Text(
                      "Delete",
                      style: TextStyle(color: Colors.red),
                    )),
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel"))
              ],
            ));
  }

  // void loadQuestions() async {
  //   questions.clear();
  //   questions.addAll(await QuizerDB().getQuestions(quizId: quiz.id));
  //   setState(() {});
  // }

  void showErrorSnackbar() {
    scaffoldKey.currentState
        .showSnackBar(QUtils.errorSnackBar(message: "Check the answer"));
  }
}
