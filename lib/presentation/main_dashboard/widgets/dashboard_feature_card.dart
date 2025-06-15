import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class DashboardFeatureCard extends StatelessWidget {
  final Map<String, dynamic> feature;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const DashboardFeatureCard({
    super.key,
    required this.feature,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final String status = feature["status"] as String;
    final bool isPinned = feature["isPinned"] as bool;

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.surfaceDark,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _getStatusBorderColor(status),
            width: status == "running" ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.shadowDark,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Main content
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon and status indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          color: _getStatusColor(status).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: CustomIconWidget(
                          iconName: feature["icon"] as String,
                          color: _getStatusColor(status),
                          size: 24,
                        ),
                      ),
                      _buildStatusIndicator(status),
                    ],
                  ),

                  SizedBox(height: 2.h),

                  // Title
                  Text(
                    feature["title"] as String,
                    style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: 1.h),

                  // Description
                  Expanded(
                    child: Text(
                      feature["description"] as String,
                      style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            // Pin indicator
            if (isPinned)
              Positioned(
                top: 2.w,
                right: 2.w,
                child: Container(
                  padding: EdgeInsets.all(1.w),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGreen,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: CustomIconWidget(
                    iconName: 'push_pin',
                    color: Colors.black,
                    size: 12,
                  ),
                ),
              ),

            // Running animation overlay
            if (status == "running")
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.primaryGreen.withValues(alpha: 0.1),
                        Colors.transparent,
                        AppTheme.primaryGreen.withValues(alpha: 0.1),
                      ],
                      stops: const [0.0, 0.5, 1.0],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(String status) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
      decoration: BoxDecoration(
        color: _getStatusColor(status).withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: _getStatusColor(status),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 1.w),
          Text(
            _getStatusText(status),
            style: AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
              color: _getStatusColor(status),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "running":
        return AppTheme.scanningActive;
      case "ready":
        return AppTheme.successGreen;
      case "disabled":
        return AppTheme.textSecondary;
      default:
        return AppTheme.infoBlue;
    }
  }

  Color _getStatusBorderColor(String status) {
    switch (status) {
      case "running":
        return AppTheme.primaryGreen;
      case "disabled":
        return AppTheme.textSecondary.withValues(alpha: 0.3);
      default:
        return Colors.transparent;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case "running":
        return "Active";
      case "ready":
        return "Ready";
      case "disabled":
        return "Disabled";
      default:
        return "Unknown";
    }
  }
}
