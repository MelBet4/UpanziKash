import 'package:flutter/material.dart';
import 'package:upanzi_kash/classes/farm_transaction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  List<FarmTransaction> _transactions = [];
  String _selectedPeriod = 'month';
  String _language = 'en';

  final List<String> _periods = [
    'week',
    'month',
    'year'
  ];

  final List<String> _periodsSwahili = [
    'wiki',
    'mwezi',
    'mwaka'
  ];

  @override
  void initState() {
    super.initState();
    // _loadTransactions(); // Removed local data loading
  }

  // void _loadTransactions() { // Removed local data loading
  //   // TODO: Load transactions from Hive
  //   setState(() {
  //     _transactions = [
  //       FarmTransaction(
  //         id: '1',
  //         date: DateTime.now().subtract(const Duration(days: 1)),
  //         isIncome: true,
  //         category: 'Crop',
  //         amount: 5000.0,
  //         notes: 'Sold maize',
  //         photoPath: '',
  //         location: 'Nakuru',
  //         isMpesa: true,
  //         createdAt: DateTime.now(),
  //       ),
  //       FarmTransaction(
  //         id: '2',
  //         date: DateTime.now().subtract(const Duration(days: 2)),
  //         isIncome: false,
  //         category: 'Seeds',
  //         amount: 1500.0,
  //         notes: 'Bought fertilizer',
  //         photoPath: '',
  //         location: 'Nakuru',
  //         isMpesa: false,
  //         createdAt: DateTime.now(),
  //       ),
  //       FarmTransaction(
  //         id: '3',
  //         date: DateTime.now().subtract(const Duration(days: 5)),
  //         isIncome: true,
  //         category: 'Dairy',
  //         amount: 3000.0,
  //         notes: 'Sold milk',
  //         photoPath: '',
  //         location: 'Nakuru',
  //         isMpesa: true,
  //         createdAt: DateTime.now(),
  //       ),
  //     ];
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: Text(
          _language == 'sw' ? 'Ripoti' : 'Reports',
          style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.onPrimary),
        ),
        backgroundColor: theme.colorScheme.primary,
        iconTheme: IconThemeData(color: theme.colorScheme.onPrimary),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            color: theme.colorScheme.onPrimary,
            onPressed: _shareReport,
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseAuth.instance.currentUser == null
            ? null
            : FirebaseFirestore.instance
                .collection('transactions')
                .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .orderBy('date', descending: true)
                .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return _emptyState(theme);
          }
          final docs = snapshot.data!.docs;
          final transactions = docs.map((doc) => FarmTransaction.fromMap(doc.data() as Map<String, dynamic>)).toList();
          return _reportsContentWithData(theme, transactions);
        },
      ),
    );
  }

  Widget _periodFilter(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: _periods.asMap().entries.map((entry) {
          int index = entry.key;
          String period = entry.value;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: FilterChip(
                label: Text(_language == 'sw' ? _periodsSwahili[index] : period),
                selected: _selectedPeriod == period,
                onSelected: (selected) {
                  setState(() {
                    _selectedPeriod = period;
                  });
                },
                backgroundColor: theme.colorScheme.surface,
                selectedColor: theme.colorScheme.primary,
                labelStyle: TextStyle(
                  color: _selectedPeriod == period ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                elevation: 2,
                showCheckmark: false,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _emptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bar_chart,
            size: 80,
            color: theme.colorScheme.primary.withOpacity(0.2),
          ),
          const SizedBox(height: 16),
          Text(
            _language == 'sw' ? 'Hakuna ripoti bado' : 'No reports available',
            style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.outline),
          ),
          const SizedBox(height: 8),
          Text(
            _language == 'sw' ? 'Ongeza rekodi kwanza' : 'Add records first',
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.outline),
          ),
        ],
      ),
    );
  }

  Widget _reportsContentWithData(ThemeData theme, List<FarmTransaction> _transactions) {
    final income = _transactions.where((t) => t.isIncome).fold(0.0, (sum, t) => sum + t.amount);
    final expenses = _transactions.where((t) => !t.isIncome).fold(0.0, (sum, t) => sum + t.amount);
    final profit = income - expenses;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _summaryCards(income, expenses, profit, theme),
          const SizedBox(height: 24),
          _incomeVsExpensesChart(income, expenses, theme),
          const SizedBox(height: 24),
          _expenseBreakdown(theme),
          const SizedBox(height: 24),
          _incomeBreakdown(theme),
        ],
      ),
    );
  }

  Widget _summaryCards(double income, double expenses, double profit, ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: _summaryCard(
            _language == 'sw' ? 'Mapato' : 'Income',
            'KES ${income.toStringAsFixed(0)}',
            theme.colorScheme.primary,
            Icons.trending_up,
            theme,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _summaryCard(
            _language == 'sw' ? 'Gharama' : 'Expenses',
            'KES ${expenses.toStringAsFixed(0)}',
            theme.colorScheme.error,
            Icons.trending_down,
            theme,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _summaryCard(
            _language == 'sw' ? 'Faida' : 'Profit',
            'KES ${profit.toStringAsFixed(0)}',
            theme.colorScheme.secondary,
            Icons.savings,
            theme,
          ),
        ),
      ],
    );
  }

  Widget _summaryCard(String label, String value, Color color, IconData icon, ThemeData theme) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: theme.textTheme.headlineSmall?.copyWith(color: color, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.7)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _incomeVsExpensesChart(double income, double expenses, ThemeData theme) {
    // Placeholder for chart
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.bar_chart, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  _language == 'sw' ? 'Mapato vs Gharama' : 'Income vs Expenses',
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: income + expenses == 0 ? 0.5 : income / (income + expenses),
              backgroundColor: theme.colorScheme.surface,
              color: theme.colorScheme.primary,
              minHeight: 16,
              borderRadius: BorderRadius.circular(8),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _language == 'sw' ? 'Mapato' : 'Income',
                  style: theme.textTheme.bodyMedium,
                ),
                Text(
                  _language == 'sw' ? 'Gharama' : 'Expenses',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _expenseBreakdown(ThemeData theme) {
    // Placeholder for breakdown
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.pie_chart, color: theme.colorScheme.error),
                const SizedBox(width: 8),
                Text(
                  _language == 'sw' ? 'Gharama kwa Aina' : 'Expenses by Category',
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              _language == 'sw' ? 'Hakuna data ya gharama.' : 'No expense data.',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _incomeBreakdown(ThemeData theme) {
    // Placeholder for breakdown
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.pie_chart, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  _language == 'sw' ? 'Mapato kwa Aina' : 'Income by Category',
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              _language == 'sw' ? 'Hakuna data ya mapato.' : 'No income data.',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  void _shareReport() {
    // TODO: Implement share functionality
  }
} 