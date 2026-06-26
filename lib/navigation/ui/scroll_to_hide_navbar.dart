import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/navigation/providers/navbar_visibility_provider.dart';

class ScrollToHideNavbar extends ConsumerStatefulWidget {
  final Widget child;
  final ScrollController controller;

  const ScrollToHideNavbar({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  ConsumerState<ScrollToHideNavbar> createState() => _ScrollToHideNavbarState();
}

class _ScrollToHideNavbarState extends ConsumerState<ScrollToHideNavbar> {
  double _previousOffset = 0;

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

  void _scrollListener() {
    final navbarVisibilityNotifier = ref.read(
      navbarVisibilityProvider.notifier,
    );
    final ScrollPosition position = widget.controller.position;

    final double currentOffset = position.pixels;
    final double maxScrollExtent = position.maxScrollExtent;

    if (currentOffset <= 0) {
      navbarVisibilityNotifier.show();
      _previousOffset = 0;
      return;
    }

    if (currentOffset >= maxScrollExtent) {
      _previousOffset = currentOffset;
      return;
    }

    final double scrollDelta = currentOffset - _previousOffset;

    if (scrollDelta > 0) {
      navbarVisibilityNotifier.hide();
    } else if (scrollDelta < 0) {
      navbarVisibilityNotifier.show();
    }

    _previousOffset = currentOffset;
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
