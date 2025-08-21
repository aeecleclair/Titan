import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/navigation/providers/navbar_visibility_provider.dart';
import 'package:titan/tools/constants.dart';

class ScrollWithRefreshButton extends HookConsumerWidget {
  final ScrollController controller;
  final Future<void> Function() onRefresh;

  const ScrollWithRefreshButton({
    super.key,
    required this.controller,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showRefreshButton = useState(false);
    final lastScrollPosition = useState(0.0);
    final hasScrolledEnough = useState(false);

    final lastUserScrollTime = useState(DateTime.now());
    final consecutiveUpwardScrolls = useState(0);

    useEffect(() {
      void scrollListener() {
        if (!controller.hasClients) return;

        final navbarVisibilityNotifier = ref.read(
          navbarVisibilityProvider.notifier,
        );
        final position = controller.position;
        final currentScrollPosition = position.pixels;
        final scrollDirection =
            currentScrollPosition - lastScrollPosition.value;
        final maxScrollExtent = position.maxScrollExtent;

        if (currentScrollPosition <= 0) {
          navbarVisibilityNotifier.show();
        } else if (currentScrollPosition >= maxScrollExtent) {
        } else if (scrollDirection > 0) {
          navbarVisibilityNotifier.hide();
        } else if (scrollDirection < 0) {
          navbarVisibilityNotifier.show();
        }

        final now = DateTime.now();

        if (scrollDirection.abs() < 3) return;

        final isAtTop = currentScrollPosition <= position.minScrollExtent;
        final isAtBottom = currentScrollPosition >= position.maxScrollExtent;
        final isInBounceZone = isAtTop || isAtBottom;

        if (currentScrollPosition > 200 && !hasScrolledEnough.value) {
          hasScrolledEnough.value = true;
        }

        if (scrollDirection < -15) {
          final timeSinceLastScroll = now
              .difference(lastUserScrollTime.value)
              .inMilliseconds;

          if (!isInBounceZone && timeSinceLastScroll > 50) {
            consecutiveUpwardScrolls.value++;
            lastUserScrollTime.value = now;

            if (hasScrolledEnough.value &&
                consecutiveUpwardScrolls.value >= 2 &&
                !showRefreshButton.value) {
              showRefreshButton.value = true;
            }
          }
        } else if (scrollDirection > 5) {
          consecutiveUpwardScrolls.value = 0;
          lastUserScrollTime.value = now;

          if (showRefreshButton.value && currentScrollPosition > 50) {
            showRefreshButton.value = false;
          }
        }

        lastScrollPosition.value = currentScrollPosition;
      }

      controller.addListener(scrollListener);
      return () => controller.removeListener(scrollListener);
    }, []);

    Future<void> handleRefresh() async {
      showRefreshButton.value = false;
      await onRefresh();
    }

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      top: showRefreshButton.value ? 10 : -10,
      left: 0,
      right: 0,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        opacity: showRefreshButton.value ? 1.0 : 0.0,
        child: Center(
          child: GestureDetector(
            onTap: handleRefresh,
            child: Container(
              decoration: BoxDecoration(
                color: ColorConstants.main,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: ColorConstants.onMain.withValues(alpha: 0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  HeroIcon(
                    HeroIcons.arrowPath,
                    size: 16,
                    color: ColorConstants.background,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Actualiser',
                    style: TextStyle(
                      color: ColorConstants.background,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
