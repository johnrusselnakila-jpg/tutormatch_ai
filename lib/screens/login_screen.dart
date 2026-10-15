import 'package:flutter/material.dart';

import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';

/// S-03 Log In: the authentication screen.
///
/// Shows email and password fields and a "Log In" button. No backend call
/// is made yet — the button just shows a placeholder SnackBar.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppTextField(
              label: 'Email',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 12),
            AppTextField(
              label: 'Password',
              obscureText: true,
            ),
            const SizedBox(height: 24),
            AppButton(
              label: 'Log In',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Login placeholder - API not connected yet'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}