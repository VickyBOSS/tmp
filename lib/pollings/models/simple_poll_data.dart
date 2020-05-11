import 'dart:convert';

import 'package:flutter/foundation.dart';

class SimplePollData {
  String pollId;
  int type;
  Map<String, int> pollings;
  String question;
  List<String> options;
  String answer;
  SimplePollData({
    this.pollId,
    this.type,
    this.pollings,
    this.question,
    this.options,
    this.answer,
  });

  SimplePollData copyWith({
    String pollId,
    int type,
    Map<String, int> pollings,
    String question,
    List<String> options,
    String answer,
  }) {
    return SimplePollData(
      pollId: pollId ?? this.pollId,
      type: type ?? this.type,
      pollings: pollings ?? this.pollings,
      question: question ?? this.question,
      options: options ?? this.options,
      answer: answer ?? this.answer,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pollId': pollId,
      'type': type,
      'pollings': pollings,
      'question': question,
      'options': options,
      'answer': answer,
    };
  }

  static SimplePollData fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return SimplePollData(
      pollId: map['pollId'],
      type: map['type'],
      pollings: Map<String, int>.from(map['pollings']),
      question: map['question'],
      options: List<String>.from(map['options']),
      answer: map['answer'],
    );
  }

  String toJson() => json.encode(toMap());

  static SimplePollData fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'SimplePollData(pollId: $pollId, type: $type, pollings: $pollings, question: $question, options: $options, answer: $answer)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SimplePollData &&
        o.pollId == pollId &&
        o.type == type &&
        mapEquals(o.pollings, pollings) &&
        o.question == question &&
        listEquals(o.options, options) &&
        o.answer == answer;
  }

  @override
  int get hashCode {
    return pollId.hashCode ^
        type.hashCode ^
        pollings.hashCode ^
        question.hashCode ^
        options.hashCode ^
        answer.hashCode;
  }
}
