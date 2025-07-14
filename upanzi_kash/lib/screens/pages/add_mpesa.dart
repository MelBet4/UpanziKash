import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddMpesaPage extends StatefulWidget {
  const AddMpesaPage({super.key});

  @override
  _AddMpesaPageState createState() => _AddMpesaPageState();
}

class _AddMpesaPageState extends State<AddMpesaPage> {
  int _currentPage = 0;
  final _formKey = GlobalKey<FormState>();
  final _amountFormKey = GlobalKey<FormState>();
  
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  
  String _selectedType = '';
  bool _isProcessing = false;
  String _language = 'en';
  DateTime _selectedDate = DateTime.now();

  final List<String> _transactionTypes = [
    'Income',
    'Expense'
  ];

  final List<String> _transactionTypesSwahili = [
    'Mapato',
    'Gharama'
  ];

  @override
  void dispose() {
    _typeController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    _dateController.dispose();
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
        _selectedType = _typeController.text;
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
          'date': _selectedDate.toIso8601String(),
          'isIncome': _selectedType == 'Income' || _selectedType == 'Mapato',
          'category': _typeController.text,
          'amount': double.tryParse(_amountController.text) ?? 0.0,
          'notes': _descriptionController.text,
          'photoPath': '',
          'location': '',
          'isMpesa': true,
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

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = '${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: Text(
          _language == 'sw' ? 'Rekodi M-Pesa' : 'Log M-Pesa',
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
        return _buildTypeForm(theme);
      case 1:
        return _buildDetailsForm(theme);
      case 2:
        return _buildSuccessScreen(theme);
      default:
        return const Center(child: Text('Invalid page'));
    }
  }

  Widget _buildTypeForm(ThemeData theme) {
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
                      Icon(Icons.phone_android, color: theme.colorScheme.secondary, size: 32),
                      const SizedBox(width: 12),
                      Text(
                        _language == 'sw' ? 'Chagua aina ya muamala' : 'Select transaction type',
                        style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  DropdownButtonFormField<String>(
                    value: _selectedType.isEmpty ? null : _selectedType,
                    decoration: InputDecoration(
                      labelText: _language == 'sw' ? 'Aina ya muamala' : 'Transaction Type',
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
                    items: _transactionTypes.asMap().entries.map((entry) {
                      int index = entry.key;
                      String type = entry.value;
                      return DropdownMenuItem(
                        value: type,
                        child: Text(_language == 'sw' ? _transactionTypesSwahili[index] : type),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedType = value ?? '';
                        _typeController.text = value ?? '';
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return _language == 'sw' ? 'Tafadhali chagua aina ya muamala' : 'Please select transaction type';
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

  Widget _buildDetailsForm(ThemeData theme) {
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
                        _language == 'sw' ? 'Weka maelezo' : 'Enter details',
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
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: _language == 'sw' ? 'Maelezo' : 'Description',
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
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _dateController,
                    readOnly: true,
                    onTap: _selectDate,
                    decoration: InputDecoration(
                      labelText: _language == 'sw' ? 'Tarehe' : 'Date',
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
                      suffixIcon: Icon(Icons.calendar_today, color: theme.colorScheme.secondary),
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
              Icon(Icons.check_circle, color: theme.colorScheme.secondary, size: 64),
              const SizedBox(height: 24),
              Text(
                _language == 'sw' ? 'Imefanikiwa!' : 'Success!',
                style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                _language == 'sw' ? 'Muamala umeongezwa.' : 'Transaction has been added.',
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