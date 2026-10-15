import 'package:flutter/material.dart';

import '../../widgets/app_button.dart';

/// S-01 Home: the first screen shown to the user.
///
/// Displays the app title in the AppBar, a short intro line about the
/// K-Nearest Neighbors matching engine, and an "Open Login" button that
/// navigates to the login route ('/login').
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TutorMatch A.I.'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Find your best-matched tutor with K-Nearest Neighbors',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            AppButton(
              label: 'Open Login',
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}