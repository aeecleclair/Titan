class Message {
  late final String titre;
  late final String corps;
  late final String actionId;
  late final String context;
  late final String firebaseId;

  Message({
    required this.titre,
    required this.corps,
    required this.actionId,
    required this.context,
    required this.firebaseId,
  });

  Message.fromJson(Map<String, dynamic> json) {
    titre = json['titre'];
    corps = json['corps'];
    actionId = json['actionId'];
    context = json['context'];
    firebaseId = json['firebaseId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['titre'] = titre;
    data['corps'] = corps;
    data['actionId'] = actionId;
    data['context'] = context;
    data['firebaseId'] = firebaseId;
    return data;
  }

  @override
  String toString() {
    return 'Message{titre: $titre, corps: $corps, actionId: $actionId, context: $context, firebaseId: $firebaseId}';
  }
}