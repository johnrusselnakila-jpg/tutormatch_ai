import 'package:flutter/material.dart';

/// Reusable elevated button used across the app.
///
/// Takes a [label] and an [onPressed] callback. The button is always at
/// least 44 px tall for touch accessibility.
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const AppButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(44),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      child: Text(label),
    );
  }
}