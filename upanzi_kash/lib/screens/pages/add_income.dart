import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddIncomePage extends StatefulWidget {
  const AddIncomePage({super.key});

  @override
  _AddIncomePageState createState() => _AddIncomePageState();
}

class _AddIncomePageState extends State<AddIncomePage> {
  int _currentPage = 0;
  final _formKey = GlobalKey<FormState>();
  final _amountFormKey = GlobalKey<FormState>();
  
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  
  String _selectedCategory = '';
  bool _isProcessing = false;
  String _language = 'en';

  final List<String> _incomeCategories = [
    'Crop',
    'Dairy',
    'Livestock',
    'Other'
  ];

  final List<String> _incomeCategoriesSwahili = [
    'Mazao',
    'Maziwa',
    'Mifugo',
    'Nyingine'
  ];

  @override
  void dispose() {
    _categoryController.dispose();
    _amountController.dispose();
    _notesController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _goToNextPage() {
    setState(() {
      if (_currentPage < 2) {
        _currentPage++;
      }
    });
  }

  void _goToPreviousPage() {
    setState(() {
      if (_currentPage > 0) {
        _currentPage--;
      }
    });
  }

  void _submitDetails() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _selectedCategory = _categoryController.text;
      });
      _goToNextPage();
    }
  }

  void _submitAmount() async {
    if (_amountFormKey.currentState!.validate()) {
      setState(() {
        _isProcessing = true;
      });
      final user = FirebaseAuth.instance.currentUser;
      bool writeComplete = false;
      Future writeFuture = Future.delayed(const Duration(seconds: 5));
      if (user != null) {
        final transaction = {
          'id': DateTime.now().millisecondsSinceEpoch.toString(),
          'date': DateTime.now().toIso8601String(),
          'isIncome': true,
          'category': _categoryController.text,
          'amount': double.tryParse(_amountController.text) ?? 0.0,
          'notes': _notesController.text,
          'photoPath': '',
          'location': _locationController.text,
          'isMpesa': false,
          'isSynced': true,
          'createdAt': DateTime.now().toIso8601String(),
          'userId': user.uid,
        };
        writeFuture = FirebaseFirestore.instance.collection('transactions').add(transaction).then((_) {
          writeComplete = true;
        });
      }
      await Future.any([
        writeFuture,
        Future.delayed(const Duration(seconds: 5)),
      ]);
      setState(() {
        _isProcessing = false;
      });
      if (mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: Text(
          _language == 'sw' ? 'Ongeza Mapato' : 'Add Income',
          style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.onPrimary),
        ),
        backgroundColor: theme.colorScheme.primary,
        iconTheme: IconThemeData(color: theme.colorScheme.onPrimary),
        leading: _currentPage > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _goToPreviousPage,
              )
            : null,
      ),
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: _buildPage(_currentPage, theme),
        ),
      ),
    );
  }

  Widget _buildPage(int page, ThemeData theme) {
    switch (page) {
      case 0:
        return _buildCategoryForm(theme);
      case 1:
        return _buildAmountForm(theme);
      case 2:
        return _buildSuccessScreen(theme);
      default:
        return const Center(child: Text('Invalid page'));
    }
  }

  Widget _buildCategoryForm(ThemeData theme) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.attach_money, color: theme.colorScheme.primary, size: 32),
                      const SizedBox(width: 12),
                      Text(
                        _language == 'sw' ? 'Chagua aina ya mapato' : 'Select income category',
                        style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  DropdownButtonFormField<String>(
                    value: _selectedCategory.isEmpty ? null : _selectedCategory,
                    decoration: InputDecoration(
                      labelText: _language == 'sw' ? 'Aina ya mapato' : 'Income Category',
                      labelStyle: theme.textTheme.bodyMedium,
                      filled: true,
                      fillColor: theme.colorScheme.surface,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: theme.colorScheme.primary),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: theme.colorScheme.secondary),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    dropdownColor: theme.colorScheme.surface,
                    style: theme.textTheme.bodyLarge,
                    items: _incomeCategories.asMap().entries.map((entry) {
                      int index = entry.key;
                      String category = entry.value;
                      return DropdownMenuItem(
                        value: category,
                        child: Text(_language == 'sw' ? _incomeCategoriesSwahili[index] : category),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value ?? '';
                        _categoryController.text = value ?? '';
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return _language == 'sw' ? 'Tafadhali chagua aina ya mapato' : 'Please select income category';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _submitDetails,
                        icon: const Icon(Icons.arrow_forward),
                        label: Text(_language == 'sw' ? 'Endelea' : 'Continue'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: theme.colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                          textStyle: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                          elevation: 6,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAmountForm(ThemeData theme) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _amountFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.edit, color: theme.colorScheme.secondary, size: 32),
                      const SizedBox(width: 12),
                      Text(
                        _language == 'sw' ? 'Weka kiasi' : 'Enter amount',
                        style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: _language == 'sw' ? 'Kiasi' : 'Amount',
                      labelStyle: theme.textTheme.bodyMedium,
                      filled: true,
                      fillColor: theme.colorScheme.surface,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: theme.colorScheme.primary),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: theme.colorScheme.secondary),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return _language == 'sw' ? 'Tafadhali weka kiasi' : 'Please enter amount';
                      }
                      if (double.tryParse(value) == null) {
                        return _language == 'sw' ? 'Kiasi si sahihi' : 'Invalid amount';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _notesController,
                    decoration: InputDecoration(
                      labelText: _language == 'sw' ? 'Maelezo' : 'Notes',
                      labelStyle: theme.textTheme.bodyMedium,
                      filled: true,
                      fillColor: theme.colorScheme.surface,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: theme.colorScheme.primary),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: theme.colorScheme.secondary),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton.icon(
                        onPressed: _goToPreviousPage,
                        icon: const Icon(Icons.arrow_back),
                        label: Text(_language == 'sw' ? 'Rudi' : 'Back'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: theme.colorScheme.primary,
                          side: BorderSide(color: theme.colorScheme.primary, width: 1.5),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          textStyle: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: _isProcessing ? null : _submitAmount,
                        icon: _isProcessing
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Icon(Icons.check),
                        label: Text(_language == 'sw' ? 'Maliza' : 'Finish'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.secondary,
                          foregroundColor: theme.colorScheme.onSecondary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                          textStyle: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                          elevation: 6,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessScreen(ThemeData theme) {
    return Center(
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: theme.colorScheme.primary, size: 64),
              const SizedBox(height: 24),
              Text(
                _language == 'sw' ? 'Imefanikiwa!' : 'Success!',
                style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                _language == 'sw' ? 'Mapato yameongezwa.' : 'Income has been added.',
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.home),
                label: Text(_language == 'sw' ? 'Nyumbani' : 'Home'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                  textStyle: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  elevation: 6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 