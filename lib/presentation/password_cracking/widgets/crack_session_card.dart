import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class CrackSessionCard extends StatelessWidget {
  final Map<String, dynamic> session;
  final VoidCallback onPause;
  final VoidCallback onStop;

  const CrackSessionCard({
    super.key,
    required this.session,
    required this.onPause,
    required this.onStop,
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
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: _getStatusColor(session["status"]),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  'Active Crack Session',
                  style: AppTheme.darkTheme.textTheme.titleMedium,
                ),
                Spacer(),
                Text(
                  _formatDuration(
                      DateTime.now().difference(session["startTime"])),
                  style: AppTheme.darkTheme.textTheme.bodySmall,
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildNetworkInfo(),
            SizedBox(height: 16),
            _buildProgressInfo(),
            SizedBox(height: 16),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildNetworkInfo() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.backgroundDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'wifi',
                color: AppTheme.primaryGreen,
                size: 20,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  session["networkName"],
                  style: AppTheme.darkTheme.textTheme.titleSmall,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  session["encryption"],
                  style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.primaryGreen,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text(
                'BSSID: ',
                style: AppTheme.darkTheme.textTheme.bodySmall,
              ),
              Text(
                session["bssid"],
                style: AppTheme.monospaceSmall,
              ),
              Spacer(),
              CustomIconWidget(
                iconName: 'signal_wifi_4_bar',
                color: _getSignalColor(session["signalStrength"]),
                size: 16,
              ),
              SizedBox(width: 4),
              Text(
                '${session["signalStrength"]} dBm',
                style: AppTheme.darkTheme.textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressInfo() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Progress',
                style: AppTheme.darkTheme.textTheme.bodySmall,
              ),
              SizedBox(height: 4),
              Text(
                '${session["progress"].toStringAsFixed(1)}%',
                style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                  color: AppTheme.primaryGreen,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Speed',
                style: AppTheme.darkTheme.textTheme.bodySmall,
              ),
              SizedBox(height: 4),
              Text(
                '${session["keysPerSecond"]} k/s',
                style: AppTheme.darkTheme.textTheme.titleMedium,
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ETA',
                style: AppTheme.darkTheme.textTheme.bodySmall,
              ),
              SizedBox(height: 4),
              Text(
                session["estimatedCompletion"],
                style: AppTheme.darkTheme.textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onPause,
            icon: CustomIconWidget(
              iconName: 'pause',
              color: AppTheme.warningAmber,
              size: 16,
            ),
            label: Text('Pause'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppTheme.warningAmber,
              side: BorderSide(color: AppTheme.warningAmber),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onStop,
            icon: CustomIconWidget(
              iconName: 'stop',
              color: AppTheme.errorRed,
              size: 16,
            ),
            label: Text('Stop'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppTheme.errorRed,
              side: BorderSide(color: AppTheme.errorRed),
            ),
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return AppTheme.primaryGreen;
      case 'paused':
        return AppTheme.warningAmber;
      case 'completed':
        return AppTheme.successGreen;
      case 'failed':
        return AppTheme.errorRed;
      default:
        return AppTheme.textSecondary;
    }
  }

  Color _getSignalColor(int strength) {
    if (strength > -50) return AppTheme.successGreen;
    if (strength > -70) return AppTheme.warningAmber;
    return AppTheme.errorRed;
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }
}
