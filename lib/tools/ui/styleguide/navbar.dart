import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/navigation/class/module.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/providers/path_forwarding_provider.dart';

class FloatingNavbarItem {
  final Function()? onTap;
  final Module module;

  FloatingNavbarItem({this.onTap, required this.module});
}

class FloatingNavbar extends HookConsumerWidget {
  final List<FloatingNavbarItem> items;
  const FloatingNavbar({super.key, required this.items});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pathProvider = ref.watch(pathForwardingProvider);
    final previousIndex = useRef<int>(0);
    final currentState = useState<int>(3);

    final currentPath = pathProvider.path;
    final routeIndex = useState<int>(3);

    useEffect(() {
      if (currentPath.isNotEmpty) {
        String currentPathRoot = "/";
        final parts = currentPath.split('/');
        if (parts.length > 1 && parts[1].isNotEmpty) {
          currentPathRoot = '/${parts[1]}';
        }
        routeIndex.value = items.indexWhere(
          (item) => item.module.root == currentPathRoot,
        );
        if (routeIndex.value < 0 || routeIndex.value >= items.length) {
          routeIndex.value = 3;
        }
      }
      return null;
    }, [currentPath]);

    useEffect(() {
      currentState.value = routeIndex.value;
      previousIndex.value = routeIndex.value;
      return null;
    }, []);

    final borderRadius = 25.0;

    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );

    useEffect(() {
      return () {
        if (animationController.isAnimating) {
          animationController.stop();
        }
      };
    }, []);

    final slideAnimation = useRef<Animation<double>?>(null);
    final itemWidthRef = useRef<double>(0.0);

    useEffect(() {
      if (currentPath.isNotEmpty && routeIndex.value != currentState.value) {
        previousIndex.value = currentState.value;
        currentState.value = routeIndex.value;
      }
      return null;
    }, [currentPath, routeIndex]);

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
      }
      return null;
    }, [currentState.value, itemWidthRef.value]);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Material(
        elevation: 10,
        shadowColor: ColorConstants.main.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(borderRadius),
        color: ColorConstants.main,
        child: Container(
          height: borderRadius * 2,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final availableWidth = constraints.maxWidth;
              final itemWidth = availableWidth / items.length;

              itemWidthRef.value = itemWidth;

              return Stack(
                children: [
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: items.asMap().entries.map((entry) {
                      final index = entry.key;
                      final item = entry.value;
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

                                WidgetsBinding.instance.addPostFrameCallback((
                                  _,
                                ) {
                                  item.onTap?.call();
                                });
                              } else {
                                item.onTap?.call();
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
                                        ? ColorConstants.main
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
                                        ColorConstants.main,
                                        progress,
                                      )!;
                                      textWeight = progress < 0.5
                                          ? FontWeight.normal
                                          : FontWeight.w600;
                                    } else {
                                      final progress =
                                          animationController.value;
                                      textColor = Color.lerp(
                                        ColorConstants.main,
                                        ColorConstants.background,
                                        progress,
                                      )!;
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
