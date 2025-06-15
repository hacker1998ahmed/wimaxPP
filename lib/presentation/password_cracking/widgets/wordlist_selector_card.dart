import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class WordlistSelectorCard extends StatelessWidget {
  final List<Map<String, dynamic>> wordlists;
  final String selectedWordlist;
  final Function(String) onWordlistSelected;
  final Function(String) onManageWordlist;

  const WordlistSelectorCard({
    super.key,
    required this.wordlists,
    required this.selectedWordlist,
    required this.onWordlistSelected,
    required this.onManageWordlist,
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
                  iconName: 'list_alt',
                  color: AppTheme.primaryGreen,
                  size: 24,
                ),
                SizedBox(width: 8),
                Text(
                  'Wordlist Selection',
                  style: AppTheme.darkTheme.textTheme.titleMedium,
                ),
                Spacer(),
                TextButton.icon(
                  onPressed: _browseWordlists,
                  icon: CustomIconWidget(
                    iconName: 'folder_open',
                    color: AppTheme.primaryGreen,
                    size: 16,
                  ),
                  label: Text('Browse'),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildSelectedWordlist(),
            SizedBox(height: 16),
            Text(
              'Available Wordlists',
              style: AppTheme.darkTheme.textTheme.titleSmall,
            ),
            SizedBox(height: 8),
            ...wordlists.map((wordlist) => _buildWordlistItem(wordlist)),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedWordlist() {
    final selected = wordlists.firstWhere(
      (w) => w["name"] == selectedWordlist,
      orElse: () => wordlists.first,
    );

    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.primaryGreen.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.primaryGreen),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'check_circle',
                color: AppTheme.primaryGreen,
                size: 16,
              ),
              SizedBox(width: 8),
              Text(
                'Selected: ${selected["name"]}',
                style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                  color: AppTheme.primaryGreen,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            selected["description"],
            style: AppTheme.darkTheme.textTheme.bodySmall,
          ),
          SizedBox(height: 8),
          Row(
            children: [
              _buildWordlistStat('Size', selected["size"]),
              SizedBox(width: 16),
              _buildWordlistStat('Words', selected["wordCount"]),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: selected["type"] == 'built-in'
                      ? AppTheme.infoBlue.withValues(alpha: 0.2)
                      : AppTheme.warningAmber.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  selected["type"].toUpperCase(),
                  style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                    color: selected["type"] == 'built-in'
                        ? AppTheme.infoBlue
                        : AppTheme.warningAmber,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWordlistItem(Map<String, dynamic> wordlist) {
    final isSelected = wordlist["name"] == selectedWordlist;

    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () => onWordlistSelected(wordlist["name"]),
        onLongPress: () => onManageWordlist(wordlist["name"]),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelected
                ? AppTheme.primaryGreen.withValues(alpha: 0.1)
                : AppTheme.backgroundDark,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? AppTheme.primaryGreen : AppTheme.dividerDark,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomIconWidget(
                    iconName: wordlist["type"] == 'built-in'
                        ? 'storage'
                        : 'file_present',
                    color: isSelected
                        ? AppTheme.primaryGreen
                        : AppTheme.textSecondary,
                    size: 16,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      wordlist["name"],
                      style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                        color: isSelected
                            ? AppTheme.primaryGreen
                            : AppTheme.textPrimary,
                      ),
                    ),
                  ),
                  if (isSelected)
                    CustomIconWidget(
                      iconName: 'radio_button_checked',
                      color: AppTheme.primaryGreen,
                      size: 16,
                    )
                  else
                    CustomIconWidget(
                      iconName: 'radio_button_unchecked',
                      color: AppTheme.textSecondary,
                      size: 16,
                    ),
                ],
              ),
              SizedBox(height: 4),
              Text(
                wordlist["description"],
                style: AppTheme.darkTheme.textTheme.bodySmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  _buildWordlistStat('Size', wordlist["size"]),
                  SizedBox(width: 16),
                  _buildWordlistStat('Words', wordlist["wordCount"]),
                  Spacer(),
                  if (wordlist["type"] == 'custom')
                    IconButton(
                      onPressed: () => onManageWordlist(wordlist["name"]),
                      icon: CustomIconWidget(
                        iconName: 'more_vert',
                        color: AppTheme.textSecondary,
                        size: 16,
                      ),
                      constraints: BoxConstraints(minWidth: 24, minHeight: 24),
                      padding: EdgeInsets.zero,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWordlistStat(String label, String value) {
    return Column(
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
          style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  void _browseWordlists() {
    // Implement wordlist browser
  }
}
