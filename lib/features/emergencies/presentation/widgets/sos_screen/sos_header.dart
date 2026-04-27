import 'package:flutter/material.dart';
import '../../../../identity/domain/user.dart';

class SosHeader extends StatelessWidget {
  final User? user;
  final VoidCallback onProfileTap;

  const SosHeader({
    super.key, 
    this.user,
    required this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          // Logo
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.settings_suggest_rounded, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 10),
          const Text('SMART', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
          const Text('MECH', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.orange)),
          const Spacer(),
          
          // Perfil Interactivo
          GestureDetector(
            onTap: onProfileTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.orange,
                    child: Text(
                      user?.nombre.isNotEmpty == true ? user!.nombre.substring(0, 1).toUpperCase() : 'U', 
                      style: const TextStyle(color: Colors.white, fontSize: 10)
                    ),
                  ),
                  const SizedBox(width: 6),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.nombre.split(' ').first ?? 'Juan', 
                        style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)
                      ),
                      Text(
                        user?.rol ?? 'Cliente', 
                        style: const TextStyle(color: Colors.grey, fontSize: 8)
                      ),
                    ],
                  ),
                  const Icon(Icons.chevron_right, color: Colors.grey, size: 14),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
