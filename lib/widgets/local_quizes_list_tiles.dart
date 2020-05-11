import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiki/db/quizer_db.dart';
import 'package:quiki/pages/question_editor.dart';
import 'package:quiki/utils/app_consts.dart';
import 'package:quiki/utils/nav.dart';

typedef void OnDeleteButtonPressed();
typedef void OnUploadButtonPressed();

class LocalQuizListTile extends StatelessWidget {
  final Quiz quiz;
  final OnDeleteButtonPressed onDeleteButtonPressed;
  final OnUploadButtonPressed onUploadButtonPressed;

  LocalQuizListTile(
      {Key key,
      @required this.quiz,
      this.onDeleteButtonPressed,
      this.onUploadButtonPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Nav.push(context, QuestionEditor(quiz: quiz));
      },
      child: Card(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                quiz.title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    AppConsts.categories[quiz.quizCategoryCode],
                    style: TextStyle(color: Colors.grey),
                  ),
                  StreamBuilder(
                    stream:
                        QuizerDB.instance.getQuestionsStream(quizId: quiz.id),
                    initialData: [],
                    builder: (_, snapshot) => Text(
                      "Q. ${snapshot.data.length}/${quiz.quizLength}",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: OutlineButton.icon(
                      onPressed: onDeleteButtonPressed,
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red[400],
                      ),
                      label: Text(
                        "Delete",
                        style: TextStyle(color: Colors.red[400]),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream:
                          QuizerDB.instance.getQuestionsStream(quizId: quiz.id),
                      initialData: [],
                      builder: (_, snapshot) => OutlineButton.icon(
                        onPressed: snapshot.data.length == quiz.quizLength
                            ? onUploadButtonPressed
                            : null,
                        icon: Icon(
                          Icons.cloud_upload,
                          color: snapshot.data.length == quiz.quizLength
                              ? Colors.green
                              : Colors.grey,
                        ),
                        label: Text("Upload"),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
