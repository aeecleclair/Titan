enum AnswerType {
  text,
  number,
  boolean,
}

extension AnswerTypeExtension on AnswerType {
  String get value {
    switch (this) {
      case AnswerType.text:
        return 'text';
      case AnswerType.number:
        return 'number';
      case AnswerType.boolean:
        return 'boolean';
    }
  }

  static AnswerType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'text':
        return AnswerType.text;
      case 'number':
        return AnswerType.number;
      case 'boolean':
        return AnswerType.boolean;
      default:
        throw ArgumentError('Unknown AnswerType: $value');
    }
  }
}
