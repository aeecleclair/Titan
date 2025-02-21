import 'package:myecl/user/class/list_users.dart';

class Meme {
  Meme({
    required this.id,
    required this.user,
    required this.myVote,
    required this.voteScore,
    required this.status,
  });
  late final String id;
  late final SimpleUser user;
  late final bool? myVote;
  late final int voteScore;
  late final String status;

  Meme.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = SimpleUser.fromJson(json['user']);
    myVote = json['my_vote'];
    voteScore = json['vote_score'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['user'] = user;
    data['my_vote'] = myVote;
    data['vote_score'] = voteScore;
    data['status'] = status;
    return data;
  }

  Meme.empty() {
    id = "";
    user = SimpleUser.empty();
    myVote = null;
    voteScore = 0;
    status = "neutral";
  }

  @override
  String toString() {
    return 'Meme{id : $id, user:$user, myVote : $myVote, vote_score: $voteScore, status: $status}';
  }
}
