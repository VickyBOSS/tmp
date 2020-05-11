import 'dart:convert';

class ReviewQuestion {
  String question;
  String answer;
  String selectedOption;
  ReviewQuestion({
    this.question,
    this.answer,
    this.selectedOption,
  });

  ReviewQuestion copyWith({
    String question,
    String answer,
    String selectedOption,
  }) {
    return ReviewQuestion(
      question: question ?? this.question,
      answer: answer ?? this.answer,
      selectedOption: selectedOption ?? this.selectedOption,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'answer': answer,
      'selectedOption': selectedOption,
    };
  }

  static ReviewQuestion fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ReviewQuestion(
      question: map['question'],
      answer: map['answer'],
      selectedOption: map['selectedOption'],
    );
  }

  String toJson() => json.encode(toMap());

  static ReviewQuestion fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() =>
      'ReviewQuestion(question: $question, answer: $answer, selectedOption: $selectedOption)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ReviewQuestion &&
        o.question == question &&
        o.answer == answer &&
        o.selectedOption == selectedOption;
  }

  @override
  int get hashCode =>
      question.hashCode ^ answer.hashCode ^ selectedOption.hashCode;
}
