import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SizedBox(height: 20),
        Text(
          'CREAR CUENTA',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            letterSpacing: 2.0,
            color: Colors.white,
          ),
        ),
        Text(
          'Inicia tu viaje de mantenimiento premium',
          style: TextStyle(color: AppTheme.chromeSilver, fontSize: 13),
        ),
        SizedBox(height: 48),
      ],
    );
  }
}
