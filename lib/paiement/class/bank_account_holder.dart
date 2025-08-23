import 'package:titan/paiement/class/structure.dart';

class BankAccountHolder {
  String holderStructureId;
  Structure holderStructure;

  BankAccountHolder({
    required this.holderStructureId,
    required this.holderStructure,
  });

  factory BankAccountHolder.fromJson(Map<String, dynamic> json) {
    return BankAccountHolder(
      holderStructureId: json['holder_structure_id'],
      holderStructure: Structure.fromJson(json['holder_structure']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'holder_structure_id': holderStructureId,
      'holder_structure': holderStructure.toJson(),
    };
  }

  static BankAccountHolder empty() {
    return BankAccountHolder(
      holderStructureId: '',
      holderStructure: Structure.empty(),
    );
  }
}
