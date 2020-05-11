import 'dart:convert';

import 'package:quiki/utils/app_consts.dart';

class QuizInfo {
  String id;
  String title;
  String type;
  String cat;
  int noOfQuestions;
  int duration;
  QuizInfo({
    this.id,
    this.title,
    this.type,
    this.cat,
    this.noOfQuestions,
    this.duration,
  });

  QuizInfo copyWith({
    String id,
    String title,
    String type,
    String cat,
    int noOfQuestions,
    int duration,
  }) {
    return QuizInfo(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      cat: cat ?? this.cat,
      noOfQuestions: noOfQuestions ?? this.noOfQuestions,
      duration: duration ?? this.duration,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'cat': cat,
      'noOfQuestions': noOfQuestions,
      'duration': duration,
    };
  }

  static QuizInfo fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return QuizInfo(
      id: map['id'],
      title: map['title'],
      type: map['type'],
      cat: map['cat'],
      noOfQuestions: map['noOfQuestions'],
      duration: map['duration'],
    );
  }

  static QuizInfo fromFirestoreMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return QuizInfo(
      id: map['i'],
      title: map['t'],
      type: "MCQs",
      cat: AppConsts.categories[map['c']],
      noOfQuestions: map['l'],
      duration: map['d'],
    );
  }

  String toJson() => json.encode(toMap());

  static QuizInfo fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'QuizInfo(id: $id, title: $title, type: $type, cat: $cat, noOfQuestions: $noOfQuestions, duration: $duration)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is QuizInfo &&
        o.id == id &&
        o.title == title &&
        o.type == type &&
        o.cat == cat &&
        o.noOfQuestions == noOfQuestions &&
        o.duration == duration;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        type.hashCode ^
        cat.hashCode ^
        noOfQuestions.hashCode ^
        duration.hashCode;
  }
}
