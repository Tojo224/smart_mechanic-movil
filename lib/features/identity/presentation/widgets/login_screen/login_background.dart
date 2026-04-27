import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';

class LoginBackground extends StatelessWidget {
  const LoginBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Fondo Metálico
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xFF1B262C), Color(0xFF0F172A), Color(0xFF000000)],
            ),
          ),
        ),

        // Elementos de diseño decorativos (Luces de carro)
        Positioned(
          top: -100,
          right: -100,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.electricBlue.withValues(alpha: 0.05),
            ),
          ),
        ),
      ],
    );
  }
}
