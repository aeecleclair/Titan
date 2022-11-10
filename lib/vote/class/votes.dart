class Votes {
  late final List<String> ids;

  Votes({required this.ids});

  Votes.fromJson(Map<String, dynamic> json) {
    ids = json['list_id'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['list_id'] = ids;
    return data;
  }

  Votes.empty() {
    ids = [];
  }
}
