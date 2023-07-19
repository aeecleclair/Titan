class Player{
  Player({
    required this.userid,
    required this.id,
    required this.elo,
  });
  late final String userid;
  late final String id;
  late final int elo;

  Player.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    id = json['id'];
    elo = json['elo'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userid'] = userid;
    data['id'] = id;
    data['elo'] = elo;
    return data;
  }

  Player copyWith({
    String? userid,
    String? id,
    int? elo,
  }) => Player(
    userid: userid ?? this.userid,
    id: id ?? this.id,
    elo: elo ?? this.elo,
  );

  Player.empty() {
    userid = '';
    id = '';
    elo = 0;
  }

  @override
  String toString() {
    return 'Player(userid: $userid, id: $id, elo: $elo)';
  }
}