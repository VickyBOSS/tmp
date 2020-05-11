import 'package:firebase_database/firebase_database.dart';

class PollsRepos {
  static const POLLINGS_DB = "polls";
  static const POLLINGS_COUNTER_DB = 'polls_counter';

  static final _instance = PollsRepos._();
  PollsRepos._();
  static PollsRepos get instance => _instance;

  static final _db = FirebaseDatabase.instance.reference();

  Future<void> publishSimplePoll(Map<String, dynamic> poll) {
    return _db.child(POLLINGS_DB).child(customTimeStamp).set(poll);
  }

  static String get customTimeStamp => (DateTime(2030).millisecondsSinceEpoch -
          DateTime.now().millisecondsSinceEpoch)
      .toString();

  upvoteSimplePoll(pollId, optionIndex) async {
    _db
        .child('$POLLINGS_DB/$pollId/v/o$optionIndex')
        .runTransaction((MutableData transaction) async {
      transaction.value = (transaction.value ?? 0) + 1;
      return transaction;
    });
  }

  Future<DataSnapshot> countPolls({String pollId}) {
    print("Count : $pollId");
    return _db.child('$POLLINGS_COUNTER_DB/$pollId').once();
  }

  // Stream<Event> getUserPollStream({String pollId, String userid}) {
  //   print("Count : $pollId");
  //   return _db.child('$POLLINGS_COUNTER_DB/$pollId/$userid').onValue;
  // }

  Query get pollsQuery => _db.child(POLLINGS_DB).limitToFirst(50);
}
