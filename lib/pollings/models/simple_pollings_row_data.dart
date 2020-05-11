import 'dart:convert';

class SimplePollingsRowData {
  String optionIndicatorText;
  String title;
  double pollingPercentage;
  SimplePollingsRowData({
    this.optionIndicatorText,
    this.title,
    this.pollingPercentage,
  });

  SimplePollingsRowData copyWith({
    String optionIndicatorText,
    String title,
    double pollingPercentage,
  }) {
    return SimplePollingsRowData(
      optionIndicatorText: optionIndicatorText ?? this.optionIndicatorText,
      title: title ?? this.title,
      pollingPercentage: pollingPercentage ?? this.pollingPercentage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'optionIndicatorText': optionIndicatorText,
      'title': title,
      'pollingPercentage': pollingPercentage,
    };
  }

  static SimplePollingsRowData fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return SimplePollingsRowData(
      optionIndicatorText: map['optionIndicatorText'],
      title: map['title'],
      pollingPercentage: map['pollingPercentage'],
    );
  }

  String toJson() => json.encode(toMap());

  static SimplePollingsRowData fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() =>
      'PollingsData(optionIndicatorText: $optionIndicatorText, title: $title, pollingPercentage: $pollingPercentage)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SimplePollingsRowData &&
        o.optionIndicatorText == optionIndicatorText &&
        o.title == title &&
        o.pollingPercentage == pollingPercentage;
  }

  @override
  int get hashCode =>
      optionIndicatorText.hashCode ^
      title.hashCode ^
      pollingPercentage.hashCode;
}
