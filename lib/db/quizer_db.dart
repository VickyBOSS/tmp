import 'dart:async';
import 'dart:io';
import 'package:meta/meta.dart';
import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

part 'quizer_db.g.dart';

@DataClassName("Quiz")
class Quizes extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  IntColumn get quizCategoryCode => integer()();
  IntColumn get quizTypeCode => integer()();
  IntColumn get quizLength => integer()();
  IntColumn get quizDuration => integer()();
}

@DataClassName("Question")
class Questions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get quizId => text()();
  TextColumn get question => text()();
  TextColumn get answer => text()();
  TextColumn get op1 => text()();
  TextColumn get op2 => text()();
  TextColumn get op3 => text()();
  TextColumn get op4 => text()();
}

LazyDatabase _openDB() {
  return LazyDatabase(() async {
    var dir = await pathProvider.getApplicationDocumentsDirectory();
    var file = File("${dir.path}/quizerdb.sqlite");
    return VmDatabase(file);
  });
}

@UseMoor(tables: [Quizes, Questions])
class QuizerDB extends _$QuizerDB {
  static final _instance = QuizerDB._();

  static QuizerDB get instance => _instance;

  QuizerDB._() : super(_openDB());

  @override
  int get schemaVersion => 1;

  Future<int> addQuiz(QuizesCompanion companion) async {
    return await into(quizes).insert(companion);
  }

  Stream<List<Quiz>> getQuizes() {
    return (select(quizes)
          ..orderBy(
              [(t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc)]))
        .watch();
  }

  Future<int> addQuestion(QuestionsCompanion companion) async {
    return await into(questions).insert(companion);
  }

  Stream<List<Question>> getQuestionsStream({String quizId}) {
    return (select(questions)
          ..where((question) => question.quizId.equals(quizId)))
        .watch();
  }

  Future<List<Question>> getQuestionsList({@required String quizId}) {
    return (select(questions)
          ..where((question) => question.quizId.equals(quizId)))
        .get();
  }

  void deleteQuiz({@required String quizId}) {
    (delete(quizes)..where((quiz) => quiz.id.equals(quizId))).go();
    (delete(questions)..where((question) => question.quizId.equals(quizId)))
        .go();
  }

  Future<int> deleteQuestion({@required int id}) {
    return (delete(questions)..where((q) => q.id.equals(id))).go();
  }
}
