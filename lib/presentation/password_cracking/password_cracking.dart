import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import './widgets/advanced_settings_sheet.dart';
import './widgets/crack_history_card.dart';
import './widgets/crack_session_card.dart';
import './widgets/handshake_file_card.dart';
import './widgets/progress_monitor_card.dart';
import './widgets/wordlist_selector_card.dart';

class PasswordCracking extends StatefulWidget {
  const PasswordCracking({super.key});

  @override
  State<PasswordCracking> createState() => _PasswordCrackingState();
}

class _PasswordCrackingState extends State<PasswordCracking>
    with TickerProviderStateMixin {
  bool _isCrackingActive = false;
  bool _isPaused = false;
  String _selectedPriority = 'Normal';
  String _selectedWordlist = 'rockyou.txt';
  double _crackProgress = 0.0;
  String _currentPassword = '';
  int _keysPerSecond = 0;
  String _estimatedTime = '00:00:00';
  String _discoveredPassword = '';
  bool _showAdvancedSettings = false;

  // Mock data for crack sessions
  final List<Map<String, dynamic>> _crackSessions = [
    {
      "id": 1,
      "networkName": "HomeWiFi_5G",
      "bssid": "AA:BB:CC:DD:EE:FF",
      "encryption": "WPA2-PSK",
      "signalStrength": -45,
      "status": "active",
      "startTime": DateTime.now().subtract(Duration(minutes: 15)),
      "handshakeFile": "homewifi_handshake.cap",
      "wordlistUsed": "rockyou.txt",
      "progress": 23.5,
      "keysPerSecond": 1250,
      "estimatedCompletion": "02:45:30"
    },
    {
      "id": 2,
      "networkName": "OfficeNet",
      "bssid": "11:22:33:44:55:66",
      "encryption": "WPA3-SAE",
      "signalStrength": -62,
      "status": "completed",
      "startTime": DateTime.now().subtract(Duration(hours: 2)),
      "handshakeFile": "office_handshake.cap",
      "wordlistUsed": "custom_passwords.txt",
      "progress": 100.0,
      "discoveredPassword": "P@ssw0rd123!",
      "completionTime": "01:23:45"
    }
  ];

  final List<Map<String, dynamic>> _wordlists = [
    {
      "name": "rockyou.txt",
      "size": "133 MB",
      "wordCount": "14,344,391",
      "type": "built-in",
      "description": "Most common passwords from data breaches"
    },
    {
      "name": "common-passwords.txt",
      "size": "2.1 MB",
      "wordCount": "100,000",
      "type": "built-in",
      "description": "Top 100k most common passwords"
    },
    {
      "name": "custom_wordlist.txt",
      "size": "45 MB",
      "wordCount": "2,500,000",
      "type": "custom",
      "description": "User uploaded custom wordlist"
    }
  ];

  final List<Map<String, dynamic>> _crackHistory = [
    {
      "networkName": "TestNetwork",
      "date": DateTime.now().subtract(Duration(days: 1)),
      "status": "success",
      "duration": "00:45:23",
      "wordlistUsed": "rockyou.txt",
      "passwordFound": "password123"
    },
    {
      "networkName": "SecureWiFi",
      "date": DateTime.now().subtract(Duration(days: 3)),
      "status": "failed",
      "duration": "04:30:00",
      "wordlistUsed": "common-passwords.txt",
      "passwordFound": null
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(),
      bottomSheet: _showAdvancedSettings ? _buildAdvancedSettingsSheet() : null,
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppTheme.backgroundDark,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: CustomIconWidget(
          iconName: 'arrow_back',
          color: AppTheme.textPrimary,
          size: 24,
        ),
      ),
      title: Text(
        'Password Cracking',
        style: AppTheme.darkTheme.textTheme.titleLarge,
      ),
      actions: [
        if (_isCrackingActive) ...[
          IconButton(
            onPressed: _togglePause,
            icon: CustomIconWidget(
              iconName: _isPaused ? 'play_arrow' : 'pause',
              color: AppTheme.primaryGreen,
              size: 24,
            ),
          ),
          PopupMenuButton<String>(
            icon: CustomIconWidget(
              iconName: 'tune',
              color: AppTheme.textSecondary,
              size: 24,
            ),
            onSelected: (value) {
              setState(() {
                _selectedPriority = value;
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'Low', child: Text('Low Priority')),
              PopupMenuItem(value: 'Normal', child: Text('Normal Priority')),
              PopupMenuItem(value: 'High', child: Text('High Priority')),
            ],
          ),
        ],
        IconButton(
          onPressed: () {
            setState(() {
              _showAdvancedSettings = !_showAdvancedSettings;
            });
          },
          icon: CustomIconWidget(
            iconName: 'settings',
            color: AppTheme.textSecondary,
            size: 24,
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_isCrackingActive) ...[
            CrackSessionCard(
              session: _crackSessions.first,
              onPause: _togglePause,
              onStop: _stopCracking,
            ),
            SizedBox(height: 16),
            ProgressMonitorCard(
              progress: _crackProgress,
              currentPassword: _currentPassword,
              keysPerSecond: _keysPerSecond,
              estimatedTime: _estimatedTime,
            ),
            SizedBox(height: 16),
          ],

          if (_discoveredPassword.isNotEmpty) ...[
            _buildSuccessCard(),
            SizedBox(height: 16),
          ],

          HandshakeFileCard(
            handshakeFile: _crackSessions.first,
            onReanalyze: _reanalyzeHandshake,
          ),
          SizedBox(height: 16),

          WordlistSelectorCard(
            wordlists: _wordlists,
            selectedWordlist: _selectedWordlist,
            onWordlistSelected: (wordlist) {
              setState(() {
                _selectedWordlist = wordlist;
              });
            },
            onManageWordlist: _showWordlistManagement,
          ),
          SizedBox(height: 16),

          CrackHistoryCard(
            history: _crackHistory,
            onViewDetails: _viewHistoryDetails,
          ),
          SizedBox(height: 16),

          _buildActionButtons(),
          SizedBox(height: 100), // Space for floating action button
        ],
      ),
    );
  }

  Widget _buildSuccessCard() {
    return Card(
      color: AppTheme.successGreen.withValues(alpha: 0.1),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomIconWidget(
                  iconName: 'check_circle',
                  color: AppTheme.successGreen,
                  size: 24,
                ),
                SizedBox(width: 8),
                Text(
                  'Password Cracked Successfully!',
                  style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.successGreen,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.surfaceDark,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.successGreen),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _discoveredPassword,
                      style: AppTheme.monospaceLarge,
                    ),
                  ),
                  IconButton(
                    onPressed: _copyPassword,
                    icon: CustomIconWidget(
                      iconName: 'copy',
                      color: AppTheme.primaryGreen,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _verifyPassword,
                    child: Text('Verify Password'),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _saveToReports,
                    child: Text('Save to Reports'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: _isCrackingActive ? null : _startCracking,
            style: ElevatedButton.styleFrom(
              backgroundColor: _isCrackingActive
                  ? AppTheme.textSecondary
                  : AppTheme.primaryGreen,
            ),
            child: Text(
              _isCrackingActive
                  ? 'Cracking in Progress...'
                  : 'Start Password Crack',
              style: TextStyle(
                color: _isCrackingActive
                    ? AppTheme.backgroundDark
                    : AppTheme.backgroundDark,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        if (_isCrackingActive) ...[
          SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton(
              onPressed: _stopCracking,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppTheme.errorRed),
              ),
              child: Text(
                'Stop Cracking',
                style: TextStyle(color: AppTheme.errorRed),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: _addWordlist,
      backgroundColor: AppTheme.primaryGreen,
      foregroundColor: AppTheme.backgroundDark,
      icon: CustomIconWidget(
        iconName: 'add',
        color: AppTheme.backgroundDark,
        size: 24,
      ),
      label: Text('Add Wordlist'),
    );
  }

  Widget? _buildAdvancedSettingsSheet() {
    return AdvancedSettingsSheet(
      onClose: () {
        setState(() {
          _showAdvancedSettings = false;
        });
      },
      onSettingsChanged: _updateAdvancedSettings,
    );
  }

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _startCracking() {
    setState(() {
      _isCrackingActive = true;
      _crackProgress = 0.0;
      _currentPassword = 'password123';
      _keysPerSecond = 1250;
      _estimatedTime = '02:45:30';
    });

    // Simulate progress
    _simulateProgress();
  }

  void _stopCracking() {
    setState(() {
      _isCrackingActive = false;
      _isPaused = false;
      _crackProgress = 0.0;
    });
  }

  void _simulateProgress() {
    if (!_isCrackingActive || _isPaused) return;

    Future.delayed(Duration(seconds: 1), () {
      if (_isCrackingActive && !_isPaused) {
        setState(() {
          _crackProgress += 0.5;
          _keysPerSecond = 1200 + (DateTime.now().millisecond % 100);

          if (_crackProgress >= 100) {
            _discoveredPassword = 'P@ssw0rd123!';
            _isCrackingActive = false;
          }
        });

        if (_crackProgress < 100) {
          _simulateProgress();
        }
      }
    });
  }

  void _reanalyzeHandshake() {
    // Implement handshake reanalysis
  }

  void _showWordlistManagement(String wordlist) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surfaceDark,
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: CustomIconWidget(
                iconName: 'delete',
                color: AppTheme.errorRed,
                size: 24,
              ),
              title: Text('Delete Wordlist'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'edit',
                color: AppTheme.primaryGreen,
                size: 24,
              ),
              title: Text('Rename Wordlist'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'visibility',
                color: AppTheme.infoBlue,
                size: 24,
              ),
              title: Text('View Sample'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _viewHistoryDetails(Map<String, dynamic> historyItem) {
    // Implement history details view
  }

  void _addWordlist() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surfaceDark,
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add Wordlist',
              style: AppTheme.darkTheme.textTheme.titleLarge,
            ),
            SizedBox(height: 16),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'file_upload',
                color: AppTheme.primaryGreen,
                size: 24,
              ),
              title: Text('Upload Custom File'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'download',
                color: AppTheme.infoBlue,
                size: 24,
              ),
              title: Text('Download from Repository'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _copyPassword() {
    // Implement password copy to clipboard
  }

  void _verifyPassword() {
    // Implement password verification
  }

  void _saveToReports() {
    Navigator.pushNamed(context, '/attack-reports');
  }

  void _updateAdvancedSettings(Map<String, dynamic> settings) {
    // Implement advanced settings update
  }
}
