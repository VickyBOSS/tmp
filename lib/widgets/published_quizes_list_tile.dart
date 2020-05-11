import 'package:flutter/material.dart';
import 'package:quiki/quizer/quiz_info.dart';

typedef void OnResultsBtnClicked();
typedef void OnQuizStart();

class PublishedQuizListTile extends StatelessWidget {
  final QuizInfo quizInfo;
  final OnResultsBtnClicked onResultsBtnClicked;
  final OnQuizStart onQuizStart;

  const PublishedQuizListTile(
      {Key key, this.quizInfo, this.onResultsBtnClicked, this.onQuizStart})
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.flag,
                    color: Colors.amber,
                    size: 10,
                  ),
                  SizedBox(width: 10),
                  Text(quizInfo.cat, style: TextStyle(fontSize: 10))
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.timer,
                    color: Colors.blue,
                    size: 10,
                  ),
                  SizedBox(width: 10),
                  Text(
                    quizInfo.duration.toString(),
                    style: TextStyle(fontSize: 10),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.view_day,
                    size: 10,
                  ),
                  SizedBox(width: 10),
                  Text(
                    quizInfo.noOfQuestions.toString(),
                    style: TextStyle(fontSize: 10),
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            width: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: OutlineButton(
                      child: Text("Results"), onPressed: onResultsBtnClicked)),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  flex: 1,
                  child: OutlineButton(
                      child: Text("Take Quiz"), onPressed: onQuizStart)),
            ],
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text(
              getTimeStampFromId(quizInfo.id),
              style: TextStyle(color: Colors.grey, fontSize: 10),
            ),
          ),
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
