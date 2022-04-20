import 'package:flutter/material.dart';

class Module {
  String name;
  IconData icon;
  int pos;
  bool selected;

  Module(
      {required this.name,
      required this.icon,
      required this.pos,
      required this.selected});

  Module copy({name, icon, pos, selected}) => Module(
        name: name ?? this.name,
        icon: icon ?? this.icon,
        pos: pos ?? this.pos,
        selected: selected ?? this.selected,
      );
}
