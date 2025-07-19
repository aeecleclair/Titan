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
  final _scrollThreshold = 2.0;
  final _directionChangeThreshold = 3.0;
  bool _isOverscrollInProgress = false;
  DateTime _lastDirectionChange = DateTime.now();
  DateTime _lastSlowScrollCheck = DateTime.now();

  void _scrollListener() {
    final navbarVisibilityNotifier = ref.read(
      navbarVisibilityProvider.notifier,
    );
    final scrollDirectionNotifier = ref.read(scrollDirectionProvider.notifier);

    final ScrollPosition position = widget.controller.position;
    final double currentOffset = position.pixels;
    final double maxScrollExtent = position.maxScrollExtent;
    final bool isAtTop = currentOffset <= 0;
    final bool isAtBottom = currentOffset >= maxScrollExtent;

    if (isAtTop) {
      navbarVisibilityNotifier.show();
      _previousOffset = 0;
      _isOverscrollInProgress = false;
      return;
    }

    final double scrollDelta = (currentOffset - _previousOffset).abs();

    bool isOverScrolling = position.outOfRange;

    if (isOverScrolling && !_isOverscrollInProgress) {
      _isOverscrollInProgress = true;
    }

    if (!isOverScrolling &&
        _isOverscrollInProgress &&
        !isAtTop &&
        !isAtBottom) {
      _isOverscrollInProgress = false;
    }

    if (scrollDelta < _scrollThreshold) {
      _previousOffset = currentOffset;
      return;
    }

    if (!_isOverscrollInProgress) {
      bool newIsScrollingDown = currentOffset > _previousOffset;
      final currentTime = DateTime.now();
      final timeSinceLastChange = currentTime
          .difference(_lastDirectionChange)
          .inMilliseconds;
      final timeSinceLastSlowCheck = currentTime
          .difference(_lastSlowScrollCheck)
          .inMilliseconds;

      if (_isScrollingDown != newIsScrollingDown &&
          scrollDelta >= _directionChangeThreshold &&
          timeSinceLastChange > 100) {
        _isScrollingDown = newIsScrollingDown;
        _lastDirectionChange = currentTime;

        scrollDirectionNotifier.updateScrollDirection(currentOffset);

        if (newIsScrollingDown) {
          navbarVisibilityNotifier.hide();
        } else {
          navbarVisibilityNotifier.show();
        }
      } else if (scrollDelta >= _scrollThreshold &&
          timeSinceLastSlowCheck > 150) {
        _lastSlowScrollCheck = currentTime;

        if (newIsScrollingDown) {
          navbarVisibilityNotifier.hide();
        } else if (!newIsScrollingDown && !isAtTop) {
          navbarVisibilityNotifier.show();
        }
      }
    }

    _previousOffset = currentOffset;
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
