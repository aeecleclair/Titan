import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/navigation/class/module.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/providers/path_forwarding_provider.dart';

class FloatingNavbarItem {
  final Function()? onTap;
  final Module module;

  FloatingNavbarItem({this.onTap, required this.module});
}

// Get the current route path
String getCurrentPath() {
  if (QR.history.isEmpty) return '';

  String currentPath = QR.history.last.path;
  final parts = currentPath.split('/');
  if (parts.length > 1 && parts[1].isNotEmpty) {
    return '/${parts[1]}';
  }
  return '';
}

class FloatingNavbar extends HookConsumerWidget {
  final List<FloatingNavbarItem> items;
  const FloatingNavbar({super.key, required this.items});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pathProvider = ref.watch(pathForwardingProvider);
    // Track previous index for animation
    final previousIndex = useRef<int>(0);
    // Use useState to maintain internal state for animation
    final currentState = useState<int>(3); // Default to "Autres"

    // Get the path from router
    final currentPath = pathProvider.path;

    // Calculate the selected index based on the current path
    final routeIndex = useState<int>(3);

    useEffect(() {
      // This effect runs on every build, but we only care about the initial path
      if (currentPath.isNotEmpty) {
        print("Current path: $currentPath");
        print("items ${items.map((e) => e.module.root).toList()}");
        routeIndex.value = items.indexWhere((item) => item.module.root == currentPath);
        // Only use found index if it's in visible range
        if (routeIndex.value < 0 || routeIndex.value >= items.length) {
          routeIndex.value = 3; // No match or not in visible modules
        }
      }
      print("Selected index: $routeIndex");
      return null;
    }, [currentPath]);


    // Initialize the currentState on first render only
    useEffect(() {
      currentState.value = routeIndex.value;
      previousIndex.value = routeIndex.value; // Initialize previous index
      return null;
    }, []);

    final borderRadius = 25.0;

    // Animation controller for all animations
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );

    // Slide animation reference
    final slideAnimation = useRef<Animation<double>?>(null);

    // Store the latest calculated item width to use in animations
    final itemWidthRef = useRef<double>(0.0);

    // Watch for path changes and update the selection with proper animation
    useEffect(() {
      if (currentPath.isNotEmpty && routeIndex.value != currentState.value) {
        // When path changes, store current selection as previous
        previousIndex.value = currentState.value;
        // Then update to the new route-based selection
        currentState.value = routeIndex.value;
      }
      return null;
    }, [currentPath, routeIndex]);

    // Update animation when index changes - this needs to be in the build method, not in LayoutBuilder
    useEffect(() {
      // Only trigger animation if we have a valid item width and the index has changed
      if (previousIndex.value != currentState.value && itemWidthRef.value > 0) {
        // Create tween from previous to current position
        slideAnimation.value =
            Tween<double>(
              begin: previousIndex.value * itemWidthRef.value,
              end: currentState.value * itemWidthRef.value,
            ).animate(
              CurvedAnimation(
                parent: animationController,
                curve: Curves.easeOutCubic, // Smoother easing curve
              ),
            );

        // Reset and start animation
        animationController.reset();
        animationController.forward();
      }
      return null;
    }, [currentState.value, itemWidthRef.value]);

    // Use LayoutBuilder for proper sizing
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Material(
        elevation: 10,
        shadowColor: ColorConstants.main.withOpacity(0.2),
        borderRadius: BorderRadius.circular(borderRadius),
        color: ColorConstants.main,
        child: Container(
          height: borderRadius * 2,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Calculate item width based on actual available width
              final availableWidth = constraints.maxWidth;
              final itemWidth = availableWidth / items.length;

              // Store the width for use in the useEffect hook
              itemWidthRef.value = itemWidth;

              return Stack(
                children: [
                  // Animated selection indicator with smooth slide
                  AnimatedBuilder(
                    animation: animationController,
                    builder: (context, _) {
                      // Get current position from slide animation or fall back to current index
                      final leftPosition = slideAnimation.value != null
                          ? slideAnimation.value!.value
                          : itemWidth * currentState.value;

                      return Positioned(
                        left: leftPosition,
                        top: 4,
                        bottom: 4,
                        width: itemWidth,
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorConstants.background,
                            borderRadius: BorderRadius.circular(borderRadius),
                          ),
                        ),
                      );
                    },
                  ),
                  // Items row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: items.asMap().entries.map((entry) {
                      final index = entry.key;
                      final item = entry.value;
                      final isSelected = index == currentState.value;

                      // Use AnimatedBuilder for text color to sync with indicator animation
                      return Expanded(
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(borderRadius),
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              // Only animate if this isn't already the selected item
                              if (index != currentState.value) {
                                // Store current index as previous for animation
                                previousIndex.value = currentState.value;
                                // Update the internal state immediately for animation
                                currentState.value = index;
                              }
                              // Then call the callback
                              item.onTap?.call();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: AnimatedBuilder(
                                animation: animationController,
                                builder: (context, child) {
                                  // Calculate color and weight based on selection and animation
                                  Color textColor;
                                  FontWeight textWeight;

                                  if (previousIndex.value ==
                                      currentState.value) {
                                    // No transition happening
                                    textColor = isSelected
                                        ? ColorConstants.main
                                        : ColorConstants.background;
                                    textWeight = isSelected
                                        ? FontWeight.w600
                                        : FontWeight.normal;
                                  } else {
                                    // During transition, determine if this item is involved
                                    bool isInvolved =
                                        index == previousIndex.value ||
                                        index == currentState.value;

                                    if (!isInvolved) {
                                      // Not involved in transition
                                      textColor = ColorConstants.background;
                                      textWeight = FontWeight.normal;
                                    } else if (index == currentState.value) {
                                      // Transitioning to selected
                                      final progress =
                                          animationController.value;
                                      textColor = Color.lerp(
                                        ColorConstants.background,
                                        ColorConstants.main,
                                        progress,
                                      )!;
                                      // Use a simpler approach for font weight transition
                                      textWeight = progress < 0.5
                                          ? FontWeight.normal
                                          : FontWeight.w600;
                                    } else {
                                      // Transitioning from selected
                                      final progress =
                                          animationController.value;
                                      textColor = Color.lerp(
                                        ColorConstants.main,
                                        ColorConstants.background,
                                        progress,
                                      )!;
                                      // Use a simpler approach for font weight transition
                                      textWeight = progress < 0.5
                                          ? FontWeight.w600
                                          : FontWeight.normal;
                                    }
                                  }

                                  return Center(
                                    child: AutoSizeText(
                                      item.module.name,
                                      style: TextStyle(
                                        color: textColor,
                                        fontSize: 14,
                                        fontWeight: textWeight,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
