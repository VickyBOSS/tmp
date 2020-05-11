import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiki/db/quizer_db.dart';
import 'package:quiki/repos/firebase_repos.dart';
import 'package:quiki/widgets/local_quizes_list_tiles.dart';

class LocalQuizesTab extends StatefulWidget {
  @override
  _LocalQuizesTabState createState() => _LocalQuizesTabState();
}

class _LocalQuizesTabState extends State<LocalQuizesTab>
    with AutomaticKeepAliveClientMixin<LocalQuizesTab> {
  var isLoading = false;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: StreamBuilder<List<Quiz>>(
        initialData: [],
        stream: QuizerDB.instance.getQuizes(),
        builder: (_, snapshot) {
          print("Quiz Updated !");
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return LocalQuizListTile(
                quiz: snapshot.data[index],
                onDeleteButtonPressed: () {
                  _deleteQuiz(quiz: snapshot.data[index]);
                },
                onUploadButtonPressed: () {
                  _uploadQuiz(quiz: snapshot.data[index]);
                },
              );
            },
          );
        },
      ),
    );
  }

  void _deleteQuiz({Quiz quiz}) {
    showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
              title: Text("Warning !"),
              content: Text("Are you sure you want to delete ${quiz.title}"),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      QuizerDB.instance.deleteQuiz(quizId: quiz.id);
                      Navigator.pop(context);
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

  void _uploadQuiz({@required Quiz quiz}) async {
    var questions = await QuizerDB.instance.getQuestionsList(quizId: quiz.id);

    if (questions.length != quiz.quizLength) return;

    setState(() {
      isLoading = true;
    });

    var id = (DateTime(2030).millisecondsSinceEpoch -
            DateTime.now().millisecondsSinceEpoch)
        .toString();

    List<Map<String, dynamic>> questionsList = [];

    for (var question in questions) {
      questionsList.add({
        'q': question.question,
        'a': question.answer,
        'o1': question.op1,
        'o2': question.op2,
        'o3': question.op3,
        'o4': question.op4,
      });
    }

    Map<String, dynamic> quizMap = {
      "t": quiz.title,
      "i": id,
      "c": quiz.quizCategoryCode,
      "tp": quiz.quizTypeCode,
      "d": quiz.quizDuration,
      "l": quiz.quizLength,
      "q": questionsList,
      "pb": 0
    };

    FirebaseRepos.publishQuizFromSdcard(
        quizData: quizMap,
        onError: (e) {
          setState(() {
            setState(() {
              isLoading = false;
            });
          });
        },
        onSuccess: () {
          Fluttertoast.showToast(
            msg: "${quiz.title} published successfully !",
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
