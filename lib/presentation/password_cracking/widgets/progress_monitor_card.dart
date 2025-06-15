import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class ProgressMonitorCard extends StatelessWidget {
  final double progress;
  final String currentPassword;
  final int keysPerSecond;
  final String estimatedTime;

  const ProgressMonitorCard({
    super.key,
    required this.progress,
    required this.currentPassword,
    required this.keysPerSecond,
    required this.estimatedTime,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppTheme.surfaceDark,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomIconWidget(
                  iconName: 'trending_up',
                  color: AppTheme.primaryGreen,
                  size: 24,
                ),
                SizedBox(width: 8),
                Text(
                  'Crack Progress',
                  style: AppTheme.darkTheme.textTheme.titleMedium,
                ),
                Spacer(),
                Text(
                  '${progress.toStringAsFixed(1)}%',
                  style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.primaryGreen,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildProgressBar(),
            SizedBox(height: 16),
            _buildCurrentAttempt(),
            SizedBox(height: 16),
            _buildStatistics(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Column(
      children: [
        LinearProgressIndicator(
          value: progress / 100,
          backgroundColor: AppTheme.backgroundDark,
          valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryGreen),
          minHeight: 8,
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '0%',
              style: AppTheme.darkTheme.textTheme.bodySmall,
            ),
            Text(
              '50%',
              style: AppTheme.darkTheme.textTheme.bodySmall,
            ),
            Text(
              '100%',
              style: AppTheme.darkTheme.textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCurrentAttempt() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.backgroundDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Current Password Attempt',
            style: AppTheme.darkTheme.textTheme.bodySmall,
          ),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.surfaceDark,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                  color: AppTheme.primaryGreen.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    currentPassword,
                    style: AppTheme.monospaceLarge.copyWith(
                      color: AppTheme.primaryGreen,
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppTheme.primaryGreen),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatistics() {
    return Row(
      children: [
        Expanded(
          child: _buildStatItem(
            'Speed',
            '${_formatNumber(keysPerSecond)} k/s',
            'speed',
            AppTheme.infoBlue,
          ),
        ),
        Expanded(
          child: _buildStatItem(
            'ETA',
            estimatedTime,
            'schedule',
            AppTheme.warningAmber,
          ),
        ),
        Expanded(
          child: _buildStatItem(
            'Tested',
            _formatNumber((progress * 14344391 / 100).round()),
            'fact_check',
            AppTheme.successGreen,
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(
      String label, String value, String iconName, Color color) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          CustomIconWidget(
            iconName: iconName,
            color: color,
            size: 20,
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: AppTheme.darkTheme.textTheme.bodySmall,
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }
}
