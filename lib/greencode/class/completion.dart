import 'package:myecl/user/class/user.dart';

class Completion {
  late final String id;
  late final int discoveredCount;
  late final int totalCount;
  late final User user;

  Completion({
    required this.id,
    required this.discoveredCount,
    required this.totalCount,
    required this.user,
  });

  Completion.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    discoveredCount = json["discovered_count"];
    totalCount = json["total_count"];
    user = User.fromJson(json["user"]);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["id"] = id;
    data["discovered_count"] = discoveredCount;
    data["total_count"] = totalCount;
    data["user"] = user.toJson();
    return data;
  }

  Completion copyWith({id, discoveredCount, totalCount, user}) {
    return Completion(
      id: id ?? this.id,
      discoveredCount: discoveredCount ?? this.discoveredCount,
      totalCount: totalCount ?? this.totalCount,
      user: user ?? this.user,
    );
  }

  static Completion empty() {
    return Completion(
      id: "",
      discoveredCount: 0,
      totalCount: 0,
      user: User.empty(),
    );
  }

  @override
  String toString() {
    return 'Advert{id: $id, discoveredCount: $discoveredCount, totalCount: $totalCount, user: $user}';
  }
}
