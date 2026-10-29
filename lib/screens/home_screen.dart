// home_screen.dart - Home screen widget. Displays the brand hero, feature cards, and primary call-to-action buttons.
import 'package:flutter/material.dart';
import 'package:tutormatch_ai/widgets/app_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                // Hero section
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 32,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.school_rounded,
                              size: 32,
                              color: Color(0xFF1B7F4B),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'TutorMatch A.I.',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Find your best-matched tutor with K-Nearest Neighbors.',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Feature section title
                const Text(
                  'Why choose TutorMatch?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                // Feature cards
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    _featureCard(context, Icons.rocket_rounded, 'Smart Matching', 'Ranked Top-5 tutors'),
                    _featureCard(context, Icons.event_available_rounded, 'Easy Booking', 'Pick an open time slot'),
                    _featureCard(context, Icons.check_circle_rounded, 'Trusted Tutors', 'Approved by admins'),
                  ],
                ),
                const SizedBox(height: 32),
                // Report an Issue
                AppButton(
                  label: 'Report an Issue',
                  isSecondary: true,
                  onPressed: () {
                    Navigator.pushNamed(context, '/report');
                  },
                ),
                const SizedBox(height: 12),
                // Primary filled button
                AppButton(
                  label: 'Log In',
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                ),
                const SizedBox(height: 12),
                // Outlined sign up button
                AppButton(
                  label: 'Sign Up',
                  isSecondary: true,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Sign up - coming soon'),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
                const Text(
                  'IT 110 - Web Systems and Technologies',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _featureCard(BuildContext context, IconData icon, String title, String subtitle) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFF1B7F4B),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}