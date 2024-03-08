import 'package:myecl/admin/class/simple_group.dart';
import 'package:myecl/raffle/class/raffle_status_type.dart';
import 'package:myecl/raffle/tools/functions.dart';

class Raffle {
  Raffle({
    required this.name,
    required this.group,
    required this.raffleStatusType,
    required this.id,
    this.description,
  });
  late final String name;
  late final SimpleGroup group;
  late final RaffleStatusType raffleStatusType;
  late final String id;
  late final String? description;

  Raffle.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String;
    group = SimpleGroup.fromJson(json['group'] as Map<String, dynamic>);
    raffleStatusType = stringToRaffleStatusType(json['status'] as String);
    id = json['id'] as String;
    description = json['description'] as String;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['group_id'] = group.id;
    data['status'] = raffleStatusTypeToString(raffleStatusType);
    data['id'] = id;
    data['description'] = description;
    return data;
  }

  Raffle copyWith({
    String? name,
    SimpleGroup? group,
    RaffleStatusType? raffleStatusType,
    String? id,
    String? description,
  }) =>
      Raffle(
          name: name ?? this.name,
          group: group ?? this.group,
          raffleStatusType: raffleStatusType ?? this.raffleStatusType,
          id: id ?? this.id,
          description: description);

  Raffle.empty() {
    name = '';
    group = SimpleGroup.empty();
    raffleStatusType = RaffleStatusType.creation;
    id = '';
    description = null;
  }

  @override
  String toString() {
    return 'Raffle(name: $name, group: $group, raffleStatusType: $raffleStatusType, id: $id, description: $description)';
  }
}
