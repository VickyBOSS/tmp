// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quizer_db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Quiz extends DataClass implements Insertable<Quiz> {
  final String id;
  final String title;
  final int quizCategoryCode;
  final int quizTypeCode;
  final int quizLength;
  final int quizDuration;
  Quiz(
      {@required this.id,
      @required this.title,
      @required this.quizCategoryCode,
      @required this.quizTypeCode,
      @required this.quizLength,
      @required this.quizDuration});
  factory Quiz.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    return Quiz(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      quizCategoryCode: intType.mapFromDatabaseResponse(
          data['${effectivePrefix}quiz_category_code']),
      quizTypeCode: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}quiz_type_code']),
      quizLength: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}quiz_length']),
      quizDuration: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}quiz_duration']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || quizCategoryCode != null) {
      map['quiz_category_code'] = Variable<int>(quizCategoryCode);
    }
    if (!nullToAbsent || quizTypeCode != null) {
      map['quiz_type_code'] = Variable<int>(quizTypeCode);
    }
    if (!nullToAbsent || quizLength != null) {
      map['quiz_length'] = Variable<int>(quizLength);
    }
    if (!nullToAbsent || quizDuration != null) {
      map['quiz_duration'] = Variable<int>(quizDuration);
    }
    return map;
  }

  factory Quiz.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Quiz(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      quizCategoryCode: serializer.fromJson<int>(json['quizCategoryCode']),
      quizTypeCode: serializer.fromJson<int>(json['quizTypeCode']),
      quizLength: serializer.fromJson<int>(json['quizLength']),
      quizDuration: serializer.fromJson<int>(json['quizDuration']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'quizCategoryCode': serializer.toJson<int>(quizCategoryCode),
      'quizTypeCode': serializer.toJson<int>(quizTypeCode),
      'quizLength': serializer.toJson<int>(quizLength),
      'quizDuration': serializer.toJson<int>(quizDuration),
    };
  }

  Quiz copyWith(
          {String id,
          String title,
          int quizCategoryCode,
          int quizTypeCode,
          int quizLength,
          int quizDuration}) =>
      Quiz(
        id: id ?? this.id,
        title: title ?? this.title,
        quizCategoryCode: quizCategoryCode ?? this.quizCategoryCode,
        quizTypeCode: quizTypeCode ?? this.quizTypeCode,
        quizLength: quizLength ?? this.quizLength,
        quizDuration: quizDuration ?? this.quizDuration,
      );
  @override
  String toString() {
    return (StringBuffer('Quiz(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('quizCategoryCode: $quizCategoryCode, ')
          ..write('quizTypeCode: $quizTypeCode, ')
          ..write('quizLength: $quizLength, ')
          ..write('quizDuration: $quizDuration')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          title.hashCode,
          $mrjc(
              quizCategoryCode.hashCode,
              $mrjc(quizTypeCode.hashCode,
                  $mrjc(quizLength.hashCode, quizDuration.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Quiz &&
          other.id == this.id &&
          other.title == this.title &&
          other.quizCategoryCode == this.quizCategoryCode &&
          other.quizTypeCode == this.quizTypeCode &&
          other.quizLength == this.quizLength &&
          other.quizDuration == this.quizDuration);
}

class QuizesCompanion extends UpdateCompanion<Quiz> {
  final Value<String> id;
  final Value<String> title;
  final Value<int> quizCategoryCode;
  final Value<int> quizTypeCode;
  final Value<int> quizLength;
  final Value<int> quizDuration;
  const QuizesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.quizCategoryCode = const Value.absent(),
    this.quizTypeCode = const Value.absent(),
    this.quizLength = const Value.absent(),
    this.quizDuration = const Value.absent(),
  });
  QuizesCompanion.insert({
    @required String id,
    @required String title,
    @required int quizCategoryCode,
    @required int quizTypeCode,
    @required int quizLength,
    @required int quizDuration,
  })  : id = Value(id),
        title = Value(title),
        quizCategoryCode = Value(quizCategoryCode),
        quizTypeCode = Value(quizTypeCode),
        quizLength = Value(quizLength),
        quizDuration = Value(quizDuration);
  static Insertable<Quiz> custom({
    Expression<String> id,
    Expression<String> title,
    Expression<int> quizCategoryCode,
    Expression<int> quizTypeCode,
    Expression<int> quizLength,
    Expression<int> quizDuration,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (quizCategoryCode != null) 'quiz_category_code': quizCategoryCode,
      if (quizTypeCode != null) 'quiz_type_code': quizTypeCode,
      if (quizLength != null) 'quiz_length': quizLength,
      if (quizDuration != null) 'quiz_duration': quizDuration,
    });
  }

  QuizesCompanion copyWith(
      {Value<String> id,
      Value<String> title,
      Value<int> quizCategoryCode,
      Value<int> quizTypeCode,
      Value<int> quizLength,
      Value<int> quizDuration}) {
    return QuizesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      quizCategoryCode: quizCategoryCode ?? this.quizCategoryCode,
      quizTypeCode: quizTypeCode ?? this.quizTypeCode,
      quizLength: quizLength ?? this.quizLength,
      quizDuration: quizDuration ?? this.quizDuration,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (quizCategoryCode.present) {
      map['quiz_category_code'] = Variable<int>(quizCategoryCode.value);
    }
    if (quizTypeCode.present) {
      map['quiz_type_code'] = Variable<int>(quizTypeCode.value);
    }
    if (quizLength.present) {
      map['quiz_length'] = Variable<int>(quizLength.value);
    }
    if (quizDuration.present) {
      map['quiz_duration'] = Variable<int>(quizDuration.value);
    }
    return map;
  }
}

class $QuizesTable extends Quizes with TableInfo<$QuizesTable, Quiz> {
  final GeneratedDatabase _db;
  final String _alias;
  $QuizesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _quizCategoryCodeMeta =
      const VerificationMeta('quizCategoryCode');
  GeneratedIntColumn _quizCategoryCode;
  @override
  GeneratedIntColumn get quizCategoryCode =>
      _quizCategoryCode ??= _constructQuizCategoryCode();
  GeneratedIntColumn _constructQuizCategoryCode() {
    return GeneratedIntColumn(
      'quiz_category_code',
      $tableName,
      false,
    );
  }

  final VerificationMeta _quizTypeCodeMeta =
      const VerificationMeta('quizTypeCode');
  GeneratedIntColumn _quizTypeCode;
  @override
  GeneratedIntColumn get quizTypeCode =>
      _quizTypeCode ??= _constructQuizTypeCode();
  GeneratedIntColumn _constructQuizTypeCode() {
    return GeneratedIntColumn(
      'quiz_type_code',
      $tableName,
      false,
    );
  }

  final VerificationMeta _quizLengthMeta = const VerificationMeta('quizLength');
  GeneratedIntColumn _quizLength;
  @override
  GeneratedIntColumn get quizLength => _quizLength ??= _constructQuizLength();
  GeneratedIntColumn _constructQuizLength() {
    return GeneratedIntColumn(
      'quiz_length',
      $tableName,
      false,
    );
  }

  final VerificationMeta _quizDurationMeta =
      const VerificationMeta('quizDuration');
  GeneratedIntColumn _quizDuration;
  @override
  GeneratedIntColumn get quizDuration =>
      _quizDuration ??= _constructQuizDuration();
  GeneratedIntColumn _constructQuizDuration() {
    return GeneratedIntColumn(
      'quiz_duration',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, title, quizCategoryCode, quizTypeCode, quizLength, quizDuration];
  @override
  $QuizesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'quizes';
  @override
  final String actualTableName = 'quizes';
  @override
  VerificationContext validateIntegrity(Insertable<Quiz> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title'], _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('quiz_category_code')) {
      context.handle(
          _quizCategoryCodeMeta,
          quizCategoryCode.isAcceptableOrUnknown(
              data['quiz_category_code'], _quizCategoryCodeMeta));
    } else if (isInserting) {
      context.missing(_quizCategoryCodeMeta);
    }
    if (data.containsKey('quiz_type_code')) {
      context.handle(
          _quizTypeCodeMeta,
          quizTypeCode.isAcceptableOrUnknown(
              data['quiz_type_code'], _quizTypeCodeMeta));
    } else if (isInserting) {
      context.missing(_quizTypeCodeMeta);
    }
    if (data.containsKey('quiz_length')) {
      context.handle(
          _quizLengthMeta,
          quizLength.isAcceptableOrUnknown(
              data['quiz_length'], _quizLengthMeta));
    } else if (isInserting) {
      context.missing(_quizLengthMeta);
    }
    if (data.containsKey('quiz_duration')) {
      context.handle(
          _quizDurationMeta,
          quizDuration.isAcceptableOrUnknown(
              data['quiz_duration'], _quizDurationMeta));
    } else if (isInserting) {
      context.missing(_quizDurationMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  Quiz map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Quiz.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $QuizesTable createAlias(String alias) {
    return $QuizesTable(_db, alias);
  }
}

class Question extends DataClass implements Insertable<Question> {
  final int id;
  final String quizId;
  final String question;
  final String answer;
  final String op1;
  final String op2;
  final String op3;
  final String op4;
  Question(
      {@required this.id,
      @required this.quizId,
      @required this.question,
      @required this.answer,
      @required this.op1,
      @required this.op2,
      @required this.op3,
      @required this.op4});
  factory Question.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Question(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      quizId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}quiz_id']),
      question: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}question']),
      answer:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}answer']),
      op1: stringType.mapFromDatabaseResponse(data['${effectivePrefix}op1']),
      op2: stringType.mapFromDatabaseResponse(data['${effectivePrefix}op2']),
      op3: stringType.mapFromDatabaseResponse(data['${effectivePrefix}op3']),
      op4: stringType.mapFromDatabaseResponse(data['${effectivePrefix}op4']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || quizId != null) {
      map['quiz_id'] = Variable<String>(quizId);
    }
    if (!nullToAbsent || question != null) {
      map['question'] = Variable<String>(question);
    }
    if (!nullToAbsent || answer != null) {
      map['answer'] = Variable<String>(answer);
    }
    if (!nullToAbsent || op1 != null) {
      map['op1'] = Variable<String>(op1);
    }
    if (!nullToAbsent || op2 != null) {
      map['op2'] = Variable<String>(op2);
    }
    if (!nullToAbsent || op3 != null) {
      map['op3'] = Variable<String>(op3);
    }
    if (!nullToAbsent || op4 != null) {
      map['op4'] = Variable<String>(op4);
    }
    return map;
  }

  factory Question.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Question(
      id: serializer.fromJson<int>(json['id']),
      quizId: serializer.fromJson<String>(json['quizId']),
      question: serializer.fromJson<String>(json['question']),
      answer: serializer.fromJson<String>(json['answer']),
      op1: serializer.fromJson<String>(json['op1']),
      op2: serializer.fromJson<String>(json['op2']),
      op3: serializer.fromJson<String>(json['op3']),
      op4: serializer.fromJson<String>(json['op4']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'quizId': serializer.toJson<String>(quizId),
      'question': serializer.toJson<String>(question),
      'answer': serializer.toJson<String>(answer),
      'op1': serializer.toJson<String>(op1),
      'op2': serializer.toJson<String>(op2),
      'op3': serializer.toJson<String>(op3),
      'op4': serializer.toJson<String>(op4),
    };
  }

  Question copyWith(
          {int id,
          String quizId,
          String question,
          String answer,
          String op1,
          String op2,
          String op3,
          String op4}) =>
      Question(
        id: id ?? this.id,
        quizId: quizId ?? this.quizId,
        question: question ?? this.question,
        answer: answer ?? this.answer,
        op1: op1 ?? this.op1,
        op2: op2 ?? this.op2,
        op3: op3 ?? this.op3,
        op4: op4 ?? this.op4,
      );
  @override
  String toString() {
    return (StringBuffer('Question(')
          ..write('id: $id, ')
          ..write('quizId: $quizId, ')
          ..write('question: $question, ')
          ..write('answer: $answer, ')
          ..write('op1: $op1, ')
          ..write('op2: $op2, ')
          ..write('op3: $op3, ')
          ..write('op4: $op4')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          quizId.hashCode,
          $mrjc(
              question.hashCode,
              $mrjc(
                  answer.hashCode,
                  $mrjc(
                      op1.hashCode,
                      $mrjc(op2.hashCode,
                          $mrjc(op3.hashCode, op4.hashCode))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Question &&
          other.id == this.id &&
          other.quizId == this.quizId &&
          other.question == this.question &&
          other.answer == this.answer &&
          other.op1 == this.op1 &&
          other.op2 == this.op2 &&
          other.op3 == this.op3 &&
          other.op4 == this.op4);
}

class QuestionsCompanion extends UpdateCompanion<Question> {
  final Value<int> id;
  final Value<String> quizId;
  final Value<String> question;
  final Value<String> answer;
  final Value<String> op1;
  final Value<String> op2;
  final Value<String> op3;
  final Value<String> op4;
  const QuestionsCompanion({
    this.id = const Value.absent(),
    this.quizId = const Value.absent(),
    this.question = const Value.absent(),
    this.answer = const Value.absent(),
    this.op1 = const Value.absent(),
    this.op2 = const Value.absent(),
    this.op3 = const Value.absent(),
    this.op4 = const Value.absent(),
  });
  QuestionsCompanion.insert({
    this.id = const Value.absent(),
    @required String quizId,
    @required String question,
    @required String answer,
    @required String op1,
    @required String op2,
    @required String op3,
    @required String op4,
  })  : quizId = Value(quizId),
        question = Value(question),
        answer = Value(answer),
        op1 = Value(op1),
        op2 = Value(op2),
        op3 = Value(op3),
        op4 = Value(op4);
  static Insertable<Question> custom({
    Expression<int> id,
    Expression<String> quizId,
    Expression<String> question,
    Expression<String> answer,
    Expression<String> op1,
    Expression<String> op2,
    Expression<String> op3,
    Expression<String> op4,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (quizId != null) 'quiz_id': quizId,
      if (question != null) 'question': question,
      if (answer != null) 'answer': answer,
      if (op1 != null) 'op1': op1,
      if (op2 != null) 'op2': op2,
      if (op3 != null) 'op3': op3,
      if (op4 != null) 'op4': op4,
    });
  }

  QuestionsCompanion copyWith(
      {Value<int> id,
      Value<String> quizId,
      Value<String> question,
      Value<String> answer,
      Value<String> op1,
      Value<String> op2,
      Value<String> op3,
      Value<String> op4}) {
    return QuestionsCompanion(
      id: id ?? this.id,
      quizId: quizId ?? this.quizId,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      op1: op1 ?? this.op1,
      op2: op2 ?? this.op2,
      op3: op3 ?? this.op3,
      op4: op4 ?? this.op4,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (quizId.present) {
      map['quiz_id'] = Variable<String>(quizId.value);
    }
    if (question.present) {
      map['question'] = Variable<String>(question.value);
    }
    if (answer.present) {
      map['answer'] = Variable<String>(answer.value);
    }
    if (op1.present) {
      map['op1'] = Variable<String>(op1.value);
    }
    if (op2.present) {
      map['op2'] = Variable<String>(op2.value);
    }
    if (op3.present) {
      map['op3'] = Variable<String>(op3.value);
    }
    if (op4.present) {
      map['op4'] = Variable<String>(op4.value);
    }
    return map;
  }
}

class $QuestionsTable extends Questions
    with TableInfo<$QuestionsTable, Question> {
  final GeneratedDatabase _db;
  final String _alias;
  $QuestionsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _quizIdMeta = const VerificationMeta('quizId');
  GeneratedTextColumn _quizId;
  @override
  GeneratedTextColumn get quizId => _quizId ??= _constructQuizId();
  GeneratedTextColumn _constructQuizId() {
    return GeneratedTextColumn(
      'quiz_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _questionMeta = const VerificationMeta('question');
  GeneratedTextColumn _question;
  @override
  GeneratedTextColumn get question => _question ??= _constructQuestion();
  GeneratedTextColumn _constructQuestion() {
    return GeneratedTextColumn(
      'question',
      $tableName,
      false,
    );
  }

  final VerificationMeta _answerMeta = const VerificationMeta('answer');
  GeneratedTextColumn _answer;
  @override
  GeneratedTextColumn get answer => _answer ??= _constructAnswer();
  GeneratedTextColumn _constructAnswer() {
    return GeneratedTextColumn(
      'answer',
      $tableName,
      false,
    );
  }

  final VerificationMeta _op1Meta = const VerificationMeta('op1');
  GeneratedTextColumn _op1;
  @override
  GeneratedTextColumn get op1 => _op1 ??= _constructOp1();
  GeneratedTextColumn _constructOp1() {
    return GeneratedTextColumn(
      'op1',
      $tableName,
      false,
    );
  }

  final VerificationMeta _op2Meta = const VerificationMeta('op2');
  GeneratedTextColumn _op2;
  @override
  GeneratedTextColumn get op2 => _op2 ??= _constructOp2();
  GeneratedTextColumn _constructOp2() {
    return GeneratedTextColumn(
      'op2',
      $tableName,
      false,
    );
  }

  final VerificationMeta _op3Meta = const VerificationMeta('op3');
  GeneratedTextColumn _op3;
  @override
  GeneratedTextColumn get op3 => _op3 ??= _constructOp3();
  GeneratedTextColumn _constructOp3() {
    return GeneratedTextColumn(
      'op3',
      $tableName,
      false,
    );
  }

  final VerificationMeta _op4Meta = const VerificationMeta('op4');
  GeneratedTextColumn _op4;
  @override
  GeneratedTextColumn get op4 => _op4 ??= _constructOp4();
  GeneratedTextColumn _constructOp4() {
    return GeneratedTextColumn(
      'op4',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, quizId, question, answer, op1, op2, op3, op4];
  @override
  $QuestionsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'questions';
  @override
  final String actualTableName = 'questions';
  @override
  VerificationContext validateIntegrity(Insertable<Question> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('quiz_id')) {
      context.handle(_quizIdMeta,
          quizId.isAcceptableOrUnknown(data['quiz_id'], _quizIdMeta));
    } else if (isInserting) {
      context.missing(_quizIdMeta);
    }
    if (data.containsKey('question')) {
      context.handle(_questionMeta,
          question.isAcceptableOrUnknown(data['question'], _questionMeta));
    } else if (isInserting) {
      context.missing(_questionMeta);
    }
    if (data.containsKey('answer')) {
      context.handle(_answerMeta,
          answer.isAcceptableOrUnknown(data['answer'], _answerMeta));
    } else if (isInserting) {
      context.missing(_answerMeta);
    }
    if (data.containsKey('op1')) {
      context.handle(
          _op1Meta, op1.isAcceptableOrUnknown(data['op1'], _op1Meta));
    } else if (isInserting) {
      context.missing(_op1Meta);
    }
    if (data.containsKey('op2')) {
      context.handle(
          _op2Meta, op2.isAcceptableOrUnknown(data['op2'], _op2Meta));
    } else if (isInserting) {
      context.missing(_op2Meta);
    }
    if (data.containsKey('op3')) {
      context.handle(
          _op3Meta, op3.isAcceptableOrUnknown(data['op3'], _op3Meta));
    } else if (isInserting) {
      context.missing(_op3Meta);
    }
    if (data.containsKey('op4')) {
      context.handle(
          _op4Meta, op4.isAcceptableOrUnknown(data['op4'], _op4Meta));
    } else if (isInserting) {
      context.missing(_op4Meta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Question map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Question.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $QuestionsTable createAlias(String alias) {
    return $QuestionsTable(_db, alias);
  }
}

abstract class _$QuizerDB extends GeneratedDatabase {
  _$QuizerDB(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $QuizesTable _quizes;
  $QuizesTable get quizes => _quizes ??= $QuizesTable(this);
  $QuestionsTable _questions;
  $QuestionsTable get questions => _questions ??= $QuestionsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [quizes, questions];
}
