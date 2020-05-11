import 'package:flutter/material.dart';
import 'package:quiki/quizer/quiz_info.dart';

typedef void OnQuizStart(QuizInfo quizInfo);
typedef void OnResultsBtnClicked();

class QuizListTile extends StatelessWidget {
  final QuizInfo quizInfo;
  final OnQuizStart onQuizStart;

  const QuizListTile({Key key, this.quizInfo, this.onQuizStart})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            quizInfo.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.flag,
                      color: Colors.amber,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Text(quizInfo.cat)
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.timer,
                      color: Colors.blue,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Text(quizInfo.duration.toString())
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.view_day,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Text(quizInfo.noOfQuestions.toString())
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: OutlineButton(child: Text("Results"), onPressed: null),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: OutlineButton(
                      child: Text("Start"),
                      onPressed: () {
                        onQuizStart(quizInfo);
                      }),
                )
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                width: 5,
              ),
              Text(
                getTimeStampFromId(quizInfo.id),
                style: TextStyle(color: Colors.grey),
              )
            ],
          )
        ],
      ),
    );
  }

  String getTimeStampFromId(String id) {
    int millisecondsSinceEpoch =
        DateTime(2030).millisecondsSinceEpoch - int.parse(id);
    var date = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);

    return "${date.day}-${date.month}-${date.year}  ${date.hour}:${date.minute}";
  }
}
