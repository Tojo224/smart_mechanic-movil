import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';

class VehicleHeader extends StatelessWidget {
  const VehicleHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.03),
              shape: BoxShape.circle,
              border: Border.all(color: AppTheme.electricBlue.withValues(alpha: 0.2)),
            ),
            child: const Icon(
              Icons.directions_car_rounded,
              size: 64,
              color: AppTheme.electricBlue,
            ),
          ),
        ),
        const SizedBox(height: 32),
        const Text(
          'CONFIGURACIÓN DEL GARAJE',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
            color: Colors.white,
          ),
        ),
        const Text(
          'Necesitamos las especificaciones de tu vehículo para brindarte asistencia precisa.',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppTheme.chromeSilver, fontSize: 13),
        ),
      ],
    );
  }
}
