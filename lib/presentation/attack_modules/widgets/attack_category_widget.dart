import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import './attack_card_widget.dart';

class AttackCategoryWidget extends StatelessWidget {
  final Map<String, dynamic> category;
  final VoidCallback onToggle;
  final Function(Map<String, dynamic>) onAttackTap;
  final Function(Map<String, dynamic>) onAttackLongPress;

  const AttackCategoryWidget({
    super.key,
    required this.category,
    required this.onToggle,
    required this.onAttackTap,
    required this.onAttackLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final attacks = category["attacks"] as List<Map<String, dynamic>>;
    final isExpanded = category["expanded"] as bool;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.primaryGreen.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onToggle,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGreen.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CustomIconWidget(
                      iconName: category["icon"] as String,
                      color: AppTheme.primaryGreen,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category["name"] as String,
                          style: AppTheme.darkTheme.textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          category["description"] as String,
                          style:
                              AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.infoBlue.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "${attacks.length}",
                      style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.infoBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: CustomIconWidget(
                      iconName: 'keyboard_arrow_down',
                      color: AppTheme.textSecondary,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: isExpanded ? null : 0,
            child: isExpanded
                ? Column(
                    children: [
                      Container(
                        height: 1,
                        color: AppTheme.dividerDark,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        itemCount: attacks.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final attack = attacks[index];
                          return AttackCardWidget(
                            attack: attack,
                            onTap: () => onAttackTap(attack),
                            onLongPress: () => onAttackLongPress(attack),
                          );
                        },
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
