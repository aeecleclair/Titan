import 'package:flutter/material.dart';
import 'package:myecl/sg/class/sg.dart';
import 'package:myecl/sg/class/sg_state.dart';

SgState getStateByDate(DateTime openDate, DateTime closeDate) {
  if (DateTime.now().isAfter(openDate) && DateTime.now().isBefore(closeDate)) {
    return SgState.open;
  }
  return SgState.closed;
}

String sgStateToString(SgState state) {
  switch (state) {
    case SgState.open:
      return "Ouvert";
    case SgState.closed:
      return "Fermé";
    case SgState.outOfStock:
      return "Rupture";
    case SgState.succeeded:
      return "Réussi";
    default:
      return "Erreur";
  }
}

Color sgStateToColor(SgState state) {
  switch (state) {
    case SgState.open:
      return Colors.green;
    case SgState.closed:
      return Colors.red;
    case SgState.outOfStock:
      return Colors.orange;
    case SgState.succeeded:
      return Colors.blue;
    default:
      return Colors.grey;
  }
}

bool beforeOrAfter(Sg sg) {
  return DateTime.now().isBefore(sg.openDate);
}
