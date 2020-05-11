import 'package:firestore_ui/animated_firestore_list.dart';
import 'package:flutter/material.dart';
import 'package:quiki/pages/quiz_creating_page.dart';
import 'package:quiki/quizer/quiz_info.dart';
import 'package:quiki/quizer/quizer.dart';
import 'package:quiki/repos/firebase_repos.dart';
import 'package:quiki/utils/nav.dart';
import 'package:quiki/widgets/published_quizes_list_tile.dart';

class PublishedQuizesTab extends StatefulWidget {
  @override
  _PublishedQuizesTabState createState() => _PublishedQuizesTabState();
}

class _PublishedQuizesTabState extends State<PublishedQuizesTab>
    with AutomaticKeepAliveClientMixin {
  var query = FirebaseRepos.getPublishedQuizes;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      child: Stack(
        children: <Widget>[
          FirestoreAnimatedList(
              query: query,
              defaultChild: Center(child: CircularProgressIndicator()),
              emptyChild: Center(
                child: Text("No Quiz Found !"),
              ),
              itemBuilder: (_, snap, anim, index) {
                return Card(
                    child: PublishedQuizListTile(
                  quizInfo: QuizInfo.fromFirestoreMap(snap.data),
                  onQuizStart: () {
                    Nav.push(
                        context, Quizer(QuizInfo.fromFirestoreMap(snap.data)));
                  },
                ));
              }),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
                heroTag: null,
                child: Icon(Icons.add),
                onPressed: () {
                  Nav.push(context, QuizCreatingPage());
                }),
          ),
        ],
      ),
    );
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  bool get wantKeepAlive => true;
}
