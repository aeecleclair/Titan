import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:titan/tools/constants.dart';

class TabNavigation extends HookWidget {
  final int selectedTabIndex;
  final Function(int) onTabChanged;
  final List<String> tabLabels;

  const TabNavigation({
    super.key,
    required this.selectedTabIndex,
    required this.onTabChanged,
    required this.tabLabels,
  });

  @override
  Widget build(BuildContext context) {
    // Track previous and current tab indices
    final previousIndex = useRef<int>(selectedTabIndex);
    final currentState = useState<int>(selectedTabIndex);

    // Update current state when selectedTabIndex changes externally
    useEffect(() {
      currentState.value = selectedTabIndex;
      return null;
    }, [selectedTabIndex]);

    // Main animation controller for sliding effect
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );

    // Clean up animation controller if component is destroyed while animating
    useEffect(() {
      return () {
        if (animationController.isAnimating) {
          animationController.stop();
        }
      };
    }, []);

    // Slide animation reference
    final slideAnimation = useRef<Animation<double>?>(null);
    final itemWidthRef = useRef<double>(0.0);

    // Update animation when tab changes
    useEffect(() {
      if (previousIndex.value != currentState.value && itemWidthRef.value > 0) {
        slideAnimation.value =
            Tween<double>(
              begin: previousIndex.value * itemWidthRef.value,
              end: currentState.value * itemWidthRef.value,
            ).animate(
              CurvedAnimation(
                parent: animationController,
                curve: Curves.easeOutCubic,
              ),
            );
        animationController.reset();
        animationController.forward();
        previousIndex.value = currentState.value;
      }
      return null;
    }, [currentState.value, itemWidthRef.value]);

    final borderRadius = 25.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Material(
        elevation: 10,
        shadowColor: ColorConstants.tertiary.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(borderRadius),
        color: ColorConstants.tertiary,
        child: Container(
          height: borderRadius * 2,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final availableWidth = constraints.maxWidth;
              final itemWidth = availableWidth / tabLabels.length;

              itemWidthRef.value = itemWidth;

              return Stack(
                children: [
                  // Animated sliding indicator
                  AnimatedBuilder(
                    animation: animationController,
                    builder: (context, _) {
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

                  // Tab buttons row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: tabLabels.asMap().entries.map((entry) {
                      final index = entry.key;
                      final label = entry.value;
                      final isSelected = index == currentState.value;

                      return Expanded(
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(borderRadius),
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              if (index != currentState.value) {
                                if (animationController.isAnimating) {
                                  animationController.stop();
                                }

                                previousIndex.value = currentState.value;
                                currentState.value = index;

                                // Notify parent about the tab change
                                WidgetsBinding.instance.addPostFrameCallback((
                                  _,
                                ) {
                                  onTabChanged(index);
                                });
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: AnimatedBuilder(
                                animation: animationController,
                                builder: (context, child) {
                                  Color textColor;
                                  FontWeight textWeight;

                                  if (previousIndex.value ==
                                      currentState.value) {
                                    textColor = isSelected
                                        ? ColorConstants.tertiary
                                        : ColorConstants.background;
                                    textWeight = isSelected
                                        ? FontWeight.w600
                                        : FontWeight.normal;
                                  } else {
                                    bool isInvolved =
                                        index == previousIndex.value ||
                                        index == currentState.value;

                                    if (!isInvolved) {
                                      textColor = ColorConstants.background;
                                      textWeight = FontWeight.normal;
                                    } else if (index == currentState.value) {
                                      final progress =
                                          animationController.value;
                                      textColor = Color.lerp(
                                        ColorConstants.background,
                                        ColorConstants.tertiary,
                                        progress,
                                      )!;
                                      textWeight = progress < 0.5
                                          ? FontWeight.normal
                                          : FontWeight.w600;
                                    } else {
                                      final progress =
                                          animationController.value;
                                      textColor = Color.lerp(
                                        ColorConstants.tertiary,
                                        ColorConstants.background,
                                        progress,
                                      )!;
                                      textWeight = progress < 0.5
                                          ? FontWeight.w600
                                          : FontWeight.normal;
                                    }
                                  }

                                  return Center(
                                    child: Text(
                                      label,
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
