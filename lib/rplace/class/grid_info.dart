class GridInfo {
  late final int nbLigne;
  late final int nbColonne;
  late final double pixelSize;
  late final Duration cooldown;

  GridInfo({
    required this.nbLigne,
    required this.nbColonne,
    required this.pixelSize,
    required this.cooldown,
  });

  GridInfo.fromJson(Map<String, dynamic> json) {
    nbLigne = json['nbLigne'];
    nbColonne = json['nbColonne'];
    pixelSize = json['pixelSize'];
    cooldown = Duration(microseconds: json['cooldown']);
  }

  @override
  String toString() =>
      'Grid(nbLigne: $nbLigne, nbColonne: $nbColonne, pixelSize: $pixelSize, cooldown: $cooldown)';
}
