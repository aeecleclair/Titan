class CreateDevice {
  final String name;
  final String ed25519PublicKey;

  CreateDevice({required this.name, required this.ed25519PublicKey});

  CreateDevice.fromJson(Map<String, dynamic> json)
    : name = json['name'],
      ed25519PublicKey = json['ed25519_public_key'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'ed25519_public_key': ed25519PublicKey,
  };

  @override
  String toString() {
    return 'CreateDevice {name: $name, ed25519PublicKey: $ed25519PublicKey}';
  }

  CreateDevice.empty() : name = '', ed25519PublicKey = '';
}
