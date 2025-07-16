import 'package:titan/super_admin/class/account_type.dart';
import 'package:titan/user/class/simple_users.dart';

class Member extends SimpleUser {
  Member({
    required super.name,
    required super.firstname,
    required super.nickname,
    required super.id,
    required super.accountType,
    required this.email,
    required this.phone,
    required this.promotion,
  });
  late final String email;
  late final String? phone;
  late final int promotion;

  Member.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    email = json['email'];
    phone = json['phone'];
    promotion = json['promo'] ?? 0;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['email'] = email;
    data['phone'] = phone;
    data['promotion'] = promotion;
    return data;
  }

  @override
  Member copyWith({
    String? name,
    String? firstname,
    String? nickname,
    String? id,
    AccountType? accountType,
    String? email,
    String? phone,
    int? promotion,
  }) {
    return Member(
      name: name ?? this.name,
      firstname: firstname ?? this.firstname,
      nickname: nickname,
      id: id ?? this.id,
      accountType: accountType ?? this.accountType,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      promotion: promotion ?? this.promotion,
    );
  }

  Member.empty() : super.empty() {
    email = "email.test@empty.useless";
    phone = "00 00 00 00 00";
    promotion = 0;
  }

  Member.fromUser(SimpleUser user)
    : super(
        name: user.name,
        firstname: user.firstname,
        nickname: user.nickname,
        id: user.id,
        accountType: user.accountType,
      ) {
    email = "";
    phone = "";
    promotion = 0;
  }

  @override
  String toString() {
    return 'Member(name: $name, firstname: $firstname, nickname: $nickname, id: $id, email: $email, phone: $phone, promotion: $promotion)';
  }
}
