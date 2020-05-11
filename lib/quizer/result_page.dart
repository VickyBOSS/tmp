import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:quiki/quizer/quiz_review_page.dart';
import 'package:quiki/quizer/review_question.dart';

import 'indicator.dart';

class ResultPage extends StatefulWidget {
  final List<ReviewQuestion> reviewQuestions;
  final int corredtAnswered;
  final int wrongAnswered;
  final int notAttempted;

  const ResultPage(
      {Key key,
      @required this.corredtAnswered,
      @required this.wrongAnswered,
      @required this.notAttempted,
      this.reviewQuestions})
      : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  "Score",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: PieChart(
                  PieChartData(
                      pieTouchData:
                          PieTouchData(touchCallback: (pieTouchResponse) {
                        setState(() {
                          if (pieTouchResponse.touchInput is FlLongPressEnd ||
                              pieTouchResponse.touchInput is FlPanEnd) {
                            touchedIndex = -1;
                          } else {
                            touchedIndex = pieTouchResponse.touchedSectionIndex;
                          }
                        });
                      }),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: showingSections()),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(40, 0, 40, 40),
                child: Column(
                  children: getIndicators(),
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: OutlineButton(
                        child: Text("Back"),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: OutlineButton(
                        child: Text("Review"),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => QuizReviewPage(
                                reviewQuestions: widget.reviewQuestions,
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 2:
          return PieChartSectionData(
            color: Colors.green[400],
            value: widget.corredtAnswered.toDouble(),
            title: (widget.corredtAnswered == 0)
                ? ''
                : widget.corredtAnswered.toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 0:
          return PieChartSectionData(
            color: Colors.red[400],
            value: widget.wrongAnswered.toDouble(),
            title: (widget.wrongAnswered == 0)
                ? ''
                : widget.wrongAnswered.toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.grey[400],
            value: widget.notAttempted.toDouble(),
            title: (widget.notAttempted == 0)
                ? ''
                : widget.notAttempted.toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }

  getIndicators() {
    var indicators = List<Widget>();
    const titles = ["Correct Answered", "Wrong Answered", "Not Attempted"];
    const colors = [Colors.green, Colors.red, Colors.grey];

    List.generate(titles.length, (i) {
      indicators.add(Indicator(
        color: colors[i][400],
        text: titles[i],
        isSquare: true,
      ));
    });

    return indicators;
  }
}
