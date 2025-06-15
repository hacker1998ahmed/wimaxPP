import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class AttackCardWidget extends StatelessWidget {
  final Map<String, dynamic> attack;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const AttackCardWidget({
    super.key,
    required this.attack,
    required this.onTap,
    required this.onLongPress,
  });

  Color _getStatusColor(String status) {
    switch (status) {
      case 'ready':
        return AppTheme.successGreen;
      case 'partial':
        return AppTheme.warningAmber;
      case 'missing':
        return AppTheme.errorRed;
      default:
        return AppTheme.textSecondary;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'ready':
        return 'Ready';
      case 'partial':
        return 'Partial';
      case 'missing':
        return 'Missing Tools';
      default:
        return 'Unknown';
    }
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return AppTheme.successGreen;
      case 'medium':
        return AppTheme.warningAmber;
      case 'hard':
        return AppTheme.errorRed;
      default:
        return AppTheme.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPopular = attack["popular"] as bool? ?? false;
    final status = attack["status"] as String;
    final difficulty = attack["difficulty"] as String;

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.backgroundDark,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isPopular
                ? AppTheme.primaryGreen.withValues(alpha: 0.5)
                : AppTheme.dividerDark,
            width: isPopular ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.shadowDark,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            if (isPopular)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen.withValues(alpha: 0.2),
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(11)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomIconWidget(
                      iconName: 'star',
                      color: AppTheme.primaryGreen,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "Popular",
                      style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.primaryGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          attack["name"] as String,
                          style: AppTheme.darkTheme.textTheme.titleMedium
                              ?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getStatusColor(status).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: _getStatusColor(status),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              _getStatusText(status),
                              style: AppTheme.darkTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: _getStatusColor(status),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    attack["description"] as String,
                    style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildInfoChip(
                        icon: 'schedule',
                        label: attack["duration"] as String,
                        color: AppTheme.infoBlue,
                      ),
                      const SizedBox(width: 8),
                      _buildInfoChip(
                        icon: 'trending_up',
                        label: difficulty,
                        color: _getDifficultyColor(difficulty),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: status == 'ready' ? onTap : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: status == 'ready'
                                ? AppTheme.primaryGreen
                                : AppTheme.textSecondary,
                            foregroundColor: AppTheme.backgroundDark,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                          child: Text(
                            status == 'ready' ? "Start" : "Configure",
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppTheme.primaryGreen),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          onPressed: () {
                            // Add to queue functionality
                          },
                          icon: CustomIconWidget(
                            iconName: 'playlist_add',
                            color: AppTheme.primaryGreen,
                            size: 20,
                          ),
                          tooltip: "Add to Queue",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip({
    required String icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomIconWidget(
            iconName: icon,
            color: color,
            size: 14,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
