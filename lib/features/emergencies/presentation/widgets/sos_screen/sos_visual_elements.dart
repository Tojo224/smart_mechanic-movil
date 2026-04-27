import 'package:flutter/material.dart';

class SosTitles extends StatelessWidget {
  const SosTitles({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(height: 10),
        Text(
          'CENTRO DE EMERGENCIAS',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 10,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'ASISTENCIA',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            height: 1,
          ),
        ),
        Text(
          'VEHICULAR',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            color: Colors.orange,
            height: 1,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Tu co-piloto digital está listo',
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ],
    );
  }
}

class SosBackground extends StatelessWidget {
  const SosBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return const Opacity(
      opacity: 0.05,
      child: GridPaper(
        color: Colors.white,
        divisions: 1,
        subdivisions: 1,
        interval: 100,
      ),
    );
  }
}
