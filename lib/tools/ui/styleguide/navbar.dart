import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:titan/tools/constants.dart';

class FloatingNavbarItem {
  final Function()? onTap;
  final String title;

  FloatingNavbarItem({this.onTap, required this.title});
}

class FloatingNavbar extends HookWidget {
  final List<FloatingNavbarItem> items;
  const FloatingNavbar({super.key, required this.items});
  @override
  Widget build(BuildContext context) {
    final currentIndex = useState(0);
    final borderRadius = 25.0;

    // Animation controller for all animations
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );

    // Slide animation reference
    final slideAnimation = useRef<Animation<double>?>(null);

    // Track previous index for animation
    final previousIndex = useRef<int>(
      0,
    ); // Store the latest calculated item width to use in animations
    final itemWidthRef = useRef<double>(0.0);

    // Update animation when index changes - this needs to be in the build method, not in LayoutBuilder
    useEffect(() {
      if (previousIndex.value != currentIndex.value && itemWidthRef.value > 0) {
        // Create tween from previous to current position
        slideAnimation.value =
            Tween<double>(
              begin: previousIndex.value * itemWidthRef.value,
              end: currentIndex.value * itemWidthRef.value,
            ).animate(
              CurvedAnimation(
                parent: animationController,
                curve: Curves.easeOutCubic, // Smoother easing curve
              ),
            );

        // Reset and start animation
        animationController.reset();
        animationController.forward();

        // Store current index as previous for next change
        previousIndex.value = currentIndex.value;
      }
      return null;
    }, [currentIndex.value, itemWidthRef.value]);

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
                          : itemWidth * currentIndex.value;

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
                      final isSelected = index == currentIndex.value;

                      // Use AnimatedBuilder for text color to sync with indicator animation
                      return Expanded(
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(borderRadius),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(borderRadius),
                            onTap: () {
                              item.onTap?.call();
                              currentIndex.value = index;
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
                                      currentIndex.value) {
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
                                        index == currentIndex.value;

                                    if (!isInvolved) {
                                      // Not involved in transition
                                      textColor = ColorConstants.background;
                                      textWeight = FontWeight.normal;
                                    } else if (index == currentIndex.value) {
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
                                    child: Text(
                                      item.title,
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
