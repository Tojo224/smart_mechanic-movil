import 'dart:ui';
import 'package:flutter/material.dart';

class VehicleForm extends StatelessWidget {
  final TextEditingController plateController;
  final TextEditingController brandController;
  final TextEditingController modelController;
  final TextEditingController yearController;
  final bool isLoading;
  final VoidCallback onRegister;

  const VehicleForm({
    super.key,
    required this.plateController,
    required this.brandController,
    required this.modelController,
    required this.yearController,
    required this.isLoading,
    required this.onRegister,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 48),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.1),
                    Colors.white.withValues(alpha: 0.01),
                  ],
                ),
              ),
              child: Column(
                children: [
                  _buildField(plateController, 'Matrícula / Placa', Icons.pin_outlined),
                  _buildDivider(),
                  _buildField(brandController, 'Marca (ej. Toyota)', Icons.factory_outlined),
                  _buildDivider(),
                  _buildField(modelController, 'Modelo (ej. Corolla)', Icons.model_training_outlined),
                  _buildDivider(),
                  _buildField(yearController, 'Año (ej. 2024)', Icons.calendar_today_outlined, type: TextInputType.number),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: isLoading ? null : onRegister,
          child: isLoading 
            ? const SizedBox(
                height: 24, width: 24,
                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)
              )
            : const Text('REGISTRAR Y CONTINUAR'),
        ),
      ],
    );
  }

  Widget _buildField(TextEditingController controller, String hint, IconData icon, {TextInputType? type}) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      keyboardType: type,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.transparent,
      ),
    );
  }

  Widget _buildDivider() => Container(height: 1, color: Colors.white.withValues(alpha: 0.05));
}
