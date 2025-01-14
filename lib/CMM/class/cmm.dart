import 'package:myecl/user/class/list_users.dart';

class CMM {
  CMM({
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

  CMM.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = SimpleUser.fromJson(json['user']);
    myVote = json['my_vote'];
    voteScore = json['vote_score'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    return data;
  }

  CMM.empty() {
    id = "";
    user = SimpleUser.empty();
    myVote = null;
    voteScore = 0;
    status = "neutral";
  }

  @override
  String toString() {
    return 'CMM{vote_score: $voteScore, status: $status}';
  }
}
