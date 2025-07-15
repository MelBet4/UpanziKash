import 'package:flutter/material.dart';
import 'dart:math';

class TipsPage extends StatefulWidget {
  const TipsPage({super.key});

  @override
  _TipsPageState createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {
  String? _dailyTipEn;
  String? _dailyTipSw;
  String _language = 'en';
  String _selectedCategory = 'All';
  final List<String> _categories = ['All', 'Agricultural', 'Financial'];

  final List<Map<String, String>> _localTips = [
    // Agricultural tips
    {
      'en': 'Rotate your crops each season to maintain soil fertility.',
      'sw': 'Badilisha mazao kila msimu ili kudumisha rutuba ya udongo.',
      'category': 'Agricultural',
    },
    {
      'en': 'Use organic compost to enrich your farm soil.',
      'sw': 'Tumia mbolea asilia kuongeza rutuba shambani.',
      'category': 'Agricultural',
    },
    {
      'en': 'Water your crops early in the morning to reduce evaporation.',
      'sw': 'Mwagilia mazao asubuhi mapema kupunguza uvukizaji wa maji.',
      'category': 'Agricultural',
    },
    {
      'en': 'Monitor market prices before selling your produce.',
      'sw': 'Angalia bei za soko kabla ya kuuza mazao yako.',
      'category': 'Agricultural',
    },
    {
      'en': 'Practice pest control using natural methods.',
      'sw': 'Dhibiti wadudu kwa kutumia mbinu asilia.',
      'category': 'Agricultural',
    },
    // Financial tips
    {
      'en': 'Track your daily expenses to better manage your budget.',
      'sw': 'Fuatilia matumizi yako ya kila siku ili kudhibiti bajeti yako.',
      'category': 'Financial',
    },
    {
      'en': 'Save a portion of your income regularly, no matter how small.',
      'sw': 'Weka akiba ya sehemu ya mapato yako mara kwa mara, hata kama ni kidogo.',
      'category': 'Financial',
    },
    {
      'en': 'Compare prices from different suppliers before making large purchases.',
      'sw': 'Linganisha bei kutoka kwa wasambazaji tofauti kabla ya kununua vitu vikubwa.',
      'category': 'Financial',
    },
    {
      'en': 'Invest in farm improvements that increase productivity over time.',
      'sw': 'Wekeza katika kuboresha shamba lako ili kuongeza uzalishaji kwa muda.',
      'category': 'Financial',
    },
    {
      'en': 'Keep financial records for all your farm transactions.',
      'sw': 'Hifadhi kumbukumbu za kifedha kwa miamala yote ya shamba lako.',
      'category': 'Financial',
    },
  ];

  @override
  void initState() {
    super.initState();
    _pickRandomTip();
  }

  void _pickRandomTip() {
    final random = Random();
    final filteredTips = _selectedCategory == 'All'
        ? _localTips
        : _localTips.where((tip) => tip['category'] == _selectedCategory).toList();
    final tip = filteredTips[random.nextInt(filteredTips.length)];
    setState(() {
      _dailyTipEn = tip['en'];
      _dailyTipSw = tip['sw'];
    });
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
            icon: Icon(Icons.language, color: theme.colorScheme.onPrimary),
            onPressed: () {
              setState(() {
                _language = _language == 'en' ? 'sw' : 'en';
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh, color: theme.colorScheme.onPrimary),
            onPressed: _pickRandomTip,
            tooltip: 'New Tip',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _categories.map((cat) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ChoiceChip(
                    label: Text(cat),
                    selected: _selectedCategory == cat,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = cat;
                        _pickRandomTip();
                      });
                    },
                  ),
                )).toList(),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: _dailyTipEn == null
                  ? const CircularProgressIndicator()
                  : Card(
                      margin: const EdgeInsets.all(24),
                      elevation: 8,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.lightbulb, size: 60, color: theme.colorScheme.primary),
                            const SizedBox(height: 16),
                            Text(
                              _language == 'sw' ? _dailyTipSw! : _dailyTipEn!,
                              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
} 