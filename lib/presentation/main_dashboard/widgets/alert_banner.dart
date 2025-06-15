import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AlertBanner extends StatelessWidget {
  final String message;
  final String type;
  final VoidCallback? onDismiss;
  final VoidCallback? onAction;
  final String? actionText;

  const AlertBanner({
    super.key,
    required this.message,
    required this.type,
    this.onDismiss,
    this.onAction,
    this.actionText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: _getBannerColor().withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _getBannerColor().withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Alert icon
          CustomIconWidget(
            iconName: _getBannerIcon(),
            color: _getBannerColor(),
            size: 20,
          ),

          SizedBox(width: 3.w),

          // Message
          Expanded(
            child: Text(
              message,
              style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // Action button (if provided)
          if (onAction != null && actionText != null) ...[
            SizedBox(width: 2.w),
            TextButton(
              onPressed: onAction,
              style: TextButton.styleFrom(
                foregroundColor: _getBannerColor(),
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                actionText!,
                style: AppTheme.darkTheme.textTheme.labelMedium?.copyWith(
                  color: _getBannerColor(),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],

          // Dismiss button (if provided)
          if (onDismiss != null) ...[
            SizedBox(width: 2.w),
            IconButton(
              onPressed: onDismiss,
              icon: CustomIconWidget(
                iconName: 'close',
                color: AppTheme.textSecondary,
                size: 18,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(
                minWidth: 32,
                minHeight: 32,
              ),
              tooltip: 'Dismiss',
            ),
          ],
        ],
      ),
    );
  }

  Color _getBannerColor() {
    switch (type.toLowerCase()) {
      case 'error':
      case 'critical':
        return AppTheme.errorRed;
      case 'warning':
        return AppTheme.warningAmber;
      case 'success':
        return AppTheme.successGreen;
      case 'info':
        return AppTheme.infoBlue;
      default:
        return AppTheme.primaryGreen;
    }
  }

  String _getBannerIcon() {
    switch (type.toLowerCase()) {
      case 'error':
      case 'critical':
        return 'error';
      case 'warning':
        return 'warning';
      case 'success':
        return 'check_circle';
      case 'info':
        return 'info';
      default:
        return 'notifications';
    }
  }
}
