import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class HandshakeFileCard extends StatelessWidget {
  final Map<String, dynamic> handshakeFile;
  final VoidCallback onReanalyze;

  const HandshakeFileCard({
    super.key,
    required this.handshakeFile,
    required this.onReanalyze,
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
                  iconName: 'file_present',
                  color: AppTheme.primaryGreen,
                  size: 24,
                ),
                SizedBox(width: 8),
                Text(
                  'Handshake File',
                  style: AppTheme.darkTheme.textTheme.titleMedium,
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.successGreen.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomIconWidget(
                        iconName: 'check_circle',
                        color: AppTheme.successGreen,
                        size: 12,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Valid',
                        style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.successGreen,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.backgroundDark,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _buildFileInfo('Filename', handshakeFile["handshakeFile"]),
                  SizedBox(height: 8),
                  _buildFileInfo('Network', handshakeFile["networkName"]),
                  SizedBox(height: 8),
                  _buildFileInfo('BSSID', handshakeFile["bssid"]),
                  SizedBox(height: 8),
                  _buildFileInfo(
                      'Captured', _formatTimestamp(handshakeFile["startTime"])),
                  SizedBox(height: 8),
                  _buildFileInfo('Encryption', handshakeFile["encryption"]),
                ],
              ),
            ),
            SizedBox(height: 16),
            _buildHandshakeDetails(),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onReanalyze,
                    icon: CustomIconWidget(
                      iconName: 'refresh',
                      color: AppTheme.primaryGreen,
                      size: 16,
                    ),
                    label: Text('Re-analyze'),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _viewHandshakeDetails,
                    icon: CustomIconWidget(
                      iconName: 'visibility',
                      color: AppTheme.infoBlue,
                      size: 16,
                    ),
                    label: Text('View Details'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.infoBlue,
                      side: BorderSide(color: AppTheme.infoBlue),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFileInfo(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            '$label:',
            style: AppTheme.darkTheme.textTheme.bodySmall,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: AppTheme.darkTheme.textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  Widget _buildHandshakeDetails() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.primaryGreen.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.primaryGreen.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'security',
                color: AppTheme.primaryGreen,
                size: 16,
              ),
              SizedBox(width: 8),
              Text(
                'Handshake Validation',
                style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                  color: AppTheme.primaryGreen,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildValidationItem('4-Way Handshake', true),
              ),
              Expanded(
                child: _buildValidationItem('EAPOL Frames', true),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildValidationItem('Client MAC', true),
              ),
              Expanded(
                child: _buildValidationItem('Nonce Values', true),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildValidationItem(String label, bool isValid) {
    return Row(
      children: [
        CustomIconWidget(
          iconName: isValid ? 'check' : 'close',
          color: isValid ? AppTheme.successGreen : AppTheme.errorRed,
          size: 12,
        ),
        SizedBox(width: 4),
        Text(
          label,
          style: AppTheme.darkTheme.textTheme.bodySmall,
        ),
      ],
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    return '${timestamp.day}/${timestamp.month}/${timestamp.year} ${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
  }

  void _viewHandshakeDetails() {
    // Implement handshake details view
  }
}
