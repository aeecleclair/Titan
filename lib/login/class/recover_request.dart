class RecoverRequest {
  late String resetToken;
  late String newPassword;

  RecoverRequest({
    required this.resetToken,
    required this.newPassword,
  });

  RecoverRequest.fromJson(Map<String, dynamic> json) {
    resetToken = json['reset_token'];
    newPassword = json['new_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reset_token'] = resetToken;
    data['new_password'] = newPassword;
    return data;
  }

  RecoverRequest.empty() {
    resetToken = "";
    newPassword = "";
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

  @override
  String toString() {
    return 'RecoverRequest{resetToken: $resetToken, newPassword: $newPassword}';
  }
}
