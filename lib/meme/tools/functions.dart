Map<String, dynamic> toJson(bool positive) {
  final data = <String, dynamic>{};
  data['positive'] = positive;
  return data;
}
