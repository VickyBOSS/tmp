import 'dart:convert';

class Question {
  String question;
  String answer;
  String op1;
  String op2;
  String op3;
  String op4;
  Question({
    this.question,
    this.answer,
    this.op1,
    this.op2,
    this.op3,
    this.op4,
  });

  Question copyWith({
    String question,
    String answer,
    String op1,
    String op2,
    String op3,
    String op4,
  }) {
    return Question(
      question: question ?? this.question,
      answer: answer ?? this.answer,
      op1: op1 ?? this.op1,
      op2: op2 ?? this.op2,
      op3: op3 ?? this.op3,
      op4: op4 ?? this.op4,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'answer': answer,
      'op1': op1,
      'op2': op2,
      'op3': op3,
      'op4': op4,
    };
  }

  static Question fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Question(
      question: map['question'],
      answer: map['answer'],
      op1: map['op1'],
      op2: map['op2'],
      op3: map['op3'],
      op4: map['op4'],
    );
  }

  static Question fromDocumentSnapshot(Map<String, dynamic> map) {
    if (map == null) return null;

    return Question(
      question: map['q'],
      answer: map['a'],
      op1: map['o1'],
      op2: map['o2'],
      op3: map['o3'],
      op4: map['o4'],
    );
  }

  String toJson() => json.encode(toMap());

  static Question fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Question(question: $question, answer: $answer, op1: $op1, op2: $op2, op3: $op3, op4: $op4)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Question &&
        o.question == question &&
        o.answer == answer &&
        o.op1 == op1 &&
        o.op2 == op2 &&
        o.op3 == op3 &&
        o.op4 == op4;
  }

  @override
  int get hashCode {
    return question.hashCode ^
        answer.hashCode ^
        op1.hashCode ^
        op2.hashCode ^
        op3.hashCode ^
        op4.hashCode;
  }
}
