import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


/// Le notifier du controlleur de défilement
class ScrollControllerNotifier extends StateNotifier<ScrollController> {
  ScrollControllerNotifier(ScrollController scrollController)
      : super(scrollController);
}

/// Le provider du controlleur de défilement (on passe un controlleur d'animation en paramètre, d'où le .family et l'AnimationController en plus)
final scrollControllerProvider =
    StateNotifierProvider.family<
    ScrollControllerNotifier, ScrollController, AnimationController>((ref, animationController) {
  ScrollController _scrollController = ScrollController();
  // Les actions quand on scroll la page
  _scrollController.addListener(() {
    switch (_scrollController.position.userScrollDirection) {
      // Si on descend dans la liste
      case ScrollDirection.forward:
        // On lance l'animation (on fait disparaître le texte)
        animationController.forward();
        break;
      // Si on remonte dans la liste
      case ScrollDirection.reverse:
        animationController.reverse();
        // On inverse l'animation (on fait réaparaître le texte)
        break;
      // Si on ne fait rien, il ne se passe rien
      case ScrollDirection.idle:
        break;
    }
  });
  return ScrollControllerNotifier(_scrollController);
});


