class AccountType {
  AccountType({required this.type});

  late final String type;

  AccountType.fromJson(dynamic json) {
    type = json.toString();
  }

  AccountType.empty() {
    type = "external";
  }

  @override
  String toString() {
    return 'AccountType(type: $type)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AccountType && other.type == type;
  }

  @override
  int get hashCode {
    return type.hashCode;
  }
}
