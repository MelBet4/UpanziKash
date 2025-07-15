import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:upanzi_kash/screens/splashscreen.dart';
import 'package:upanzi_kash/screens/pages/login_page.dart';
import 'package:upanzi_kash/screens/pages/signup_page.dart';
import 'package:upanzi_kash/screens/home_page.dart';
import 'package:upanzi_kash/theme/app_theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const UpanziKash());
}

class UpanziKash extends StatefulWidget {
  const UpanziKash({super.key});

  @override
  State<UpanziKash> createState() => _UpanziKashState();
}

class _UpanziKashState extends State<UpanziKash> {
  bool showLogin = true;
  bool showSplash = true;

  void toggleAuthPage() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  void dismissSplash() {
    setState(() {
      showSplash = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UpanziKash',
      theme: UpanziKashTheme.lightTheme,
      darkTheme: UpanziKashTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: showSplash
          ? Splashscreen(onContinue: dismissSplash)
          : StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData) {
                  return const HomePage();
                }
                return showLogin
                    ? LoginPage(onSignupTap: toggleAuthPage)
                    : SignupPage(onLoginTap: toggleAuthPage);
              },
            ),
    );
  }
}
