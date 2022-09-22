class Right {
  Right({required this.view, required this.manage, required this.amapId});
  late final bool view;
  late final bool manage;
  late final String amapId;

  Right.fromJson(Map<String, dynamic> json) {
    view = json['view'];
    manage = json['manage'];
    amapId = json['amap_id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['view'] = view;
    data['manage'] = manage;
    data['amap_id'] = amapId;
    return data;
  }

  Right copyWith(
      {view, manage, amapId}) {
    return Right(
        view: view ?? this.view,
        manage: manage ?? this.manage,
        amapId: amapId ?? this.amapId);
  }
}
