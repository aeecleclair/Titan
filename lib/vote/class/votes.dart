class Votes {
  late final String id;

  Votes({required this.id});

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['list_id'] = id;
    return data;
  }

  Votes.empty() {
    id = "";
  }
}
