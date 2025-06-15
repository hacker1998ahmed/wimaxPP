import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AdvancedSettingsSheet extends StatefulWidget {
  final VoidCallback onClose;
  final Function(Map<String, dynamic>) onSettingsChanged;

  const AdvancedSettingsSheet({
    super.key,
    required this.onClose,
    required this.onSettingsChanged,
  });

  @override
  State<AdvancedSettingsSheet> createState() => _AdvancedSettingsSheetState();
}

class _AdvancedSettingsSheetState extends State<AdvancedSettingsSheet> {
  bool _useGpuAcceleration = false;
  bool _hybridAttack = false;
  bool _customCharset = false;
  String _selectedAttackMode = 'Dictionary';
  double _cpuThreads = 4;
  String _customCharsetValue = '';

  final List<String> _attackModes = [
    'Dictionary',
    'Brute Force',
    'Hybrid (Dictionary + Mask)',
    'Mask Attack',
    'Rule-based',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAttackModeSection(),
                  SizedBox(height: 24),
                  _buildPerformanceSection(),
                  SizedBox(height: 24),
                  _buildCustomizationSection(),
                  SizedBox(height: 24),
                  _buildAdvancedOptionsSection(),
                ],
              ),
            ),
          ),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppTheme.dividerDark),
        ),
      ),
      child: Row(
        children: [
          CustomIconWidget(
            iconName: 'tune',
            color: AppTheme.primaryGreen,
            size: 24,
          ),
          SizedBox(width: 8),
          Text(
            'Advanced Settings',
            style: AppTheme.darkTheme.textTheme.titleLarge,
          ),
          Spacer(),
          IconButton(
            onPressed: widget.onClose,
            icon: CustomIconWidget(
              iconName: 'close',
              color: AppTheme.textSecondary,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttackModeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Attack Mode',
          style: AppTheme.darkTheme.textTheme.titleMedium,
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.backgroundDark,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: _attackModes
                .map((mode) => _buildAttackModeOption(mode))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildAttackModeOption(String mode) {
    final isSelected = _selectedAttackMode == mode;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedAttackMode = mode;
        });
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Row(
          children: [
            CustomIconWidget(
              iconName: isSelected
                  ? 'radio_button_checked'
                  : 'radio_button_unchecked',
              color:
                  isSelected ? AppTheme.primaryGreen : AppTheme.textSecondary,
              size: 20,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                mode,
                style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  color:
                      isSelected ? AppTheme.primaryGreen : AppTheme.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Performance Settings',
          style: AppTheme.darkTheme.textTheme.titleMedium,
        ),
        SizedBox(height: 12),
        _buildSwitchTile(
          'GPU Acceleration',
          'Use GPU for faster password cracking',
          _useGpuAcceleration,
          (value) {
            setState(() {
              _useGpuAcceleration = value;
            });
          },
          'memory',
        ),
        SizedBox(height: 16),
        _buildSliderSetting(
          'CPU Threads',
          'Number of CPU threads to use',
          _cpuThreads,
          1,
          8,
          (value) {
            setState(() {
              _cpuThreads = value;
            });
          },
          'developer_board',
        ),
      ],
    );
  }

  Widget _buildCustomizationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Customization',
          style: AppTheme.darkTheme.textTheme.titleMedium,
        ),
        SizedBox(height: 12),
        _buildSwitchTile(
          'Hybrid Attack',
          'Combine dictionary with brute force',
          _hybridAttack,
          (value) {
            setState(() {
              _hybridAttack = value;
            });
          },
          'merge_type',
        ),
        SizedBox(height: 16),
        _buildSwitchTile(
          'Custom Character Set',
          'Define custom character set for brute force',
          _customCharset,
          (value) {
            setState(() {
              _customCharset = value;
            });
          },
          'text_fields',
        ),
        if (_customCharset) ...[
          SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(
              labelText: 'Character Set',
              hintText: 'abcdefghijklmnopqrstuvwxyz0123456789',
              prefixIcon: CustomIconWidget(
                iconName: 'keyboard',
                color: AppTheme.textSecondary,
                size: 20,
              ),
            ),
            onChanged: (value) {
              _customCharsetValue = value;
            },
          ),
        ],
      ],
    );
  }

  Widget _buildAdvancedOptionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Advanced Options',
          style: AppTheme.darkTheme.textTheme.titleMedium,
        ),
        SizedBox(height: 12),
        _buildAdvancedOption(
          'Session Management',
          'Save and restore crack sessions',
          'save',
          () {},
        ),
        SizedBox(height: 8),
        _buildAdvancedOption(
          'Rule Files',
          'Apply transformation rules to wordlist',
          'rule',
          () {},
        ),
        SizedBox(height: 8),
        _buildAdvancedOption(
          'Mask Templates',
          'Use predefined mask patterns',
          'pattern',
          () {},
        ),
        SizedBox(height: 8),
        _buildAdvancedOption(
          'Thermal Management',
          'Monitor device temperature',
          'thermostat',
          () {},
        ),
      ],
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
    String iconName,
  ) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.backgroundDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          CustomIconWidget(
            iconName: iconName,
            color: value ? AppTheme.primaryGreen : AppTheme.textSecondary,
            size: 24,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTheme.darkTheme.textTheme.titleSmall,
                ),
                Text(
                  subtitle,
                  style: AppTheme.darkTheme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildSliderSetting(
    String title,
    String subtitle,
    double value,
    double min,
    double max,
    Function(double) onChanged,
    String iconName,
  ) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.backgroundDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: iconName,
                color: AppTheme.primaryGreen,
                size: 24,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTheme.darkTheme.textTheme.titleSmall,
                    ),
                    Text(
                      subtitle,
                      style: AppTheme.darkTheme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Text(
                value.round().toString(),
                style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                  color: AppTheme.primaryGreen,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Slider(
            value: value,
            min: min,
            max: max,
            divisions: (max - min).round(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildAdvancedOption(
    String title,
    String subtitle,
    String iconName,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.backgroundDark,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            CustomIconWidget(
              iconName: iconName,
              color: AppTheme.textSecondary,
              size: 24,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.darkTheme.textTheme.titleSmall,
                  ),
                  Text(
                    subtitle,
                    style: AppTheme.darkTheme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            CustomIconWidget(
              iconName: 'chevron_right',
              color: AppTheme.textSecondary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppTheme.dividerDark),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: _resetToDefaults,
              child: Text('Reset to Defaults'),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: _applySettings,
              child: Text('Apply Settings'),
            ),
          ),
        ],
      ),
    );
  }

  void _resetToDefaults() {
    setState(() {
      _useGpuAcceleration = false;
      _hybridAttack = false;
      _customCharset = false;
      _selectedAttackMode = 'Dictionary';
      _cpuThreads = 4;
      _customCharsetValue = '';
    });
  }

  void _applySettings() {
    final settings = {
      'useGpuAcceleration': _useGpuAcceleration,
      'hybridAttack': _hybridAttack,
      'customCharset': _customCharset,
      'attackMode': _selectedAttackMode,
      'cpuThreads': _cpuThreads.round(),
      'customCharsetValue': _customCharsetValue,
    };

    widget.onSettingsChanged(settings);
    widget.onClose();
  }
}
