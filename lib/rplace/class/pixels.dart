import 'package:flutter/material.dart';
import 'package:myecl/rplace/class/pixel.dart';

//var pixels_list = [Pixel(offset: const Offset(10, 10), color: Colors.red)];
final nb_ligne = 10;
final nb_colonne = 10;
var pixels_list = [
  for (int i = 0; i < nb_ligne; i++)
    for (int j = 0; j < nb_colonne; j++)
      Pixel(
          offset: Offset((10 * i + 5).toDouble(), (10 * j + 5).toDouble()),
          color: Colors.red)
];
