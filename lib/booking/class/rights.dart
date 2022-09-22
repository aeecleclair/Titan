class Right {
  Right({required this.view, required this.manage});
  late final bool view;
  late final bool manage;

  Right.fromJson(Map<String, dynamic> json) {
    view = json['view'];
    manage = json['manage'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['view'] = view;
    data['manage'] = manage;
    return data;
  }

  Right copyWith({view, manage, amapId}) {
    return Right(
        view: view ?? this.view,
        manage: manage ?? this.manage);
  }
}
