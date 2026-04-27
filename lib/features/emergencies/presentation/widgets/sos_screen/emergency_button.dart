import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/incident.dart';

class EmergencyButton extends StatelessWidget {
  final AsyncValue<IncidentResponse?> emergencyState;
  final VoidCallback onTap;

  const EmergencyButton({
    super.key,
    required this.emergencyState,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.red.withValues(alpha: 0.1)),
            ),
          ),
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const RadialGradient(
                colors: [Color(0xFFFF4B2B), Color(0xFFFF416C)],
              ),
              boxShadow: [
                BoxShadow(color: Colors.red.withValues(alpha: 0.4), blurRadius: 20),
              ],
            ),
            child: Center(
              child: emergencyState.when(
                data: (incident) => incident == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.gps_fixed, size: 28, color: Colors.white),
                          SizedBox(height: 8),
                          Text(
                            'SOLICITAR',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            'EMERGENCIA',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      )
                    : const Icon(
                        Icons.check_circle_outline,
                        size: 80,
                        color: Colors.white,
                      ),
                loading: () => const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 5,
                ),
                error: (e, _) => const Icon(
                  Icons.error_outline,
                  size: 80,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
