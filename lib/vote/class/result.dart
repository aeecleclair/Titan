class Result {
  late String id;
  late int count;

  Result({required this.id, required this.count});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['list_id'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['list_id'] = id;
    data['count'] = count;
    return data;
  }

  Result.empty() {
    id = '';
    count = 0;
  }
}
