import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/navigation/providers/navbar_visibility_provider.dart';

class ScrollToHideNavbar extends ConsumerStatefulWidget {
  final Widget child;
  final ScrollController controller;
  final Duration duration;

  const ScrollToHideNavbar({
    super.key,
    required this.child,
    required this.controller,
    this.duration = const Duration(milliseconds: 200),
  });

  @override
  ConsumerState<ScrollToHideNavbar> createState() => _ScrollToHideNavbarState();
}

class _ScrollToHideNavbarState extends ConsumerState<ScrollToHideNavbar> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_scrollListener);
    super.dispose();
  }

  double _previousOffset = 0;
  bool _isScrollingDown = false;
  final _scrollThreshold = 2.0; // Lower threshold to detect slower scrolling
  final _directionChangeThreshold =
      3.0; // Threshold specifically for direction changes
  bool _isOverscrollInProgress = false;
  DateTime _lastDirectionChange = DateTime.now();
  DateTime _lastSlowScrollCheck = DateTime.now();

  void _scrollListener() {
    final navbarVisibilityNotifier = ref.read(
      navbarVisibilityProvider.notifier,
    );
    final scrollDirectionNotifier = ref.read(scrollDirectionProvider.notifier);

    // Get current scroll metrics
    final ScrollPosition position = widget.controller.position;
    final double currentOffset = position.pixels;
    final double maxScrollExtent = position.maxScrollExtent;
    final bool isAtTop = currentOffset <= 0;
    final bool isAtBottom = currentOffset >= maxScrollExtent;

    // Always show navbar if at the top
    if (isAtTop) {
      navbarVisibilityNotifier.show();
      _previousOffset = 0;
      _isOverscrollInProgress = false;
      return;
    }

    // Calculate scroll difference
    final double scrollDelta = (currentOffset - _previousOffset).abs();

    // Check if currently in overscroll state (for BouncingScrollPhysics)
    bool isOverScrolling = position.outOfRange;

    // Mark the beginning of an overscroll
    if (isOverScrolling && !_isOverscrollInProgress) {
      _isOverscrollInProgress = true;
    }

    // Reset overscroll state when scrolling away from edges
    if (!isOverScrolling &&
        _isOverscrollInProgress &&
        !isAtTop &&
        !isAtBottom) {
      _isOverscrollInProgress = false;
    }

    // Ignore small movements (helps with bouncing physics)
    if (scrollDelta < _scrollThreshold) {
      _previousOffset = currentOffset;
      return;
    }

    // Handle scroll direction and visibility updates if not overscrolling
    if (!_isOverscrollInProgress) {
      bool newIsScrollingDown = currentOffset > _previousOffset;
      final currentTime = DateTime.now();
      final timeSinceLastChange = currentTime
          .difference(_lastDirectionChange)
          .inMilliseconds;
      final timeSinceLastSlowCheck = currentTime
          .difference(_lastSlowScrollCheck)
          .inMilliseconds;

      // Process direction changes with minimum time threshold
      if (_isScrollingDown != newIsScrollingDown &&
          scrollDelta >= _directionChangeThreshold &&
          timeSinceLastChange > 100) {
        _isScrollingDown = newIsScrollingDown;
        _lastDirectionChange = currentTime;

        // Update direction notifier
        scrollDirectionNotifier.updateScrollDirection(currentOffset);

        // Update navbar visibility based on direction change
        if (newIsScrollingDown) {
          // Scrolling down - hide navbar
          navbarVisibilityNotifier.hide();
        } else {
          // Scrolling up - show navbar
          navbarVisibilityNotifier.show();
        }
      }
      // Handle continuous scrolling in the same direction
      else if (scrollDelta >= _scrollThreshold &&
          timeSinceLastSlowCheck > 150) {
        // Update timestamp for slow scroll check
        _lastSlowScrollCheck = currentTime;

        // Handle continuous downward scrolling - ensure navbar hides
        if (newIsScrollingDown) {
          navbarVisibilityNotifier.hide();
        }
        // For continuous upward scrolling, ensure navbar shows
        else if (!newIsScrollingDown && !isAtTop) {
          navbarVisibilityNotifier.show();
        }
      }
    }

    // Update previous offset for next comparison
    _previousOffset = currentOffset;
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
