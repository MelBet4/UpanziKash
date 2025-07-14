import 'package:flutter/material.dart';
import 'package:upanzi_kash/classes/farming_tip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!, style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.error)))
              : _dailyTip == null
                  ? _emptyState(theme)
                  : _tipCard(_dailyTip!, theme),
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
} 