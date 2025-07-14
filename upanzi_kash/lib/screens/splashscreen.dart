import 'package:flutter/material.dart';
import 'package:upanzi_kash/screens/home_page.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF2E7D32),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _topImageSection(),
            const SizedBox(height: 24),
            _middleScreenText(),
            const SizedBox(height: 32),
            _splashButton(context),
          ],
        ),
      ),
    );
  }
}

Widget _topImageSection() {
  return Container(
    padding: const EdgeInsets.all(16.0),
    child: Center(
      child: Icon(
        Icons.agriculture,
        size: 120,
        color: const Color(0xFFFF8F00),
      ),
    ),
  );
}

Widget _middleScreenText() {
  return const Column(
    children: [
      Text(
        "UpanziKash",
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      SizedBox(height: 10),
      Text(
        "Record Keeper for Youth Farmers in Kenya",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          color: Colors.white70,
        ),
      ),
      SizedBox(height: 8),
      Text(
        "Rekodi ya Wakulima Vijana Kenya",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          color: Colors.white60,
          fontStyle: FontStyle.italic,
        ),
      ),
    ],
  );
}

Widget _splashButton(BuildContext context) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFFF8F00),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
    ),
    onPressed: () async {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );
      await Future.delayed(const Duration(seconds: 2));
      Navigator.of(context).pop(); // Remove loading
      Navigator.of(context).pushReplacementNamed('/'); // Go to app root
    },
    child: const Text(
      "Karibu / Welcome",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  );
} 