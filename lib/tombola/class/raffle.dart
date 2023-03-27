import 'package:myecl/tombola/class/raffle_status_type.dart';
import 'package:myecl/tombola/tools/functions.dart';

class Raffle {
  Raffle({
    required this.name,
    required this.groupId,
    required this.raffleStatusType,
    required this.id,
    this.description,
  });
  late final String name;
  late final String groupId;
  late final RaffleStatusType raffleStatusType;
  late final String id;
  late final String? description;

  Raffle.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    groupId = json['group_id'];
    raffleStatusType = stringToRaffleStatusType(json['raffles_status_type']);
    id = json['id'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['group_id'] = groupId;
    data['raffles_status_type'] = raffleStatusTypeToString(raffleStatusType);
    data['id'] = id;
    data['description'] = description;
    return data;
  }

  Raffle copyWith({
    String? name,
    String? groupId,
    RaffleStatusType? raffleStatusType,
    String? id,
    String? description,
  }) =>
      Raffle(
          name: name ?? this.name,
          groupId: groupId ?? this.groupId,
          raffleStatusType: raffleStatusType ?? this.raffleStatusType,
          id: id ?? this.id,
          description: description);

  Raffle.empty() {
    name = '';
    groupId = '';
    raffleStatusType = RaffleStatusType.creation;
    id = '';
    description = '';
  }

  @override
  String toString() {
    return 'Raffle(name: $name, groupId: $groupId, raffleStatusType: $raffleStatusType, id: $id, description: $description)';
  }
}
