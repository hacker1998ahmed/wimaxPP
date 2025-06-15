import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class NetworkStatusHeader extends StatefulWidget {
  final Map<String, dynamic> networkStatus;
  final VoidCallback onQuickSettingsTap;

  const NetworkStatusHeader({
    super.key,
    required this.networkStatus,
    required this.onQuickSettingsTap,
  });

  @override
  State<NetworkStatusHeader> createState() => _NetworkStatusHeaderState();
}

class _NetworkStatusHeaderState extends State<NetworkStatusHeader>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _getConnectionStatusColor().withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Header row
          InkWell(
            onTap: _toggleExpanded,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Row(
                children: [
                  // Status indicator
                  Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: _getConnectionStatusColor().withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CustomIconWidget(
                      iconName: _getStatusIcon(),
                      color: _getConnectionStatusColor(),
                      size: 20,
                    ),
                  ),

                  SizedBox(width: 3.w),

                  // Network info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.networkStatus["interface"] as String,
                          style:
                              AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          '${widget.networkStatus["mode"]} Mode • ${widget.networkStatus["status"]}',
                          style:
                              AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Quick settings button
                  IconButton(
                    onPressed: widget.onQuickSettingsTap,
                    icon: CustomIconWidget(
                      iconName: 'tune',
                      color: AppTheme.primaryGreen,
                      size: 20,
                    ),
                    tooltip: 'Quick Settings',
                  ),

                  // Expand/collapse button
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: CustomIconWidget(
                      iconName: 'expand_more',
                      color: AppTheme.textSecondary,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Expandable content
          AnimatedBuilder(
            animation: _expandAnimation,
            builder: (context, child) {
              return ClipRect(
                child: Align(
                  alignment: Alignment.topCenter,
                  heightFactor: _expandAnimation.value,
                  child: child,
                ),
              );
            },
            child: _buildExpandedContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedContent() {
    return Container(
      padding: EdgeInsets.fromLTRB(4.w, 0, 4.w, 4.w),
      child: Column(
        children: [
          Divider(
            color: AppTheme.dividerDark,
            height: 1,
          ),
          SizedBox(height: 2.h),

          // Network details grid
          Row(
            children: [
              Expanded(
                child: _buildDetailItem(
                  'SSID',
                  widget.networkStatus["ssid"] as String,
                  'wifi',
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: _buildDetailItem(
                  'Signal',
                  '${widget.networkStatus["signal"]} dBm',
                  'signal_cellular_alt',
                ),
              ),
            ],
          ),

          SizedBox(height: 2.h),

          Row(
            children: [
              Expanded(
                child: _buildDetailItem(
                  'Encryption',
                  widget.networkStatus["encryption"] as String,
                  'lock',
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: _buildDetailItem(
                  'Last Update',
                  _formatLastUpdate(),
                  'update',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, String iconName) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.backgroundDark,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.dividerDark,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: iconName,
                color: AppTheme.textSecondary,
                size: 16,
              ),
              SizedBox(width: 2.w),
              Text(
                label,
                style: AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Text(
            value,
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });

    if (_isExpanded) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  Color _getConnectionStatusColor() {
    final String status = widget.networkStatus["status"] as String;
    switch (status.toLowerCase()) {
      case "connected":
        return AppTheme.successGreen;
      case "disconnected":
        return AppTheme.errorRed;
      case "connecting":
        return AppTheme.warningAmber;
      default:
        return AppTheme.textSecondary;
    }
  }

  String _getStatusIcon() {
    final String mode = widget.networkStatus["mode"] as String;
    final String status = widget.networkStatus["status"] as String;

    if (status.toLowerCase() == "disconnected") {
      return "wifi_off";
    }

    if (mode == "Monitor") {
      return "radar";
    }

    return "wifi";
  }

  String _formatLastUpdate() {
    final DateTime lastUpdate = widget.networkStatus["lastUpdate"] as DateTime;
    final Duration difference = DateTime.now().difference(lastUpdate);

    if (difference.inMinutes < 1) {
      return "Just now";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes}m ago";
    } else {
      return "${difference.inHours}h ago";
    }
  }
}
