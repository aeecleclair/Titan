import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/navigation/providers/navbar_visibility_provider.dart';

class ScrollToHideNavbar extends ConsumerStatefulWidget {
  final Widget child;
  final ScrollController controller;
  final Duration hideDelay;
  final Duration showDelay;

  const ScrollToHideNavbar({
    super.key,
    required this.child,
    required this.controller,
    this.hideDelay = const Duration(milliseconds: 100),
    this.showDelay = const Duration(milliseconds: 500),
  });

  @override
  ConsumerState<ScrollToHideNavbar> createState() => _ScrollToHideNavbarState();
}

class _ScrollToHideNavbarState extends ConsumerState<ScrollToHideNavbar> {
  double _previousOffset = 0;
  bool _isScrollingDown = false;
  bool _isAtTop = true;
  bool _isAtBottom = false;
  bool _isOverScrolling = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_scrollListener);

    ref.read(navbarVisibilityProvider.notifier).cancelDelayedShow();
    super.dispose();
  }

  void _scrollListener() {
    final navbarVisibilityNotifier = ref.read(
      navbarVisibilityProvider.notifier,
    );
    final ScrollPosition position = widget.controller.position;

    final double currentOffset = position.pixels;
    final double maxScrollExtent = position.maxScrollExtent;
    final double scrollDelta = currentOffset - _previousOffset;

    _isAtTop = currentOffset <= 0;
    _isAtBottom = currentOffset >= maxScrollExtent;
    _isOverScrolling = currentOffset < 0 || currentOffset > maxScrollExtent;

    if (currentOffset < 0) {
      navbarVisibilityNotifier.forceShow();
      _previousOffset = currentOffset;
      return;
    }

    if (_isAtTop) {
      navbarVisibilityNotifier.forceShow();
      _previousOffset = 0;
      return;
    }

    if (currentOffset > maxScrollExtent) {
      _previousOffset = currentOffset;
      return;
    }

    if (_isAtBottom) {
      _previousOffset = currentOffset;
      return;
    }

    if (!_isOverScrolling && scrollDelta.abs() > 1.0) {
      _isScrollingDown = scrollDelta > 0;

      if (_isScrollingDown) {
        navbarVisibilityNotifier.cancelDelayedShow();
        navbarVisibilityNotifier.hide();
      } else {
        navbarVisibilityNotifier.showDelayed(delay: widget.showDelay);
      }
    }

    _previousOffset = currentOffset;
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
