import 'package:flutter/material.dart';

class RegisterBackground extends StatelessWidget {
  const RegisterBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: [
            Color(0xFF1B262C),
            Color(0xFF0F172A),
            Color(0xFF000000),
          ],
        ),
      ),
    );
  }
}
