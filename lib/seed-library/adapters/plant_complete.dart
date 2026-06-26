import 'package:titan/generated/openapi.models.swagger.dart';

extension $PlantComplete on PlantComplete {
  PlantSimple toPlantSimple() {
    return PlantSimple(
      id: id,
      nickname: nickname,
      plantingDate: plantingDate,
      state: state,
      reference: reference,
      speciesId: speciesId,
      propagationMethod: propagationMethod,
    );
  }
}
