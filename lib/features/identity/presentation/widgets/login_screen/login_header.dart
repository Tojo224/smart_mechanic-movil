import 'package:flutter/material.dart';
import '../../../../../../core/theme/app_theme.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 80),

        // Icono / Logo Moderno
        Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.03),
              shape: BoxShape.circle,
              border: Border.all(
                color: AppTheme.chromeSilver.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            child: const Icon(
              Icons.settings_suggest_rounded,
              size: 64,
              color: AppTheme.chromeSilver,
            ),
          ),
        ),

        const SizedBox(height: 32),
        const Text(
          'SMART MECHANIC',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            letterSpacing: 4.0,
            color: Colors.white,
          ),
        ),
        const Text(
          'EXCELENCIA EN INGENIERÍA',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w300,
            letterSpacing: 2.0,
            color: AppTheme.chromeSilver,
          ),
        ),
      ],
    );
  }
}
