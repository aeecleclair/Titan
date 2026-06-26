import 'package:hooks_riverpod/hooks_riverpod.dart';

class NavbarVisibilityNotifier extends Notifier<bool> {
  bool lastRequestedState = true;

  @override
  bool build() => true;

  void _updateState(bool visible) {
    lastRequestedState = visible;
    if (state != visible) {
      state = visible;
    }
  }

  void show() => _updateState(true);

  void hide() => _updateState(false);

  void toggle() => _updateState(!state);

  void forceShow() {
    lastRequestedState = true;
    state = true;
  }

  void hideWithoutAutoShow() {
    lastRequestedState = false;
    state = false;
  }

  void showTemporarily() {
    if (!state) {
      forceShow();
    }
  }
}

final navbarVisibilityProvider =
    NotifierProvider<NavbarVisibilityNotifier, bool>(
      NavbarVisibilityNotifier.new,
    );

class ScrollDirectionNotifier extends Notifier<ScrollDirection> {
  double _lastScrollOffset = 0;

  @override
  ScrollDirection build() => ScrollDirection.idle;

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
    NotifierProvider<ScrollDirectionNotifier, ScrollDirection>(
      ScrollDirectionNotifier.new,
    );
