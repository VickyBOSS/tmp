import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiki/pollings/models/simple_poll_data.dart';
import 'package:quiki/pollings/polls_repos.dart';
import 'package:quiki/pollings/simple_pollings_view.dart';
import 'package:quiki/utils/nav.dart';

import 'dart:developer' as logger;

import 'create_simple_poll.dart';

class PollingsPage extends StatefulWidget {
  @override
  _PollingsPageState createState() => _PollingsPageState();
}

class _PollingsPageState extends State<PollingsPage>
    with AutomaticKeepAliveClientMixin<PollingsPage> {
  var query = PollsRepos.instance.pollsQuery;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: Stack(
        children: <Widget>[
          FirebaseAnimatedList(
              defaultChild: Center(child: CircularProgressIndicator()),
              query: query,
              itemBuilder: (_, snap, anim, index) {
                logger.log(snap.key);

                return Padding(
                  padding: EdgeInsets.all(10),
                  child: SimplePollingsView(
                    pollData: SimplePollData(
                        pollId: snap.key,
                        type: snap.value['tp'],
                        question: snap.value['q'],
                        answer: snap.value['a'],
                        options: List<String>.from(snap.value['o']),
                        pollings: Map<String, int>.from(snap.value['v'] ?? {})),
                  ),
                );
              }),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
                heroTag: null,
                child: Icon(Icons.add),
                onPressed: openPollsDialog),
          )
        ],
      ),
    );
  }

  void openPollsDialog() {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => CupertinoActionSheet(
              title: Text("Select"),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Nav.push(context, CreateSimplePoll());
                    },
                    child: Text("Poll")),
                FlatButton(
                    onPressed: null, //() {
                    //   Navigator.pop(context);
                    //   Nav.push(context, CreateSimpleQuestionPoll());
                    // },
                    child: Text("Question")),
                FlatButton(
                    onPressed: null, //() {
                    //   Navigator.pop(context);
                    //   Nav.push(context, CreateSimpleQuestionPoll());
                    // },
                    child: Text("Multiple Choices Question")),
                FlatButton(
                    onPressed: null, //() {
                    //   Navigator.pop(context);
                    //   Nav.push(context, CreateSimpleQuestionPoll());
                    // },
                    child: Text("Cross Matchings")),
              ],
              cancelButton: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
            ));
  }

  @override
  bool get wantKeepAlive => true;
}
