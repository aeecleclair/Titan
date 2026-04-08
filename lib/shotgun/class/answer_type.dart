enum AnswerType {
  text,
  number,
  boolean,
}

extension AnswerTypeExtension on AnswerType {
  String get value {
    switch (this) {
      case AnswerType.text:
        return 'TEXT';
      case AnswerType.number:
        return 'NUMBER';
      case AnswerType.boolean:
        return 'BOOLEAN';
    }
  }

  static AnswerType fromString(String value) {
    switch (value) {
      case 'TEXT':
        return AnswerType.text;
      case 'NUMBER':
        return AnswerType.number;
      case 'BOOLEAN':
        return AnswerType.boolean;
      default:
        throw ArgumentError('Unknown AnswerType: $value');
    }
  }
}
