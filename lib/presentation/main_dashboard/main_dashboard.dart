import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/alert_banner.dart';
import './widgets/dashboard_feature_card.dart';
import './widgets/network_status_header.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  bool _isRefreshing = false;
  bool _showCriticalAlert = true;

  // Mock data for dashboard features
  final List<Map<String, dynamic>> _dashboardFeatures = [
    {
      "id": 1,
      "title": "Network Scan",
      "description": "Discover devices and services on the network",
      "icon": "network_wifi",
      "status": "ready",
      "route": "/network-scanner",
      "isPinned": true,
    },
    {
      "id": 2,
      "title": "Wi-Fi Analysis",
      "description": "Analyze wireless networks and security",
      "icon": "wifi",
      "status": "ready",
      "route": "/network-scanner",
      "isPinned": false,
    },
    {
      "id": 3,
      "title": "Attack Modules",
      "description": "Execute penetration testing attacks",
      "icon": "security",
      "status": "running",
      "route": "/attack-modules",
      "isPinned": true,
    },
    {
      "id": 4,
      "title": "Packet Capture",
      "description": "Monitor and capture network traffic",
      "icon": "analytics",
      "status": "ready",
      "route": "/packet-analysis",
      "isPinned": false,
    },
    {
      "id": 5,
      "title": "Reports",
      "description": "View security assessment reports",
      "icon": "description",
      "status": "ready",
      "route": "/attack-reports",
      "isPinned": false,
    },
    {
      "id": 6,
      "title": "Tools",
      "description": "Manage penetration testing tools",
      "icon": "build",
      "status": "disabled",
      "route": "/attack-modules",
      "isPinned": false,
    },
  ];

  // Mock network status data
  final Map<String, dynamic> _networkStatus = {
    "interface": "wlan0",
    "mode": "Monitor",
    "status": "Connected",
    "ssid": "TestNetwork_5G",
    "signal": -45,
    "encryption": "WPA2",
    "lastUpdate": DateTime.now(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          color: AppTheme.primaryGreen,
          backgroundColor: AppTheme.surfaceDark,
          child: CustomScrollView(
            slivers: [
              // Critical Alert Banner
              if (_showCriticalAlert)
                SliverToBoxAdapter(
                  child: AlertBanner(
                    message: "Root access verified - All tools operational",
                    type: "success",
                    onDismiss: () {
                      setState(() {
                        _showCriticalAlert = false;
                      });
                    },
                  ),
                ),

              // Network Status Header
              SliverToBoxAdapter(
                child: NetworkStatusHeader(
                  networkStatus: _networkStatus,
                  onQuickSettingsTap: _handleQuickSettings,
                ),
              ),

              // Dashboard Title
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  child: Text(
                    "Security Modules",
                    style: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              // Feature Cards Grid
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 3.w,
                    mainAxisSpacing: 2.h,
                    childAspectRatio: 0.85,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final feature = _dashboardFeatures[index];
                      return DashboardFeatureCard(
                        feature: feature,
                        onTap: () => _handleFeatureTap(feature),
                        onLongPress: () => _handleFeatureLongPress(feature),
                      );
                    },
                    childCount: _dashboardFeatures.length,
                  ),
                ),
              ),

              // Bottom spacing
              SliverToBoxAdapter(
                child: SizedBox(height: 10.h),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: _buildEmergencyStopFAB(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppTheme.surfaceDark,
      selectedItemColor: AppTheme.primaryGreen,
      unselectedItemColor: AppTheme.textSecondary,
      elevation: 8,
      onTap: _handleBottomNavTap,
      items: [
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'dashboard',
            color: _currentIndex == 0
                ? AppTheme.primaryGreen
                : AppTheme.textSecondary,
            size: 24,
          ),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'network_wifi',
            color: _currentIndex == 1
                ? AppTheme.primaryGreen
                : AppTheme.textSecondary,
            size: 24,
          ),
          label: 'Networks',
        ),
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'security',
            color: _currentIndex == 2
                ? AppTheme.primaryGreen
                : AppTheme.textSecondary,
            size: 24,
          ),
          label: 'Attacks',
        ),
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'description',
            color: _currentIndex == 3
                ? AppTheme.primaryGreen
                : AppTheme.textSecondary,
            size: 24,
          ),
          label: 'Reports',
        ),
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'settings',
            color: _currentIndex == 4
                ? AppTheme.primaryGreen
                : AppTheme.textSecondary,
            size: 24,
          ),
          label: 'Settings',
        ),
      ],
    );
  }

  Widget _buildEmergencyStopFAB() {
    return FloatingActionButton(
      onPressed: _handleEmergencyStop,
      backgroundColor: AppTheme.errorRed,
      foregroundColor: Colors.white,
      tooltip: 'Emergency Stop All Attacks',
      child: CustomIconWidget(
        iconName: 'stop',
        color: Colors.white,
        size: 28,
      ),
    );
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _isRefreshing = true;
    });

    // Simulate network status update
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isRefreshing = false;
      _networkStatus["lastUpdate"] = DateTime.now();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Network status updated'),
        backgroundColor: AppTheme.successGreen,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleFeatureTap(Map<String, dynamic> feature) {
    final String status = feature["status"] as String;

    if (status == "disabled") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${feature["title"]} is currently disabled'),
          backgroundColor: AppTheme.warningAmber,
        ),
      );
      return;
    }

    final String route = feature["route"] as String;
    Navigator.pushNamed(context, route);
  }

  void _handleFeatureLongPress(Map<String, dynamic> feature) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surfaceDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12.w,
              height: 0.5.h,
              decoration: BoxDecoration(
                color: AppTheme.textSecondary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              feature["title"],
              style: AppTheme.darkTheme.textTheme.titleMedium,
            ),
            SizedBox(height: 2.h),
            ListTile(
              leading: CustomIconWidget(
                iconName:
                    feature["isPinned"] ? 'push_pin' : 'push_pin_outlined',
                color: AppTheme.primaryGreen,
                size: 24,
              ),
              title: Text(
                feature["isPinned"] ? 'Unpin from Top' : 'Pin to Top',
                style: AppTheme.darkTheme.textTheme.bodyMedium,
              ),
              onTap: () {
                Navigator.pop(context);
                _togglePin(feature);
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'history',
                color: AppTheme.primaryGreen,
                size: 24,
              ),
              title: Text(
                'View History',
                style: AppTheme.darkTheme.textTheme.bodyMedium,
              ),
              onTap: () {
                Navigator.pop(context);
                _showHistory(feature);
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'settings',
                color: AppTheme.primaryGreen,
                size: 24,
              ),
              title: Text(
                'Module Settings',
                style: AppTheme.darkTheme.textTheme.bodyMedium,
              ),
              onTap: () {
                Navigator.pop(context);
                _showModuleSettings(feature);
              },
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  void _handleBottomNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        // Already on dashboard
        break;
      case 1:
        Navigator.pushNamed(context, '/network-scanner');
        break;
      case 2:
        Navigator.pushNamed(context, '/attack-modules');
        break;
      case 3:
        Navigator.pushNamed(context, '/attack-reports');
        break;
      case 4:
        // Settings - placeholder
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Settings coming soon'),
            backgroundColor: AppTheme.infoBlue,
          ),
        );
        break;
    }
  }

  void _handleQuickSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceDark,
        title: Text(
          'Quick Settings',
          style: AppTheme.darkTheme.textTheme.titleMedium,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(
              title: Text(
                'Monitor Mode',
                style: AppTheme.darkTheme.textTheme.bodyMedium,
              ),
              subtitle: Text(
                'Enable wireless monitor mode',
                style: AppTheme.darkTheme.textTheme.bodySmall,
              ),
              value: _networkStatus["mode"] == "Monitor",
              onChanged: (value) {
                setState(() {
                  _networkStatus["mode"] = value ? "Monitor" : "Managed";
                });
                Navigator.pop(context);
              },
            ),
            SwitchListTile(
              title: Text(
                'Auto Scan',
                style: AppTheme.darkTheme.textTheme.bodyMedium,
              ),
              subtitle: Text(
                'Automatically scan for networks',
                style: AppTheme.darkTheme.textTheme.bodySmall,
              ),
              value: true,
              onChanged: (value) {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _handleEmergencyStop() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceDark,
        title: Row(
          children: [
            CustomIconWidget(
              iconName: 'warning',
              color: AppTheme.errorRed,
              size: 24,
            ),
            SizedBox(width: 2.w),
            Text(
              'Emergency Stop',
              style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                color: AppTheme.errorRed,
              ),
            ),
          ],
        ),
        content: Text(
          'This will immediately stop all running attacks and monitoring processes. Are you sure?',
          style: AppTheme.darkTheme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _executeEmergencyStop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.errorRed,
              foregroundColor: Colors.white,
            ),
            child: Text('Stop All'),
          ),
        ],
      ),
    );
  }

  void _executeEmergencyStop() {
    // Update all running features to ready status
    setState(() {
      for (var feature in _dashboardFeatures) {
        if (feature["status"] == "running") {
          feature["status"] = "ready";
        }
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('All attacks stopped successfully'),
        backgroundColor: AppTheme.successGreen,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _togglePin(Map<String, dynamic> feature) {
    setState(() {
      feature["isPinned"] = !(feature["isPinned"] as bool);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          feature["isPinned"]
              ? '${feature["title"]} pinned to top'
              : '${feature["title"]} unpinned',
        ),
        backgroundColor: AppTheme.successGreen,
      ),
    );
  }

  void _showHistory(Map<String, dynamic> feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${feature["title"]} history - Feature coming soon'),
        backgroundColor: AppTheme.infoBlue,
      ),
    );
  }

  void _showModuleSettings(Map<String, dynamic> feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${feature["title"]} settings - Feature coming soon'),
        backgroundColor: AppTheme.infoBlue,
      ),
    );
  }
}
