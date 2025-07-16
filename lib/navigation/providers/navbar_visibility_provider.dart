import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Class to manage the navbar visibility state
class NavbarVisibilityNotifier extends StateNotifier<bool> {
  NavbarVisibilityNotifier() : super(true);

  // Debounce timer to prevent rapid show/hide transitions
  Timer? _debounceTimer;
  Timer? _hideTimer;

  // Track the last requested state to prevent unnecessary updates
  bool _lastRequestedState = true;

  // Update state with debounce to avoid flickering
  void _updateState(bool visible) {
    // Track the requested state
    _lastRequestedState = visible;

    // Cancel any pending timers
    _debounceTimer?.cancel();
    _hideTimer?.cancel();

    // Only update if the state is actually changing
    if (state != visible) {
      // Faster response for showing (better UX), shorter delay for hiding
      if (visible) {
        // Show immediately for better responsiveness when scrolling up
        _debounceTimer = Timer(const Duration(milliseconds: 50), () {
          if (_lastRequestedState == true) {
            state = true;
          }
        });
      } else {
        // Shorter delay for hiding to make it more responsive to slow scrolling
        _hideTimer = Timer(const Duration(milliseconds: 100), () {
          if (_lastRequestedState == false) {
            state = false;
          }
        });
      }
    }
  }

  void show() => _updateState(true);
  void hide() => _updateState(false);
  void toggle() => _updateState(!state);

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _hideTimer?.cancel();
    super.dispose();
  }
}

// Provider for navbar visibility
final navbarVisibilityProvider =
    StateNotifierProvider<NavbarVisibilityNotifier, bool>((ref) {
      return NavbarVisibilityNotifier();
    });

// Class to manage scroll direction detection
class ScrollDirectionNotifier extends StateNotifier<ScrollDirection> {
  ScrollDirectionNotifier() : super(ScrollDirection.idle);

  double _lastScrollOffset = 0;
  DateTime _lastDirectionChange = DateTime.now();

  // Minimum threshold for scrolling to be considered significant
  final double _scrollThreshold = 5.0;

  // Minimum time between direction changes to prevent rapid toggling
  final int _directionChangeThresholdMs = 50;

  void updateScrollDirection(double scrollOffset) {
    // Calculate scroll delta
    final double scrollDelta = (scrollOffset - _lastScrollOffset).abs();

    // Get current time to check rate of direction changes
    final now = DateTime.now();
    final timeSinceLastChange = now
        .difference(_lastDirectionChange)
        .inMilliseconds;

    // Handle both normal scrolling and slow scrolling:
    // 1. Normal: Significant delta + time threshold
    // 2. Slow: Lower delta threshold but longer time between updates
    bool isSignificantScrolling =
        scrollDelta > _scrollThreshold &&
        timeSinceLastChange > _directionChangeThresholdMs;

    bool isSlowScrolling = scrollDelta > 1.0 && timeSinceLastChange > 200;

    if (isSignificantScrolling || isSlowScrolling) {
      final previousState = state;

      if (scrollOffset > _lastScrollOffset) {
        // Scrolling down
        state = ScrollDirection.down;
      } else if (scrollOffset < _lastScrollOffset) {
        // Scrolling up
        state = ScrollDirection.up;
      }

      // If direction changed, update the timestamp
      if (previousState != state) {
        _lastDirectionChange = now;
      } else {
        // Even if direction didn't change, update timestamp for slow scrolling
        // to avoid too frequent updates
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

// Provider for scroll direction
final scrollDirectionProvider =
    StateNotifierProvider<ScrollDirectionNotifier, ScrollDirection>((ref) {
      return ScrollDirectionNotifier();
    });
