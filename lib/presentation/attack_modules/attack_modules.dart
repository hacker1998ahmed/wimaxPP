import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/active_attacks_widget.dart';
import './widgets/attack_category_widget.dart';

class AttackModules extends StatefulWidget {
  const AttackModules({super.key});

  @override
  State<AttackModules> createState() => _AttackModulesState();
}

class _AttackModulesState extends State<AttackModules>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController;
  String _searchQuery = '';
  bool _isRefreshing = false;

  // Mock data for attack modules
  final List<Map<String, dynamic>> _attackCategories = [
    {
      "id": "wifi",
      "name": "Wi-Fi Attacks",
      "icon": "wifi",
      "description": "Wireless network penetration testing",
      "expanded": true,
      "attacks": [
        {
          "id": "wpa_handshake",
          "name": "WPA Handshake Capture",
          "description": "Capture WPA/WPA2 handshakes for offline cracking",
          "difficulty": "Medium",
          "duration": "5-15 min",
          "status": "ready",
          "prerequisites": ["Monitor mode", "Target network"],
          "popular": true,
          "tools": ["airodump-ng", "tcpdump"],
          "targets": ["WPA/WPA2 networks"]
        },
        {
          "id": "wps_attack",
          "name": "WPS PIN Attack",
          "description": "Brute force WPS PIN using reaver",
          "difficulty": "Easy",
          "duration": "2-8 hours",
          "status": "partial",
          "prerequisites": ["WPS enabled", "Reaver tool"],
          "popular": false,
          "tools": ["reaver", "wash"],
          "targets": ["WPS enabled routers"]
        },
        {
          "id": "pmkid_attack",
          "name": "PMKID Attack",
          "description": "Extract PMKID for hashcat cracking",
          "difficulty": "Hard",
          "duration": "1-3 min",
          "status": "missing",
          "prerequisites": ["hcxdumptool", "Target AP"],
          "popular": true,
          "tools": ["hcxdumptool", "hashcat"],
          "targets": ["Modern routers"]
        }
      ]
    },
    {
      "id": "network",
      "name": "Network Attacks",
      "icon": "router",
      "description": "LAN and network infrastructure attacks",
      "expanded": false,
      "attacks": [
        {
          "id": "arp_spoofing",
          "name": "ARP Spoofing",
          "description": "Man-in-the-middle via ARP table poisoning",
          "difficulty": "Medium",
          "duration": "Continuous",
          "status": "ready",
          "prerequisites": ["Same network", "Root access"],
          "popular": true,
          "tools": ["ettercap", "arpspoof"],
          "targets": ["LAN devices"]
        },
        {
          "id": "dns_spoofing",
          "name": "DNS Hijacking",
          "description": "Redirect DNS queries to malicious servers",
          "difficulty": "Hard",
          "duration": "Continuous",
          "status": "ready",
          "prerequisites": ["MITM position", "DNS server"],
          "popular": true,
          "tools": ["dnsspoof", "ettercap"],
          "targets": ["Network clients"]
        },
        {
          "id": "dhcp_starvation",
          "name": "DHCP Starvation",
          "description": "Exhaust DHCP pool to become rogue server",
          "difficulty": "Medium",
          "duration": "5-10 min",
          "status": "partial",
          "prerequisites": ["Network access", "DHCP server"],
          "popular": false,
          "tools": ["yersinia", "dhcpstarv"],
          "targets": ["DHCP servers"]
        }
      ]
    },
    {
      "id": "traffic",
      "name": "Traffic Analysis",
      "icon": "analytics",
      "description": "Network traffic interception and analysis",
      "expanded": false,
      "attacks": [
        {
          "id": "packet_sniffing",
          "name": "Packet Sniffing",
          "description": "Capture and analyze network packets",
          "difficulty": "Easy",
          "duration": "Continuous",
          "status": "ready",
          "prerequisites": ["Network access", "Promiscuous mode"],
          "popular": true,
          "tools": ["tcpdump", "wireshark"],
          "targets": ["Network traffic"]
        },
        {
          "id": "ssl_strip",
          "name": "SSL Strip",
          "description": "Downgrade HTTPS to HTTP connections",
          "difficulty": "Hard",
          "duration": "Continuous",
          "status": "missing",
          "prerequisites": ["MITM position", "sslstrip"],
          "popular": false,
          "tools": ["sslstrip", "ettercap"],
          "targets": ["HTTPS traffic"]
        },
        {
          "id": "session_hijack",
          "name": "Session Hijacking",
          "description": "Steal and replay session cookies",
          "difficulty": "Hard",
          "duration": "Variable",
          "status": "partial",
          "prerequisites": ["Packet capture", "Session tokens"],
          "popular": false,
          "tools": ["ferret", "hamster"],
          "targets": ["Web sessions"]
        }
      ]
    }
  ];

  final List<Map<String, dynamic>> _activeAttacks = [
    {
      "id": "active_1",
      "name": "WPA Handshake Capture",
      "target": "HomeNetwork_5G",
      "progress": 0.65,
      "status": "capturing",
      "startTime": "14:32",
      "estimatedTime": "3 min remaining"
    },
    {
      "id": "active_2",
      "name": "ARP Spoofing",
      "target": "192.168.1.0/24",
      "progress": 1.0,
      "status": "active",
      "startTime": "14:28",
      "estimatedTime": "Continuous"
    }
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _refreshModules() async {
    setState(() {
      _isRefreshing = true;
    });

    // Simulate refresh delay
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isRefreshing = false;
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
    });
  }

  void _toggleCategory(String categoryId) {
    setState(() {
      final categoryIndex =
          _attackCategories.indexWhere((cat) => cat["id"] == categoryId);
      if (categoryIndex != -1) {
        _attackCategories[categoryIndex]["expanded"] =
            !_attackCategories[categoryIndex]["expanded"];
      }
    });
  }

  void _onAttackTap(Map<String, dynamic> attack) {
    _showAttackDetails(attack);
  }

  void _onAttackLongPress(Map<String, dynamic> attack) {
    _showAttackContextMenu(attack);
  }

  void _showAttackDetails(Map<String, dynamic> attack) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 70.h,
        decoration: BoxDecoration(
          color: AppTheme.darkTheme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: AppTheme.textSecondary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppTheme.getStatusColor(
                                    attack["status"] as String)
                                .withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: CustomIconWidget(
                            iconName: 'security',
                            color: AppTheme.getStatusColor(
                                attack["status"] as String),
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                attack["name"] as String,
                                style: AppTheme.darkTheme.textTheme.titleLarge,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                attack["description"] as String,
                                style: AppTheme.darkTheme.textTheme.bodyMedium
                                    ?.copyWith(
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildDetailSection(
                        "Prerequisites", attack["prerequisites"] as List),
                    const SizedBox(height: 16),
                    _buildDetailSection(
                        "Tools Required", attack["tools"] as List),
                    const SizedBox(height: 16),
                    _buildDetailSection(
                        "Target Types", attack["targets"] as List),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: attack["status"] == "ready"
                                ? () {
                                    Navigator.pop(context);
                                    _startAttack(attack);
                                  }
                                : null,
                            child: Text(attack["status"] == "ready"
                                ? "Start Attack"
                                : "Requirements Missing"),
                          ),
                        ),
                        const SizedBox(width: 12),
                        OutlinedButton(
                          onPressed: () => _addToQueue(attack),
                          child: const Text("Add to Queue"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, List items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTheme.darkTheme.textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: items
              .map((item) => Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppTheme.darkTheme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          color: AppTheme.primaryGreen.withValues(alpha: 0.3)),
                    ),
                    child: Text(
                      item as String,
                      style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.primaryGreen,
                      ),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }

  void _showAttackContextMenu(Map<String, dynamic> attack) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.darkTheme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: AppTheme.textSecondary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          ListTile(
            leading: CustomIconWidget(
              iconName: 'description',
              color: AppTheme.primaryGreen,
              size: 24,
            ),
            title: const Text("View Documentation"),
            onTap: () {
              Navigator.pop(context);
              // Navigate to documentation
            },
          ),
          ListTile(
            leading: CustomIconWidget(
              iconName: 'checklist',
              color: AppTheme.warningAmber,
              size: 24,
            ),
            title: const Text("Check Requirements"),
            onTap: () {
              Navigator.pop(context);
              _checkRequirements(attack);
            },
          ),
          ListTile(
            leading: CustomIconWidget(
              iconName: 'history',
              color: AppTheme.infoBlue,
              size: 24,
            ),
            title: const Text("Attack History"),
            onTap: () {
              Navigator.pop(context);
              // Navigate to attack history
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _startAttack(Map<String, dynamic> attack) {
    // Simulate starting attack
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Starting ${attack["name"]}..."),
        backgroundColor: AppTheme.primaryGreen,
      ),
    );
  }

  void _addToQueue(Map<String, dynamic> attack) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${attack["name"]} added to queue"),
        backgroundColor: AppTheme.infoBlue,
      ),
    );
  }

  void _checkRequirements(Map<String, dynamic> attack) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.darkTheme.colorScheme.surface,
        title: Text("Requirements Check",
            style: AppTheme.darkTheme.textTheme.titleLarge),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Checking prerequisites for ${attack["name"]}...",
                style: AppTheme.darkTheme.textTheme.bodyMedium),
            const SizedBox(height: 16),
            ...(attack["prerequisites"] as List)
                .map((req) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          CustomIconWidget(
                            iconName:
                                req == "Root access" ? 'check_circle' : 'error',
                            color: req == "Root access"
                                ? AppTheme.successGreen
                                : AppTheme.errorRed,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(req as String,
                              style: AppTheme.darkTheme.textTheme.bodySmall),
                        ],
                      ),
                    ))
                ,
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredAttacks() {
    if (_searchQuery.isEmpty) return _attackCategories;

    return _attackCategories
        .map((category) {
          final filteredAttacks = (category["attacks"] as List).where((attack) {
            return (attack["name"] as String)
                    .toLowerCase()
                    .contains(_searchQuery) ||
                (attack["description"] as String)
                    .toLowerCase()
                    .contains(_searchQuery);
          }).toList();

          return {
            ...category,
            "attacks": filteredAttacks,
          };
        })
        .where((category) => (category["attacks"] as List).isNotEmpty)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundDark,
        elevation: 0,
        title: Text(
          "Attack Modules",
          style: AppTheme.darkTheme.textTheme.titleLarge,
        ),
        leading: IconButton(
          onPressed: () => Navigator.pushNamed(context, '/main-dashboard'),
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color: AppTheme.textPrimary,
            size: 24,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/attack-reports'),
            icon: CustomIconWidget(
              iconName: 'assessment',
              color: AppTheme.primaryGreen,
              size: 24,
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              style: AppTheme.darkTheme.textTheme.bodyMedium,
              decoration: InputDecoration(
                hintText: "Search attack modules...",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12),
                  child: CustomIconWidget(
                    iconName: 'search',
                    color: AppTheme.textSecondary,
                    size: 20,
                  ),
                ),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _searchController.clear();
                          _onSearchChanged('');
                        },
                        icon: CustomIconWidget(
                          iconName: 'clear',
                          color: AppTheme.textSecondary,
                          size: 20,
                        ),
                      )
                    : null,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: AppTheme.surfaceDark,
            child: TabBar(
              controller: _tabController,
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconWidget(
                        iconName: 'security',
                        color: AppTheme.primaryGreen,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      const Text("Modules"),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconWidget(
                        iconName: 'play_circle',
                        color: AppTheme.secondaryOrange,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text("Active (${_activeAttacks.length})"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                RefreshIndicator(
                  onRefresh: _refreshModules,
                  color: AppTheme.primaryGreen,
                  backgroundColor: AppTheme.surfaceDark,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _getFilteredAttacks().length,
                    itemBuilder: (context, index) {
                      final category = _getFilteredAttacks()[index];
                      return AttackCategoryWidget(
                        category: category,
                        onToggle: () =>
                            _toggleCategory(category["id"] as String),
                        onAttackTap: _onAttackTap,
                        onAttackLongPress: _onAttackLongPress,
                      );
                    },
                  ),
                ),
                ActiveAttacksWidget(
                  activeAttacks: _activeAttacks,
                  onStopAttack: (attackId) {
                    setState(() {
                      _activeAttacks
                          .removeWhere((attack) => attack["id"] == attackId);
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigate to custom attack builder
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Custom Attack Builder - Coming Soon"),
            ),
          );
        },
        icon: CustomIconWidget(
          iconName: 'add',
          color: AppTheme.backgroundDark,
          size: 24,
        ),
        label: Text(
          "Custom Attack",
          style: AppTheme.darkTheme.textTheme.labelLarge?.copyWith(
            color: AppTheme.backgroundDark,
          ),
        ),
        backgroundColor: AppTheme.primaryGreen,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: AppTheme.surfaceDark,
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () =>
                    Navigator.pushNamed(context, '/network-scanner'),
                icon: CustomIconWidget(
                  iconName: 'radar',
                  color: AppTheme.primaryGreen,
                  size: 20,
                ),
                label: const Text("Network Scanner"),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () =>
                    Navigator.pushNamed(context, '/packet-analysis'),
                icon: CustomIconWidget(
                  iconName: 'analytics',
                  color: AppTheme.infoBlue,
                  size: 20,
                ),
                label: const Text("Packet Analysis"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
