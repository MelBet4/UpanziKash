import 'package:flutter/material.dart';
import 'package:upanzi_kash/classes/farming_tip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TipsPage extends StatefulWidget {
  const TipsPage({super.key});

  @override
  _TipsPageState createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {
  FarmingTip? _dailyTip;
  bool _loading = true;
  String? _error;
  String _selectedCategory = 'all';
  String _language = 'en';
  bool _generating = false;
  String? _generateError;
  String? _generateSuccess;

  // Set your admin email here. Only this user will see the Generate AI Tip button.
  final String _adminEmail = 'chebetmelanie4@gmail.com'; 

  final List<String> _categories = [
    'all',
    'Pest Control',
    'Crop Planning',
    'Market Prices',
    'Sustainable Techniques'
  ];

  final List<String> _categoriesSwahili = [
    'zote',
    'Udhibiti wa Wadudu',
    'Mipango ya Mazao',
    'Bei za Soko',
    'Mbinu Endelevu'
  ];

  @override
  void initState() {
    super.initState();
    _fetchDailyTip();
  }

  Future<void> _fetchDailyTip() async {
    setState(() { _loading = true; _error = null; });
    try {
      final query = await FirebaseFirestore.instance
          .collection('tips')
          .orderBy('createdAt', descending: true)
          .limit(1)
          .get();
      if (query.docs.isNotEmpty) {
        final data = query.docs.first.data();
        setState(() {
          _dailyTip = FarmingTip.fromMap(data);
          _loading = false;
        });
      } else {
        setState(() {
          _dailyTip = null;
          _loading = false;
        });
      }
    } catch (e) {
      setState(() { _error = e.toString(); _loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: Text(
          _language == 'sw' ? 'Vidokezo' : 'Tips',
          style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.onPrimary),
        ),
        backgroundColor: theme.colorScheme.primary,
        iconTheme: IconThemeData(color: theme.colorScheme.onPrimary),
        actions: [
          IconButton(
            icon: Icon(
              _language == 'en' ? Icons.language : Icons.language,
              color: theme.colorScheme.onPrimary,
            ),
            onPressed: () {
              setState(() {
                _language = _language == 'en' ? 'sw' : 'en';
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (user != null && user.email == _adminEmail)
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton.icon(
                icon: _generating
                    ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.auto_awesome),
                label: Text(_generating ? 'Generating...' : 'Generate AI Tip'),
                onPressed: _generating ? null : _generateTip,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  textStyle: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  elevation: 4,
                ),
              ),
            ),
          if (_generateError != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(_generateError!, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.error)),
            ),
          if (_generateSuccess != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(_generateSuccess!, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.primary)),
            ),
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : _error != null
                    ? Center(child: Text(_error!, style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.error)))
                    : _dailyTip == null
                        ? _emptyState(theme)
                        : _tipCard(_dailyTip!, theme),
          ),
        ],
      ),
    );
  }

  Widget _categoryFilter(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _categories.asMap().entries.map((entry) {
            int index = entry.key;
            String category = entry.value;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(_language == 'sw' ? _categoriesSwahili[index] : category),
                selected: _selectedCategory == category,
                onSelected: (selected) {
                  setState(() {
                    _selectedCategory = category;
                  });
                },
                backgroundColor: theme.colorScheme.surface,
                selectedColor: theme.colorScheme.primary,
                labelStyle: TextStyle(
                  color: _selectedCategory == category ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                elevation: 2,
                showCheckmark: false,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _emptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.lightbulb,
            size: 80,
            color: theme.colorScheme.primary.withOpacity(0.2),
          ),
          const SizedBox(height: 16),
          Text(
            _language == 'sw' ? 'Hakuna vidokezo bado' : 'No tips available',
            style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.outline),
          ),
        ],
      ),
    );
  }

  Widget _tipCard(FarmingTip tip, ThemeData theme) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primary,
          child: Icon(
            Icons.lightbulb,
            color: theme.colorScheme.onPrimary,
          ),
        ),
        title: Text(
          tip.getTitle(_language),
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              tip.getContent(_language),
              style: theme.textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _generateTip() async {
    setState(() {
      _generating = true;
      _generateError = null;
      _generateSuccess = null;
    });
    try {
      // Set your deployed Vercel endpoint here
      final response = await http.post(
        Uri.parse('https://your-vercel-app.vercel.app/api/generateTip'), // TODO: Set your Vercel endpoint
      );
      if (response.statusCode == 200) {
        final tipText = json.decode(response.body)['tip'];
        await FirebaseFirestore.instance.collection('tips').add({
          'tip': tipText,
          'createdAt': FieldValue.serverTimestamp(),
        });
        setState(() {
          _generateSuccess = 'Tip generated and saved!';
        });
        await _fetchDailyTip();
      } else {
        setState(() {
          _generateError = 'Failed to generate tip (status ${response.statusCode})';
        });
      }
    } catch (e) {
      setState(() {
        _generateError = 'Error: $e';
      });
    } finally {
      setState(() {
        _generating = false;
      });
    }
  }
} 