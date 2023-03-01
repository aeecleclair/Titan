class Information {
  Information({
    required this.respo,
    required this.lien,
  });
  late final String respo;
  late final String lien;
  
  Information.fromJson(Map<String, dynamic> json){
    respo = json['respo'];
    lien = json['lien'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['respo'] = respo;
    data['lien'] = lien;
    return data;
  }

  Information copyWith({
    String? respo,
    String? lien,
  }) {
    return Information(
      respo: respo ?? this.respo,
      lien: lien ?? this.lien,
    );
  }

  @override
  String toString() {
    return 'Information{respo: $respo, lien: $lien}';
  }
}