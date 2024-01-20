class SharerGroupMembership {
  late final String userId;
  late final String sharerGroupId;
  late final int position;
  late final bool active;

  SharerGroupMembership({
    required this.userId,
    required this.sharerGroupId,
    required this.position,
    required this.active,
  });

  SharerGroupMembership.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    sharerGroupId = json['sharer_group_id'];
    position = json['position'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['sharer_group_id'] = sharerGroupId;
    data['position'] = position;
    data['active'] = active;
    return data;
  }

  @override
  String toString() {
    return 'SharerGroupMembership{userId: $userId, sharerGroupId: $sharerGroupId, position: $position, active: $active}';
  }

  SharerGroupMembership copyWith({
    String? userId,
    String? sharerGroupId,
    int? position,
    bool? active,
  }) {
    return SharerGroupMembership(
      userId: userId ?? this.userId,
      sharerGroupId: sharerGroupId ?? this.sharerGroupId,
      position: position ?? this.position,
      active: active ?? this.active,
    );
  }

  SharerGroupMembership.empty()
      : this(
          userId: '',
          sharerGroupId: '',
          position: 0,
          active: false,
        );
}