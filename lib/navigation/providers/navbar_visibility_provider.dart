import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NavbarVisibilityNotifier extends StateNotifier<bool> {
  NavbarVisibilityNotifier() : super(true);

  bool lastRequestedState = true;
  Timer? _delayTimer;

  void _updateState(bool visible) {
    lastRequestedState = visible;
    if (state != visible) {
      state = visible;
    }
  }

  void show() => _updateState(true);

  void hide() => _updateState(false);

  void showDelayed({Duration delay = const Duration(milliseconds: 500)}) {
    _delayTimer?.cancel();
    _delayTimer = Timer(delay, () {
      _updateState(true);
    });
  }

  void cancelDelayedShow() {
    _delayTimer?.cancel();
  }

  void toggle() => _updateState(!state);

  void forceShow() {
    _delayTimer?.cancel();
    lastRequestedState = true;
    state = true;
  }

  void hideWithoutAutoShow() {
    _delayTimer?.cancel();
    lastRequestedState = false;
    state = false;
  }

  void showTemporarily() {
    _delayTimer?.cancel();
    if (!state) {
      forceShow();
    }
  }

  @override
  void dispose() {
    _delayTimer?.cancel();
    super.dispose();
  }
}

final navbarVisibilityProvider =
    StateNotifierProvider<NavbarVisibilityNotifier, bool>((ref) {
      return NavbarVisibilityNotifier();
    });

class ScrollDirectionNotifier extends StateNotifier<ScrollDirection> {
  ScrollDirectionNotifier() : super(ScrollDirection.idle);

  double _lastScrollOffset = 0;

  void updateScrollDirection(double scrollOffset) {
    final double scrollDelta = scrollOffset - _lastScrollOffset;

    if (scrollDelta > 0) {
      state = ScrollDirection.down;
    } else if (scrollDelta < 0) {
      state = ScrollDirection.up;
    }

    _lastScrollOffset = scrollOffset;
  }

  void resetDirection() {
    state = ScrollDirection.idle;
    _lastScrollOffset = 0;
  }
}

enum ScrollDirection { up, down, idle }

final scrollDirectionProvider =
    StateNotifierProvider<ScrollDirectionNotifier, ScrollDirection>((ref) {
      return ScrollDirectionNotifier();
    });
