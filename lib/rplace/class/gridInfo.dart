class gridInfo {
  late final int nbLigne;
  late final int nbColonne;
  late final double pixelSize;

  gridInfo({
    required this.nbLigne,
    required this.nbColonne,
    required this.pixelSize,
  });

  gridInfo.fromJson(Map<String, dynamic> json) {
    nbLigne = json['nbLigne'];
    nbColonne = json['nbColonne'];
    pixelSize = json['pixelSize'];
  }

  @override
  String toString() =>
      'Grid(nbLigne: $nbLigne, nbColonne: $nbColonne, pixelSize: $pixelSize)';
}
