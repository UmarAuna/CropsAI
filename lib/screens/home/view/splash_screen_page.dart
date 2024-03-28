import 'package:flutter/material.dart';

class SplashScreenPage extends StatefulWidget {
  static const id = 'splash_screen_page';
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SplashScreenPagePage'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SplashScreenPagePage is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
