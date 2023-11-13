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
    userId = json['userId'];
    sharerGroupId = json['sharerGroupId'];
    position = json['position'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['sharerGroupId'] = sharerGroupId;
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