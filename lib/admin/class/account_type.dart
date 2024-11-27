class AccountType {
  AccountType({
    required this.type,
  });

  late final String type;

  AccountType.fromJson(dynamic json) {
    type = json.toString();
  }

  AccountType.empty() {
    type = "";
  }

  @override
  String toString() {
    return 'AccountType(type: $type)';
  }
}
