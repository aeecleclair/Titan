import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NavbarVisibilityNotifier extends StateNotifier<bool> {
  NavbarVisibilityNotifier() : super(true);

  Timer? _debounceTimer;
  Timer? _hideTimer;
  Timer? _autoShowTimer;

  bool _lastRequestedState = true;

  static const Duration _autoShowDelay = Duration(milliseconds: 800);
  static const Duration _debounceDelay = Duration(milliseconds: 50);
  static const Duration _hideDelay = Duration(milliseconds: 100);

  void _updateState(bool visible) {
    _lastRequestedState = visible;

    _debounceTimer?.cancel();
    _hideTimer?.cancel();

    if (visible) {
      _autoShowTimer?.cancel();
    }

    if (state != visible) {
      if (visible) {
        _debounceTimer = Timer(_debounceDelay, () {
          if (_lastRequestedState == true) {
            state = true;
          }
        });
      } else {
        _hideTimer = Timer(_hideDelay, () {
          if (_lastRequestedState == false) {
            state = false;

            _startAutoShowTimer();
          }
        });
      }
    }
  }

  void _startAutoShowTimer() {
    _autoShowTimer?.cancel();
    _autoShowTimer = Timer(_autoShowDelay, () {
      if (!state) {
        _lastRequestedState = true;
        state = true;
      }
    });
  }

  void show() => _updateState(true);

  void hide() => _updateState(false);

  void toggle() => _updateState(!state);

  void forceShow() {
    _debounceTimer?.cancel();
    _hideTimer?.cancel();
    _autoShowTimer?.cancel();
    _lastRequestedState = true;
    state = true;
  }

  void hideWithoutAutoShow() {
    _debounceTimer?.cancel();
    _hideTimer?.cancel();
    _autoShowTimer?.cancel();
    _lastRequestedState = false;
    state = false;
  }

  void showTemporarily() {
    if (!state) {
      forceShow();
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _hideTimer?.cancel();
    _autoShowTimer?.cancel();
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
  DateTime _lastDirectionChange = DateTime.now();

  final double _scrollThreshold = 5.0;

  final int _directionChangeThresholdMs = 50;

  void updateScrollDirection(double scrollOffset) {
    final double scrollDelta = (scrollOffset - _lastScrollOffset).abs();

    final now = DateTime.now();
    final timeSinceLastChange = now
        .difference(_lastDirectionChange)
        .inMilliseconds;

    bool isSignificantScrolling =
        scrollDelta > _scrollThreshold &&
        timeSinceLastChange > _directionChangeThresholdMs;

    bool isSlowScrolling = scrollDelta > 1.0 && timeSinceLastChange > 200;

    if (isSignificantScrolling || isSlowScrolling) {
      final previousState = state;

      if (scrollOffset > _lastScrollOffset) {
        state = ScrollDirection.down;
      } else if (scrollOffset < _lastScrollOffset) {
        state = ScrollDirection.up;
      }

      if (previousState != state) {
        _lastDirectionChange = now;
      } else {
        _lastDirectionChange = now;
      }

      _lastScrollOffset = scrollOffset;
    }
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
