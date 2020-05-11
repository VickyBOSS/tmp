import 'package:flutter/material.dart';
import 'package:quiki/quizer/review_question.dart';

class QuizReviewPage extends StatelessWidget {
  final List<ReviewQuestion> reviewQuestions;

  const QuizReviewPage({Key key, this.reviewQuestions}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Review"),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(bottom: 0),
          child: Stack(
            children: <Widget>[
              // Positioned(
              //   bottom: 0,
              //   child: Container(
              //     width: MediaQuery.of(context).size.width,
              //     height: 50,
              //     child: RaisedButton(
              //       child: Text("Home"),
              //       onPressed: () {
              //         Navigator.of(context).pop();
              //       },
              //     ),
              //   ),
              // ),
              AnimatedList(
                initialItemCount: reviewQuestions.length,
                itemBuilder: (_, index, anim) => ListTile(
                  title: Text(reviewQuestions[index].question),
                  subtitle: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(reviewQuestions[index].answer)
                        ],
                      ),
                      buildAnswerStatusView(rq: reviewQuestions[index]),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAnswerStatusView({@required ReviewQuestion rq}) {
    if (rq.selectedOption == rq.answer)
      return Row(
        children: <Widget>[
          Icon(
            Icons.check_circle,
            color: Colors.green,
          ),
          SizedBox(
            width: 10,
          ),
          Text(rq.answer)
        ],
      );

    if (rq.selectedOption != null && rq.selectedOption != rq.answer)
      return Row(
        children: <Widget>[
          Icon(
            Icons.cancel,
            color: Colors.red,
          ),
          SizedBox(
            width: 10,
          ),
          Text(rq.selectedOption)
        ],
      );
    return Row(
      children: <Widget>[
        Icon(
          Icons.not_interested,
          color: Colors.grey,
        ),
        SizedBox(
          width: 10,
        ),
        Text("Not Attempted !")
      ],
    );
  }
}
