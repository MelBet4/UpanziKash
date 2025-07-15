import 'package:flutter/material.dart';
import 'package:upanzi_kash/screens/pages/add_income.dart';
import 'package:upanzi_kash/screens/pages/add_expense.dart';
import 'package:upanzi_kash/screens/pages/add_mpesa.dart';
import 'package:upanzi_kash/screens/pages/tips.dart'; // Added import for TipsPage

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HERO SECTION
            _heroSection(context),
            const SizedBox(height: 24),
            // WEATHER CARD
            _weatherCard(context),
            const SizedBox(height: 16),
            // SYNC STATUS CARD
            _syncStatusCard(context),
            const SizedBox(height: 24),
            // QUICK ACTIONS
            Text(
              'Quick Actions',
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _quickActions(context),
          ],
        ),
      ),
    );
  }

  Widget _heroSection(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          colors: [theme.colorScheme.primary.withOpacity(0.95), theme.colorScheme.primary.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(0.10),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Empowering Youth Farmers',
            style: theme.textTheme.headlineMedium?.copyWith(
              color: theme.colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Revolutionizing record keeping and financial management for Kenyan youth farmers.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onPrimary.withOpacity(0.85),
            ),
          ),
          const SizedBox(height: 20),
          // Illustration placeholder
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: Icon(Icons.agriculture, size: 64, color: Colors.white70),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) => Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Choose record type',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ListTile(
                        leading: Icon(Icons.add_circle, color: Colors.green, size: 28),
                        title: const Text('Add Income'),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddIncomePage()));
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.remove_circle, color: Colors.red, size: 28),
                        title: const Text('Add Expense'),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddExpensePage()));
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.phone_android, color: Colors.blue, size: 28),
                        title: const Text('Log M-Pesa'),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddMpesaPage()));
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            },
            icon: const Icon(Icons.add, size: 22),
            label: const Text('Add Record'),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.secondary,
              foregroundColor: theme.colorScheme.onSecondary,
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              textStyle: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              elevation: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _weatherCard(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: theme.colorScheme.primary.withOpacity(0.90),
        border: Border.all(color: theme.colorScheme.secondary, width: 2),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(0.10),
            blurRadius: 10,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.wb_sunny, color: theme.colorScheme.secondary, size: 24),
                const SizedBox(width: 8),
                Text(
                  'Today: 23°C, Partly Cloudy',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              '+2 new records today',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onPrimary.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _syncStatusCard(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: theme.colorScheme.secondary.withOpacity(0.10),
        border: Border.all(color: theme.colorScheme.secondary, width: 1),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.secondary.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          children: [
            Icon(Icons.warning, color: theme.colorScheme.secondary, size: 22),
            const SizedBox(width: 10),
            Text(
              '1 record not synced',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.secondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _quickActions(BuildContext context) {
    final theme = Theme.of(context);
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 18,
      mainAxisSpacing: 18,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.1,
      children: [
        _buildActionCard(
          context,
          icon: Icons.add_circle,
          label: 'Add Income',
          color: Colors.green,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AddIncomePage())),
        ),
        _buildActionCard(
          context,
          icon: Icons.remove_circle,
          label: 'Add Expense',
          color: Colors.red,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AddExpensePage())),
        ),
        _buildActionCard(
          context,
          icon: Icons.phone_android,
          label: 'Log M-Pesa',
          color: Colors.blue,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AddMpesaPage())),
        ),
        _buildActionCard(
          context,
          icon: Icons.lightbulb,
          label: 'Tip of the Day',
          color: Colors.orange,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const TipsPage())),
        ),
      ],
    );
  }

  Widget _buildActionCard(BuildContext context, {required IconData icon, required String label, required Color color, required VoidCallback onTap}) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: theme.colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.10),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 44),
            const SizedBox(height: 14),
            Text(
              label,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 