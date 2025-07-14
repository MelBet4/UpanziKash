import 'package:flutter/material.dart';
import 'package:upanzi_kash/classes/farmer_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FarmerProfile? _profile;
  String _language = 'en';
  bool _passcodeEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  void _loadProfile() {
    // TODO: Load profile from Hive
    setState(() {
      _profile = FarmerProfile(
        name: 'Chebet Smith',
        farmName: 'Chebet Farm',
        location: 'Nakuru',
        farmSize: 3.5,
        mainCrops: ['Maize', 'Beans', 'Tomatoes'],
        preferredLanguage: 'en',
        farmingGoal: 'commercial',
        profileImagePath: '',
        farmType: 'mixed',
        createdAt: DateTime.now(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: Text(
          _language == 'sw' ? 'Wasifu' : 'Profile',
          style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.onPrimary),
        ),
        backgroundColor: theme.colorScheme.primary,
        iconTheme: IconThemeData(color: theme.colorScheme.onPrimary),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            color: theme.colorScheme.onPrimary,
            onPressed: _editProfile,
          ),
        ],
      ),
      body: _profile == null
          ? _loadingState(theme)
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _profileHeader(theme),
                  const SizedBox(height: 24),
                  _farmInfo(theme),
                  const SizedBox(height: 24),
                  _settingsSection(theme),
                  const SizedBox(height: 24),
                  _dataSection(theme),
                  const SizedBox(height: 24),
                  _helpSection(theme),
                ],
              ),
            ),
    );
  }

  Widget _loadingState(ThemeData theme) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _profileHeader(ThemeData theme) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: theme.colorScheme.primary,
              child: const Icon(
                Icons.person,
                size: 50,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _profile!.name,
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              _profile!.farmName,
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.outline),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _getFarmingGoalText(_profile!.farmingGoal),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _farmInfo(ThemeData theme) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _language == 'sw' ? 'Maelezo ya Shamba' : 'Farm Information',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _infoRow(theme, _language == 'sw' ? 'Mahali' : 'Location', _profile!.location, Icons.location_on),
            _infoRow(theme, _language == 'sw' ? 'Ukubwa wa Shamba' : 'Farm Size', '${_profile!.farmSize} acres', Icons.agriculture),
            _infoRow(theme, _language == 'sw' ? 'Aina ya Shamba' : 'Farm Type', _getFarmTypeText(_profile!.farmType), Icons.category),
            _infoRow(theme, _language == 'sw' ? 'Mazao Mkuu' : 'Main Crops', _profile!.mainCrops.join(', '), Icons.local_florist),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(ThemeData theme, String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 22),
          const SizedBox(width: 10),
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _settingsSection(ThemeData theme) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _language == 'sw' ? 'Mipangilio' : 'Settings',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              value: _passcodeEnabled,
              onChanged: (val) {
                setState(() {
                  _passcodeEnabled = val;
                });
              },
              title: Text(_language == 'sw' ? 'Weka Passcode' : 'Enable Passcode'),
              activeColor: theme.colorScheme.primary,
              contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: Icon(Icons.language, color: theme.colorScheme.primary),
              title: Text(_language == 'sw' ? 'Badilisha Lugha' : 'Change Language'),
              onTap: () {
                setState(() {
                  _language = _language == 'en' ? 'sw' : 'en';
                });
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            ListTile(
              leading: Icon(Icons.logout, color: theme.colorScheme.error),
              title: Text(_language == 'sw' ? 'Ondoka' : 'Logout', style: TextStyle(color: theme.colorScheme.error)),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dataSection(ThemeData theme) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _language == 'sw' ? 'Data' : 'Data',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.cloud_upload, color: theme.colorScheme.primary),
              title: Text(_language == 'sw' ? 'Hamisha Data' : 'Export Data'),
              onTap: () {},
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            ListTile(
              leading: Icon(Icons.delete, color: theme.colorScheme.error),
              title: Text(_language == 'sw' ? 'Futa Data' : 'Delete Data'),
              onTap: () {},
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _helpSection(ThemeData theme) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _language == 'sw' ? 'Msaada' : 'Help',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.info, color: theme.colorScheme.primary),
              title: Text(_language == 'sw' ? 'Kuhusu UpanziKash' : 'About UpanziKash'),
              onTap: () {},
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            ListTile(
              leading: Icon(Icons.contact_support, color: theme.colorScheme.primary),
              title: Text(_language == 'sw' ? 'Wasiliana Nasi' : 'Contact Us'),
              onTap: () {},
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ],
        ),
      ),
    );
  }

  void _editProfile() {
    // TODO: Implement profile editing
  }

  String _getFarmingGoalText(String goal) {
    if (_language == 'sw') {
      switch (goal) {
        case 'commercial':
          return 'Biashara';
        case 'subsistence':
          return 'Matumizi Binafsi';
        default:
          return 'Nyingine';
      }
    } else {
      switch (goal) {
        case 'commercial':
          return 'Commercial';
        case 'subsistence':
          return 'Subsistence';
        default:
          return 'Other';
      }
    }
  }

  String _getFarmTypeText(String type) {
    if (_language == 'sw') {
      switch (type) {
        case 'mixed':
          return 'Mchanganyiko';
        case 'crop':
          return 'Mazao';
        case 'livestock':
          return 'Mifugo';
        default:
          return 'Nyingine';
      }
    } else {
      switch (type) {
        case 'mixed':
          return 'Mixed';
        case 'crop':
          return 'Crop';
        case 'livestock':
          return 'Livestock';
        default:
          return 'Other';
      }
    }
  }
} 