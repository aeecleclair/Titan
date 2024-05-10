import 'package:myecl/user/class/user.dart';

class GreenCodeItem {
  late final String id;
  late final String qrCodeContent;
  late final String title;
  late final String content;
  late final List<User> users;

  GreenCodeItem({
    required this.id,
    required this.qrCodeContent,
    required this.title,
    required this.content,
    this.users = const [],
  });

  GreenCodeItem.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    qrCodeContent = json["qr_code_content"];
    title = json["title"];
    content = json["content"];
    if (json["users"] != null) {
      users = List<User>.from(json["users"].map((x) => User.fromJson(x)));
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["id"] = id;
    data["qr_code_content"] = qrCodeContent;
    data["title"] = title;
    data["content"] = content;
    if (data["users"] != null) {
      data["users"] = users.map((x) => x.toJson()).toList();
    }
    return data;
  }

  GreenCodeItem copyWith({id, qrCodeContent, title, content, users}) {
    return GreenCodeItem(
      id: id ?? this.id,
      qrCodeContent: qrCodeContent ?? this.qrCodeContent,
      title: title ?? this.title,
      content: content ?? this.content,
      users: users ?? this.users,
    );
  }

  static GreenCodeItem empty() {
    return GreenCodeItem(
      id: "",
      qrCodeContent: "",
      title: "",
      content: "",
    );
  }

  @override
  String toString() {
    return 'Advert{id: $id, qrCodeContent: $qrCodeContent, title: $title, content: $content , users: $users}';
  }
}
