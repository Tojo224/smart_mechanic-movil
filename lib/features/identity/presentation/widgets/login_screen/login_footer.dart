import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/theme/app_theme.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "¿No tienes una cuenta?",
              style: TextStyle(color: AppTheme.chromeSilver),
            ),
            TextButton(
              onPressed: () => context.push('/register'),
              child: const Text(
                'REGÍSTRATE',
                style: TextStyle(
                  color: AppTheme.electricBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
