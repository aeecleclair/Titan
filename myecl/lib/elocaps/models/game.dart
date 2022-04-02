class Game {
  String? id;
  DateTime? date;
  String? idJ1;
  String? idJ2;
  bool? score;

  Game({this.id, this.date, this.idJ1, this.idJ2, this.score});

  Game.fromJson(Map<String, dynamic> json) {
    id = json['match_id'];
    if (json['date'] != null) {
      date = DateTime.parse(json['date']);
    } else {
      date = null;
    }
    idJ1 = json['id_j1'];
    idJ2 = json['id_j2'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['match_id'] = id;
    data['date'] = date.toString();
    data['id_j1'] = idJ1;
    data['id_j2'] = idJ2;
    data['score'] = score;
    return data;
  }
}
