import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class AIVisualLoader extends StatefulWidget {
  const AIVisualLoader({super.key});

  @override
  State<AIVisualLoader> createState() => _AIVisualLoaderState();
}

class _AIVisualLoaderState extends State<AIVisualLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        RotationTransition(
          turns: _controller,
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppTheme.electricBlue.withValues(alpha: 0.1), width: 2),
            ),
          ),
        ),
        RotationTransition(
          turns: Tween(begin: 1.0, end: 0.0).animate(_controller),
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppTheme.electricBlue.withValues(alpha: 0.3), width: 4),
            ),
          ),
        ),
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppTheme.electricBlue.withValues(alpha: 0.1),
            boxShadow: [
              BoxShadow(
                color: AppTheme.electricBlue.withValues(alpha: 0.4),
                blurRadius: 30,
                spreadRadius: 10,
              ),
            ],
          ),
          child: const Icon(Icons.psychology, color: Colors.white, size: 40),
        ),
      ],
    );
  }
}
