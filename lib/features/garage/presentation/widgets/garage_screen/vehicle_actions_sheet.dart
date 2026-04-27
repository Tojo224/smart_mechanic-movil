import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/vehicle.dart';
import '../../providers/vehicle_provider.dart';
import 'edit_vehicle_dialog.dart';

class VehicleActionsSheet extends ConsumerWidget {
  final Vehicle vehicle;
  const VehicleActionsSheet({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: const BoxDecoration(
        color: Color(0xFF1E293B),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.edit, color: Colors.blueAccent),
            title: const Text(
              'EDITAR VEHÍCULO',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) => EditVehicleDialog(vehicle: vehicle),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete_outline, color: Colors.redAccent),
            title: const Text(
              'ELIMINAR VEHÍCULO',
              style: TextStyle(color: Colors.redAccent),
            ),
            onTap: () async {
              final confirm = await _showConfirmDelete(context);
              if (confirm == true) {
                await ref
                    .read(vehicleListProvider.notifier)
                    .deleteVehicle(vehicle.id);
                if (context.mounted) Navigator.pop(context);
              }
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Future<bool?> _showConfirmDelete(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF0F172A),
        title: const Text('¿ELIMINAR?', style: TextStyle(color: Colors.white)),
        content: Text(
          '¿Seguro que quieres eliminar el ${vehicle.marca} ${vehicle.modelo}?',
          style: const TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('CANCELAR'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('ELIMINAR'),
          ),
        ],
      ),
    );
  }
}
