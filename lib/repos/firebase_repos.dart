import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

typedef void OnError(String e);
typedef void OnSuccess();

class FirebaseRepos {
  static const PUBLISHED_QUIZES_COLLECTION = "quizesP";
  static const DRAFT_QUIZES_COLLECTION = "quizesD";
  static const PUBLISHED_QUESTIONS_COLLECTION = "questionsP";

  static Stream<QuerySnapshot> get getDraftQuizes => Firestore.instance
      .collection(DRAFT_QUIZES_COLLECTION)
      .where("pb", isEqualTo: 0)
      .snapshots();

  static Stream<QuerySnapshot> get getPublishedQuizes => Firestore.instance
      .collection(PUBLISHED_QUIZES_COLLECTION)
      .limit(50)
      .snapshots();

  static String get timeStampAsString =>
      (DateTime(2030).millisecondsSinceEpoch -
              DateTime.now().millisecondsSinceEpoch)
          .toString();

  static void saveQuizDraft(
      {@required Map<String, dynamic> quizMap,
      OnError onError,
      OnSuccess onSuccess}) {
    Firestore.instance
        .collection(DRAFT_QUIZES_COLLECTION)
        .document(quizMap['i'])
        .setData(quizMap)
        .then((onValue) {
      onSuccess();
    }).catchError((e) {
      onError(e.toString());
    });
  }

  static void publishQuizFromSdcard(
      {@required Map<String, dynamic> quizData,
      OnError onError,
      OnSuccess onSuccess}) async {
    String timeStamp = timeStampAsString;
    quizData.update("i", (v) => timeStamp);

    var questions = quizData.remove('q');

    Firestore.instance
        .collection(PUBLISHED_QUESTIONS_COLLECTION)
        .document(timeStamp)
        .setData({"data": questions}).then((onValue) {
      Firestore.instance
          .collection(PUBLISHED_QUIZES_COLLECTION)
          .document(timeStamp)
          .setData(quizData)
          .then((onValue) {
        onSuccess();
      }).catchError((e) {
        onError(e);
      });
    }).catchError((e) {
      onError(e);
    });
  }

  static void publishQuizFromDraft(
      {@required Map<String, dynamic> quizData, OnError onError}) async {
    String draftId = quizData['i'];

    String timeStamp = timeStampAsString;
    quizData.update("i", (v) => timeStamp);

    var questions = quizData.remove('q');

    Firestore.instance
        .collection(PUBLISHED_QUESTIONS_COLLECTION)
        .document(timeStamp)
        .setData({"data": questions}).then((onValue) {
      Firestore.instance
          .collection(PUBLISHED_QUIZES_COLLECTION)
          .document(timeStamp)
          .setData(quizData)
          .then((onValue) {
        Firestore.instance
            .collection(DRAFT_QUIZES_COLLECTION)
            .document(draftId)
            .updateData({"pb": 1});
      }).catchError((e) {
        onError(e);
      });
    }).catchError((e) {
      onError(e);
    });
  }
}
