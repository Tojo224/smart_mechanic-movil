import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/vehicle.dart';
import '../../providers/vehicle_provider.dart';

class EditVehicleDialog extends ConsumerStatefulWidget {
  final Vehicle vehicle;
  const EditVehicleDialog({super.key, required this.vehicle});

  @override
  ConsumerState<EditVehicleDialog> createState() => _EditVehicleDialogState();
}

class _EditVehicleDialogState extends ConsumerState<EditVehicleDialog> {
  late TextEditingController _plateController;
  late TextEditingController _brandController;
  late TextEditingController _modelController;
  late TextEditingController _yearController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _plateController = TextEditingController(text: widget.vehicle.matricula);
    _brandController = TextEditingController(text: widget.vehicle.marca);
    _modelController = TextEditingController(text: widget.vehicle.modelo);
    _yearController = TextEditingController(
      text: widget.vehicle.year.toString(),
    );
  }

  @override
  void dispose() {
    _plateController.dispose();
    _brandController.dispose();
    _modelController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: AlertDialog(
        backgroundColor: const Color(0xFF1E293B).withValues(alpha: 0.8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.white10),
        ),
        title: const Text(
          'EDITAR VEHÍCULO',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildField(_plateController, 'Matrícula', Icons.pin_outlined),
              const SizedBox(height: 12),
              _buildField(_brandController, 'Marca', Icons.factory_outlined),
              const SizedBox(height: 12),
              _buildField(
                _modelController,
                'Modelo',
                Icons.model_training_outlined,
              ),
              const SizedBox(height: 12),
              _buildField(
                _yearController,
                'Año',
                Icons.calendar_today_outlined,
                type: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCELAR', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: _isLoading ? null : _save,
            child: _isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('GUARDAR CAMBIOS'),
          ),
        ],
      ),
    );
  }

  Widget _buildField(
    TextEditingController controller,
    String label,
    IconData icon, {
    TextInputType? type,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      keyboardType: type,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.orange, size: 20),
        labelStyle: const TextStyle(color: Colors.grey),
      ),
    );
  }

  Future<void> _save() async {
    setState(() => _isLoading = true);
    await ref
        .read(vehicleListProvider.notifier)
        .updateVehicle(
          widget.vehicle.id,
          VehicleCreate(
            matricula: _plateController.text,
            marca: _brandController.text,
            modelo: _modelController.text,
            year: int.tryParse(_yearController.text) ?? widget.vehicle.year,
          ),
        );
    if (mounted) Navigator.pop(context);
  }
}
