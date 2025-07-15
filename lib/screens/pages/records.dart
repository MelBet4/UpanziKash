import 'package:flutter/material.dart';
import 'package:upanzi_kash/classes/farm_transaction.dart';
import 'package:upanzi_kash/screens/pages/add_income.dart';
import 'package:upanzi_kash/screens/pages/add_expense.dart';
import 'package:upanzi_kash/screens/pages/add_mpesa.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecordsPage extends StatefulWidget {
  const RecordsPage({super.key});

  @override
  _RecordsPageState createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  List<FarmTransaction> _transactions = [];
  String _selectedFilter = 'all';
  String _language = 'en';

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  void _loadTransactions() {
    // TODO: Load transactions from Hive
    setState(() {
      _transactions = [
        FarmTransaction(
          id: '1',
          date: DateTime.now().subtract(const Duration(days: 1)),
          isIncome: true,
          category: 'Crop',
          amount: 5000.0,
          notes: 'Sold maize',
          photoPath: '',
          location: 'Nakuru',
          isMpesa: true,
          createdAt: DateTime.now(),
        ),
        FarmTransaction(
          id: '2',
          date: DateTime.now().subtract(const Duration(days: 2)),
          isIncome: false,
          category: 'Seeds',
          amount: 1500.0,
          notes: 'Bought fertilizer',
          photoPath: '',
          location: 'Nakuru',
          isMpesa: false,
          createdAt: DateTime.now(),
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF2),
      appBar: AppBar(
        title: Text(
          _language == 'sw' ? 'Rekodi' : 'Records',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF2E7D32),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onSelected: (value) {
              setState(() {
                _selectedFilter = value;
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'all',
                child: Text(_language == 'sw' ? 'Zote' : 'All'),
              ),
              PopupMenuItem(
                value: 'income',
                child: Text(_language == 'sw' ? 'Mapato' : 'Income'),
              ),
              PopupMenuItem(
                value: 'expense',
                child: Text(_language == 'sw' ? 'Gharama' : 'Expense'),
              ),
            ],
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
            return _emptyState();
          }
          final docs = snapshot.data!.docs;
          final transactions = docs.map((doc) => FarmTransaction.fromMap(doc.data() as Map<String, dynamic>)).toList();
          final filteredTransactions = transactions.where((transaction) {
            if (_selectedFilter == 'income') return transaction.isIncome;
            if (_selectedFilter == 'expense') return !transaction.isIncome;
            return true;
          }).toList();
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: filteredTransactions.length,
            itemBuilder: (context, index) {
              final transaction = filteredTransactions[index];
              return _transactionCard(transaction);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddOptions,
        backgroundColor: const Color(0xFFFF8F00),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _filterChips() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _buildFilterChip('all', _language == 'sw' ? 'Zote' : 'All'),
          const SizedBox(width: 8),
          _buildFilterChip('income', _language == 'sw' ? 'Mapato' : 'Income'),
          const SizedBox(width: 8),
          _buildFilterChip('expense', _language == 'sw' ? 'Gharama' : 'Expense'),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String value, String label) {
    final isSelected = _selectedFilter == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = value;
        });
      },
      backgroundColor: Colors.white,
      selectedColor: const Color(0xFF2E7D32),
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : const Color(0xFF3E2723),
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.assignment,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            _language == 'sw' ? 'Hakuna rekodi bado' : 'No records yet',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _language == 'sw' ? 'Bofya + kuongeza rekodi mpya' : 'Tap + to add a new record',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _transactionsList() {
    final filteredTransactions = _transactions.where((transaction) {
      if (_selectedFilter == 'income') return transaction.isIncome;
      if (_selectedFilter == 'expense') return !transaction.isIncome;
      return true;
    }).toList();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredTransactions.length,
      itemBuilder: (context, index) {
        final transaction = filteredTransactions[index];
        return _transactionCard(transaction);
      },
    );
  }

  Widget _transactionCard(FarmTransaction transaction) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: transaction.isIncome ? Colors.green : Colors.red,
          child: Icon(
            transaction.isIncome ? Icons.add : Icons.remove,
            color: Colors.white,
          ),
        ),
        title: Text(
          transaction.category,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(transaction.notes),
            Text(
              '${transaction.date.day}/${transaction.date.month}/${transaction.date.year}',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'KES ${transaction.amount.toStringAsFixed(0)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: transaction.isIncome ? Colors.green : Colors.red,
              ),
            ),
            if (transaction.isMpesa)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'M-Pesa',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
          ],
        ),
        onTap: () {
          // TODO: Navigate to edit transaction
        },
      ),
    );
  }

  void _showAddOptions() {
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
            Text(
              _language == 'sw' ? 'Chagua aina ya rekodi' : 'Choose record type',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _addOptionTile(
              Icons.add_circle,
              _language == 'sw' ? 'Ongeza Mapato' : 'Add Income',
              Colors.green,
              () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AddIncomePage()));
              },
            ),
            _addOptionTile(
              Icons.remove_circle,
              _language == 'sw' ? 'Ongeza Gharama' : 'Add Expense',
              Colors.red,
              () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AddExpensePage()));
              },
            ),
            _addOptionTile(
              Icons.phone_android,
              _language == 'sw' ? 'Rekodi M-Pesa' : 'Log M-Pesa',
              Colors.blue,
              () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AddMpesaPage()));
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _addOptionTile(IconData icon, String title, Color color, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: color, size: 28),
      title: Text(title),
      onTap: onTap,
    );
  }
} 