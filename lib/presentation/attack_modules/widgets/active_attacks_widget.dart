import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class ActiveAttacksWidget extends StatelessWidget {
  final List<Map<String, dynamic>> activeAttacks;
  final Function(String) onStopAttack;

  const ActiveAttacksWidget({
    super.key,
    required this.activeAttacks,
    required this.onStopAttack,
  });

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return AppTheme.successGreen;
      case 'capturing':
        return AppTheme.warningAmber;
      case 'completed':
        return AppTheme.infoBlue;
      case 'failed':
        return AppTheme.errorRed;
      default:
        return AppTheme.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (activeAttacks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: 'security',
              color: AppTheme.textSecondary,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              "No Active Attacks",
              style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Start an attack from the modules tab",
              style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: activeAttacks.length,
      itemBuilder: (context, index) {
        final attack = activeAttacks[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: AppTheme.surfaceDark,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _getStatusColor(attack["status"] as String)
                  .withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: _getStatusColor(attack["status"] as String)
                                .withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CustomIconWidget(
                            iconName: attack["status"] == "active"
                                ? 'play_circle'
                                : 'radio_button_checked',
                            color: _getStatusColor(attack["status"] as String),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                attack["name"] as String,
                                style: AppTheme.darkTheme.textTheme.titleMedium,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Target: ${attack["target"]}",
                                style: AppTheme.darkTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getStatusColor(attack["status"] as String)
                                .withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            (attack["status"] as String).toUpperCase(),
                            style: AppTheme.darkTheme.textTheme.bodySmall
                                ?.copyWith(
                              color:
                                  _getStatusColor(attack["status"] as String),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        CustomIconWidget(
                          iconName: 'schedule',
                          color: AppTheme.textSecondary,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "Started: ${attack["startTime"]}",
                          style:
                              AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          attack["estimatedTime"] as String,
                          style:
                              AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.primaryGreen,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Progress",
                              style: AppTheme.darkTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: AppTheme.textSecondary,
                              ),
                            ),
                            Text(
                              "${((attack["progress"] as double) * 100).toInt()}%",
                              style: AppTheme.darkTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: AppTheme.primaryGreen,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: attack["progress"] as double,
                          backgroundColor: AppTheme.backgroundDark,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            _getStatusColor(attack["status"] as String),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              // View details
                            },
                            icon: CustomIconWidget(
                              iconName: 'visibility',
                              color: AppTheme.infoBlue,
                              size: 16,
                            ),
                            label: const Text("View Details"),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppTheme.infoBlue,
                              side: BorderSide(color: AppTheme.infoBlue),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () =>
                                onStopAttack(attack["id"] as String),
                            icon: CustomIconWidget(
                              iconName: 'stop',
                              color: AppTheme.backgroundDark,
                              size: 16,
                            ),
                            label: const Text("Stop"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.errorRed,
                              foregroundColor: AppTheme.backgroundDark,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
