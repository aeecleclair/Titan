import 'package:myecl/amap/tools/functions.dart';

class Item {
  Item({
    required this.id,
    required this.name,
    required this.caution,
    required this.groupId,
    required this.expiration,
  });
  late final String id;
  late final String name;
  late final int caution;
  late final String groupId;
  late final DateTime expiration;

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    caution = json['caution'];
    groupId = json['group_id'];
    expiration = DateTime.parse(json['expiration']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['caution'] = caution;
    _data['group_id'] = groupId;
    _data['expiration'] = processDate(expiration);
    return _data;
  }

  Item copyWith({id, name, caution, groupId, expiration}) {
    return Item(
        id: id ?? this.id,
        name: name ?? this.name,
        caution: caution ?? this.caution,
        groupId: groupId ?? this.groupId,
        expiration: expiration ?? this.expiration);
  }
}
