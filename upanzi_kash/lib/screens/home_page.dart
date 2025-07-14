import 'package:flutter/material.dart';
import 'package:upanzi_kash/screens/pages/dashboard.dart';
import 'package:upanzi_kash/screens/pages/records.dart';
import 'package:upanzi_kash/screens/pages/tips.dart';
import 'package:upanzi_kash/screens/pages/reports.dart';
import 'package:upanzi_kash/screens/pages/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  String _language = 'en';

  final List<Widget> _pages = [
    const DashboardPage(),
    const RecordsPage(),
    const TipsPage(),
    const ReportsPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF2),
      body: _pages[_currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withOpacity(0.10),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent, // Let container handle color
              selectedItemColor: theme.colorScheme.primary,
              unselectedItemColor: theme.colorScheme.outline,
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              iconSize: 28,
              selectedFontSize: 14,
              unselectedFontSize: 12,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
              unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
              showUnselectedLabels: true,
              elevation: 0,
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.home),
                  label: _language == 'sw' ? 'Nyumbani' : 'Home',
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.assignment),
                  label: _language == 'sw' ? 'Rekodi' : 'Records',
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.lightbulb),
                  label: _language == 'sw' ? 'Vidokezo' : 'Tips',
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.bar_chart),
                  label: _language == 'sw' ? 'Ripoti' : 'Reports',
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.person),
                  label: _language == 'sw' ? 'Wasifu' : 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 