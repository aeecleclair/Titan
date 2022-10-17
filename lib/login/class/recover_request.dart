class RecoverRequest {
  late String resetToken;
  late String newPassword;

  RecoverRequest({
    required this.resetToken,
    required this.newPassword,
  });

  RecoverRequest.fromJson(Map<String, dynamic> json) {
    resetToken = json['resetToken'];
    newPassword = json['newPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['resetToken'] = resetToken;
    data['newPassword'] = newPassword;
    return data;
  }

  RecoverRequest copyWith({
    String? resetToken,
    String? newPassword,
  }) {
    return RecoverRequest(
      resetToken: resetToken ?? this.resetToken,
      newPassword: newPassword ?? this.newPassword,
    );
  }
}