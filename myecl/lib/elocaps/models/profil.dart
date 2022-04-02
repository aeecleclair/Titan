class Profil {
  String? id;
  int? elo;
  int? rank;

  Profil({this.id, this.elo, this.rank});

  Profil.fromJson(Map<String, dynamic> json) {
    id = json['elocaps_id'];
    elo = json['elo'];
    rank = json['rank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['elocaps_id'] = id;
    data['elo'] = elo;
    data['rank'] = rank;
    return data;
  }
}