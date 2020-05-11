import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:quiki/quizer/question.dart';
import 'package:quiki/quizer/quiz_info.dart';
import 'package:quiki/quizer/result_page.dart';
import 'package:quiki/quizer/review_question.dart';
import 'package:quiki/repos/firebase_repos.dart';

class Quizer extends StatefulWidget {
  static const String TPYE_MCQs = "MCQs";
  static const String TPYE_CROSS_MATCHINGS = "Matchings";

  final QuizInfo quizInfo;

  Quizer(this.quizInfo);

  @override
  _QuizerState createState() => _QuizerState();
}

class _QuizerState extends State<Quizer> {
  var queryQuestions;
  var currentQuestionIndex = 0;
  var checkedOptionsMap = {};

  var questions = List<Question>();

  @override
  void initState() {
    super.initState();
    queryQuestions = Firestore.instance
        .collection(FirebaseRepos.PUBLISHED_QUESTIONS_COLLECTION)
        .document(widget.quizInfo.id)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                  "Q. ${currentQuestionIndex + 1}/${widget.quizInfo.noOfQuestions}"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(Icons.timer),
                  SizedBox(width: 10),
                  Container(
                    width: 60,
                    child: Countdown(
                        duration: Duration(minutes: widget.quizInfo.duration),
                        builder: (_, duration) =>
                            Text("${duration.inMinutes}:${duration.inSeconds}"),
                        onFinish: () {
                          print("Quiz finished");
                          checkQuestions();
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: FutureBuilder<DocumentSnapshot>(
            future: queryQuestions,
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                log(snapshot.data.toString());

                if (questions.isEmpty) {
                  snapshot.data.data['data'].forEach((q) {
                    questions.add(Question.fromDocumentSnapshot(q));
                  });
                }

                initAds();

                return PageView(
                  controller: PageController(
                    initialPage: currentQuestionIndex,
                  ),
                  children: getQuestionsViews(),
                  onPageChanged: (newIndex) {
                    setState(() {
                      currentQuestionIndex = newIndex;
                    });
                  },
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              return Center(
                child: Text("Error ! Something went wrong"),
              );
            },
          ),
        ),
      ),
    );
  }

  getOptionsView(Question question) {
    var optionsViews = List<Widget>();
    for (var i = 1; i < 5; i++) {
      var option = question.toMap()['op$i'];
      optionsViews.add(
        RadioListTile(
            title: Text(option),
            value: option,
            groupValue: checkedOptionsMap[question.question],
            onChanged: (newValue) {
              setState(() {
                checkedOptionsMap[question.question] = newValue;
              });
              print(checkedOptionsMap);
            }),
      );
    }
    return Container(
      child: Column(
        children: optionsViews,
      ),
    );
  }

  List<Widget> getQuestionsViews() {
    List<Widget> questionsWidgets = [];
    questions.forEach((question) {
      questionsWidgets.add(Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              child: Text(
                "Q.  ${question.question} ?",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            getOptionsView(question),
            SizedBox(
              height: 20,
            ),
            OutlineButton(
              child: Text(
                "Clear",
                style: TextStyle(color: Colors.red),
              ),
              borderSide: BorderSide(color: Colors.red),
              onPressed: () {
                setState(() {
                  checkedOptionsMap[question.question] = null;
                  print(checkedOptionsMap);
                });
              },
            ),
            SizedBox(
              height: 10,
            ),
            OutlineButton(
              child: Text(
                "Submit",
                style: TextStyle(color: Colors.green, fontSize: 16),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: Text("Caution !"),
                          content: Text(
                              "If you clicked the button by mistake, you can still go back.\n\nDo you really want to submit ?"),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "cancel",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            OutlineButton(
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                    color: Colors.green, fontSize: 16),
                              ),
                              borderSide: BorderSide(color: Colors.green),
                              onPressed: () {
                                checkQuestions();
                              },
                            )
                          ],
                        ));
              },
              borderSide: BorderSide(color: Colors.green),
            ),
          ],
        ),
      ));
    });
    return questionsWidgets;
  }

  dynamic checkQuestions() {
    RewardedVideoAd.instance.show();
    var reviewQuestions = List<ReviewQuestion>();

    var correctAnswered = 0, wrongAnswered = 0, notAttempted = 0;

    questions.forEach((question) {
      reviewQuestions.add(ReviewQuestion(
          question: question.question,
          answer: question.answer,
          selectedOption: checkedOptionsMap[question.question]));
      if (checkedOptionsMap[question.question] == null) {
        notAttempted++;
      } else if (checkedOptionsMap[question.question] == question.answer) {
        correctAnswered++;
      } else if (checkedOptionsMap[question.question] != question.answer) {
        wrongAnswered++;
      }
    });
    var finalScore = correctAnswered - wrongAnswered / 4;
    print("Final Score : $finalScore");
    Navigator.of(context).pop();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ResultPage(
            reviewQuestions: reviewQuestions,
            corredtAnswered: correctAnswered,
            wrongAnswered: wrongAnswered,
            notAttempted: notAttempted),
      ),
    );
  }

  void initAds() {
    MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      keywords: <String>['games', 'beautiful apps', 'fashion', 'earn money'],
      contentUrl: 'https://flutter.io',
      childDirected: false,
      testDevices: <String>[
        "EBDF0B1D32796D6735A43A40B6475CEE"
      ], // Android emulators are considered test devices
    );

    RewardedVideoAd.instance.load(
        adUnitId: "ca-app-pub-7125762060242443/8590663354",
        targetingInfo: targetingInfo);

    RewardedVideoAd.instance.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      if (event == RewardedVideoAdEvent.rewarded) {
        setState(() {
          // Here, apps should update state to reflect the reward.
          // _goldCoins += rewardAmount;
        });
      } else if (event == RewardedVideoAdEvent.failedToLoad) {
        RewardedVideoAd.instance.load(
            adUnitId: "ca-app-pub-7125762060242443/8590663354",
            targetingInfo: targetingInfo);
      }
    };
  }
}
