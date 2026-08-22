import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CategoryCard extends HookConsumerWidget {
  final VoidCallback onTap;
  final String categoryName;
  final double categoryPrice;

  const CategoryCard({
    super.key,
    required this.onTap,
    required this.categoryName,
    required this.categoryPrice,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const BorderRadius radius = BorderRadius.all(Radius.circular(20));
    final bool isFree = categoryPrice <= 0;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: radius,
            boxShadow: const [
              BoxShadow(
                blurRadius: 24,
                offset: Offset(0, 12),
                spreadRadius: -6,
                color: Color(0x1F1E2A78),
              ),
              BoxShadow(
                blurRadius: 4,
                offset: Offset(0, 1),
                color: Color(0x0F000000),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: radius,
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 16, 14, 16),
                child: Row(
                  children: [
                    // Leading icon
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.local_activity_rounded,
                        size: 22,
                        color: Colors.indigo.shade600,
                      ),
                    ),
                    const SizedBox(width: 14),
                    // Title
                    Expanded(
                      child: Text(
                        categoryName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.2,
                          color: Color(0xFF1A1C2E),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Price pill
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isFree
                            ? Colors.green.shade50
                            : Colors.indigo.shade600,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        isFree
                            ? 'Gratuit'
                            : '${(categoryPrice / 100).toStringAsFixed(2)} €',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: isFree ? Colors.green.shade700 : Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
