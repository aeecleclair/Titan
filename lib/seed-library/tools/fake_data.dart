import 'package:myecl/seed-library/class/plant_simple.dart';
import 'package:myecl/seed-library/class/species.dart';

final speciesList = [
  Species(
    id: "azerty",
    prefix: "AZE",
    name: "Tomato",
    difficulty: 1,
    type: TypeSpecies.other,
  ),
  Species(
    id: "qsdfgh",
    prefix: "QSD",
    name: "Potato",
    difficulty: 2,
    type: TypeSpecies.aromatic,
  ),
  Species(
    id: "wxcvbn",
    prefix: "WXC",
    name: "Rose",
    difficulty: 3,
    type: TypeSpecies.vegetable,
  ),
  Species(
    id: "yuiop",
    prefix: "YUI",
    name: "Lettuce",
    difficulty: 4,
    type: TypeSpecies.fruit,
  ),
  Species(
    id: "hjklm",
    prefix: "HJK",
    name: "Cucumber",
    difficulty: 5,
    type: TypeSpecies.fruit,
  ),
  Species(
    id: "cvbnm",
    prefix: "CVB",
    name: "Strawberry",
    difficulty: 1,
    type: TypeSpecies.other,
  ),
];

final plantList = [
  PlantSimple(
    id: "azerty",
    state: State.pending,
    speciesId: "azerty",
    plantReference: "AZE-0001",
    propagationMethod: PropagationMethod.cutting,
  ),
  PlantSimple(
    id: "azerty2",
    state: State.pending,
    speciesId: "azerty",
    plantReference: "AZE-0002",
    propagationMethod: PropagationMethod.seed,
  ),
  PlantSimple(
    id: "qsdfgh",
    state: State.pending,
    speciesId: "qsdfgh",
    plantReference: "QSD-0001",
    propagationMethod: PropagationMethod.seed,
  ),
  PlantSimple(
    id: "wxcvbn",
    state: State.pending,
    speciesId: "wxcvbn",
    plantReference: "WXC-0001",
    propagationMethod: PropagationMethod.seed,
  ),
  PlantSimple(
    id: "yuiop",
    state: State.pending,
    speciesId: "yuiop",
    plantReference: "YUI-0001",
    propagationMethod: PropagationMethod.seed,
  ),
  PlantSimple(
    id: "hjklm",
    state: State.pending,
    speciesId: "hjklm",
    plantReference: "HJK-0001",
    propagationMethod: PropagationMethod.seed,
  ),
  PlantSimple(
    id: "cvbnm",
    state: State.pending,
    speciesId: "cvbnm",
    plantReference: "CVB-0001",
    propagationMethod: PropagationMethod.seed,
  ),
];

final myPlantList = [
  PlantSimple(
    id: "azerty",
    state: State.retrieved,
    speciesId: "azerty",
    plantReference: "AZE-0001",
    propagationMethod: PropagationMethod.cutting,
    nickname: "Tomato 1",
  ),
  PlantSimple(
    id: "azerty2",
    state: State.retrieved,
    speciesId: "azerty",
    plantReference: "AZE-0002",
    propagationMethod: PropagationMethod.seed,
    nickname: "Tomato 2",
  ),
  PlantSimple(
    id: "qsdfgh",
    state: State.retrieved,
    speciesId: "qsdfgh",
    plantReference: "QSD-0001",
    propagationMethod: PropagationMethod.seed,
  ),
  PlantSimple(
    id: "wxcvbn",
    state: State.retrieved,
    speciesId: "wxcvbn",
    plantReference: "WXC-0001",
    propagationMethod: PropagationMethod.seed,
    nickname: "Rose 1",
  ),
  PlantSimple(
    id: "yuiop",
    state: State.retrieved,
    speciesId: "yuiop",
    plantReference: "YUI-0001",
    propagationMethod: PropagationMethod.seed,
  ),
  PlantSimple(
    id: "hjklm",
    state: State.retrieved,
    speciesId: "hjklm",
    plantReference: "HJK-0001",
    propagationMethod: PropagationMethod.seed,
    nickname: "Cucumber 1",
  ),
  PlantSimple(
    id: "cvbnm",
    state: State.retrieved,
    speciesId: "cvbnm",
    plantReference: "CVB-0001",
    propagationMethod: PropagationMethod.seed,
    nickname: "Strawberry 1",
  ),
];
