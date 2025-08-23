import 'package:titan/admin/class/association_membership_simple.dart';
import 'package:titan/user/class/simple_users.dart';

class Structure {
  final String id;
  final String name;
  final AssociationMembership associationMembership;
  final SimpleUser managerUser;
  final String shortId;
  final String siegeAddressStreet;
  final String siegeAddressCity;
  final String siegeAddressZipcode;
  final String siegeAddressCountry;
  final String? siret;
  final String iban;
  final String bic;

  Structure({
    required this.id,
    required this.name,
    required this.associationMembership,
    required this.managerUser,
    required this.shortId,
    required this.siegeAddressStreet,
    required this.siegeAddressCity,
    required this.siegeAddressZipcode,
    required this.siegeAddressCountry,
    this.siret,
    required this.iban,
    required this.bic,
  });

  factory Structure.fromJson(Map<String, dynamic> json) {
    return Structure(
      id: json['id'],
      shortId: json['short_id'],
      name: json['name'],
      siegeAddressStreet: json['siege_address_street'],
      siegeAddressCity: json['siege_address_city'],
      siegeAddressZipcode: json['siege_address_zipcode'],
      siegeAddressCountry: json['siege_address_country'],
      siret: json['siret'],
      iban: json['iban'],
      bic: json['bic'],
      associationMembership: json['association_membership'] != null
          ? AssociationMembership.fromJson(json['association_membership'])
          : AssociationMembership.empty(),
      managerUser: SimpleUser.fromJson(json['manager_user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'short_id': shortId,
      'manager_user_id': managerUser.id,
      'siege_address_street': siegeAddressStreet,
      'siege_address_city': siegeAddressCity,
      'siege_address_zipcode': siegeAddressZipcode,
      'siege_address_country': siegeAddressCountry,
      'siret': siret,
      'iban': iban,
      'bic': bic,
      'association_membership_id': associationMembership.id != ''
          ? associationMembership.id
          : null,
    };
  }

  @override
  String toString() {
    return 'Structure{id: $id\n'
        'name: $name\n'
        'shortId: $shortId\n'
        'siegeAddressStreet: $siegeAddressStreet\n'
        'siegeAddressCity: $siegeAddressCity\n'
        'siegeAddressZipcode: $siegeAddressZipcode\n'
        'siegeAddressCountry: $siegeAddressCountry\n'
        'siret: $siret\n'
        'iban: $iban\n'
        'bic: $bic\n'
        'associationMembership: $associationMembership\n'
        'managerUser: $managerUser}';
  }

  Structure copyWith({
    String? id,
    String? shortId,
    String? name,
    AssociationMembership? associationMembership,
    SimpleUser? managerUser,
    String? siegeAddressStreet,
    String? siegeAddressCity,
    String? siegeAddressZipcode,
    String? siegeAddressCountry,
    String? siret,
    String? iban,
    String? bic,
  }) {
    return Structure(
      id: id ?? this.id,
      shortId: shortId ?? this.shortId,
      name: name ?? this.name,
      siegeAddressStreet: siegeAddressStreet ?? this.siegeAddressStreet,
      siegeAddressCity: siegeAddressCity ?? this.siegeAddressCity,
      siegeAddressZipcode: siegeAddressZipcode ?? this.siegeAddressZipcode,
      siegeAddressCountry: siegeAddressCountry ?? this.siegeAddressCountry,
      siret: siret ?? this.siret,
      iban: iban ?? this.iban,
      bic: bic ?? this.bic,
      associationMembership:
          associationMembership ?? this.associationMembership,
      managerUser: managerUser ?? this.managerUser,
    );
  }

  Structure.empty()
    : this(
        id: '',
        shortId: '',
        name: '',
        siegeAddressStreet: '',
        siegeAddressCity: '',
        siegeAddressZipcode: '',
        siegeAddressCountry: '',
        siret: null,
        iban: '',
        bic: '',
        associationMembership: AssociationMembership.empty(),
        managerUser: SimpleUser.empty(),
      );
}
