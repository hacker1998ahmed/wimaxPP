import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class CrackHistoryCard extends StatelessWidget {
  final List<Map<String, dynamic>> history;
  final Function(Map<String, dynamic>) onViewDetails;

  const CrackHistoryCard({
    super.key,
    required this.history,
    required this.onViewDetails,
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
                  iconName: 'history',
                  color: AppTheme.primaryGreen,
                  size: 24,
                ),
                SizedBox(width: 8),
                Text(
                  'Crack History',
                  style: AppTheme.darkTheme.textTheme.titleMedium,
                ),
                Spacer(),
                TextButton(
                  onPressed: _viewAllHistory,
                  child: Text('View All'),
                ),
              ],
            ),
            SizedBox(height: 16),
            if (history.isEmpty)
              _buildEmptyState()
            else
              ...history.take(3).map((item) => _buildHistoryItem(item)),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          CustomIconWidget(
            iconName: 'history_toggle_off',
            color: AppTheme.textSecondary,
            size: 48,
          ),
          SizedBox(height: 16),
          Text(
            'No crack history available',
            style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Your completed crack attempts will appear here',
            style: AppTheme.darkTheme.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(Map<String, dynamic> item) {
    final isSuccess = item["status"] == "success";

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => onViewDetails(item),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.backgroundDark,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSuccess
                  ? AppTheme.successGreen.withValues(alpha: 0.3)
                  : AppTheme.errorRed.withValues(alpha: 0.3),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color:
                          isSuccess ? AppTheme.successGreen : AppTheme.errorRed,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item["networkName"],
                      style: AppTheme.darkTheme.textTheme.titleSmall,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: isSuccess
                          ? AppTheme.successGreen.withValues(alpha: 0.2)
                          : AppTheme.errorRed.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      isSuccess ? 'SUCCESS' : 'FAILED',
                      style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                        color: isSuccess
                            ? AppTheme.successGreen
                            : AppTheme.errorRed,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _buildHistoryDetail(
                      'Date',
                      _formatDate(item["date"]),
                      'calendar_today',
                    ),
                  ),
                  Expanded(
                    child: _buildHistoryDetail(
                      'Duration',
                      item["duration"],
                      'timer',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _buildHistoryDetail(
                      'Wordlist',
                      item["wordlistUsed"],
                      'list_alt',
                    ),
                  ),
                  if (isSuccess)
                    Expanded(
                      child: _buildPasswordResult(item["passwordFound"]),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryDetail(String label, String value, String iconName) {
    return Row(
      children: [
        CustomIconWidget(
          iconName: iconName,
          color: AppTheme.textSecondary,
          size: 12,
        ),
        SizedBox(width: 4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                  fontSize: 10,
                ),
              ),
              Text(
                value,
                style: AppTheme.darkTheme.textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordResult(String? password) {
    return Row(
      children: [
        CustomIconWidget(
          iconName: 'key',
          color: AppTheme.successGreen,
          size: 12,
        ),
        SizedBox(width: 4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Password',
                style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                  fontSize: 10,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppTheme.successGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  password ?? 'N/A',
                  style: AppTheme.monospaceSmall.copyWith(
                    color: AppTheme.successGreen,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _viewAllHistory() {
    // Implement view all history
  }
}
