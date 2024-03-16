import 'package:myecl/user/class/list_users.dart';

class Applicant extends SimpleUser {
  late final String? email;
  late final int? promo;
  late final String? phone;
  Applicant({
    required super.name,
    required super.firstname,
    required super.nickname,
    required super.id,
    required this.email,
    required this.promo,
    required this.phone,
  });

  Applicant.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    email = json['email'];
    promo = json['promo'];
    phone = json['phone'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['email'] = email;
    data['promo'] = promo;
    data['phone'] = phone;
    data['applicant_id'] = id;
    return data;
  }

  @override
  Applicant copyWith({
    String? name,
    String? firstname,
    String? nickname,
    String? id,
    String? email,
    int? promo,
    String? phone,
  }) {
    return Applicant(
      name: name ?? this.name,
      firstname: firstname ?? this.firstname,
      nickname: nickname ?? this.nickname,
      id: id ?? this.id,
      email: email ?? this.email,
      promo: promo ?? this.promo,
      phone: phone ?? this.phone,
    );
  }

  @override
  Applicant.empty() : super.empty() {
    email = 'empty@ecl.ec-lyon.fr';
    promo = null;
    phone = null;
  }

  @override
  String toString() {
    return 'Applicant{name: $name, firstname: $firstname, nickname: $nickname, id: $id, email: $email, promo: $promo, phone: $phone}';
  }
}
