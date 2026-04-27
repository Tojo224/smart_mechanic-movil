import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/vehicle.dart';
import '../providers/vehicle_provider.dart';
import '../widgets/register_vehicle_screen/vehicle_header.dart';
import '../widgets/register_vehicle_screen/vehicle_form.dart';

class RegisterVehicleScreen extends ConsumerStatefulWidget {
  const RegisterVehicleScreen({super.key});

  @override
  ConsumerState<RegisterVehicleScreen> createState() => _RegisterVehicleScreenState();
}

class _RegisterVehicleScreenState extends ConsumerState<RegisterVehicleScreen> {
  final _plateController = TextEditingController();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _yearController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _plateController.dispose();
    _brandController.dispose();
    _modelController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (_yearController.text.isEmpty) return;
    setState(() => _isLoading = true);
    
    final vehicle = VehicleCreate(
      matricula: _plateController.text,
      marca: _brandController.text,
      modelo: _modelController.text,
      year: int.tryParse(_yearController.text) ?? 2024,
    );

    try {
      await ref.read(vehicleListProvider.notifier).addVehicle(vehicle);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Vehículo registrado con éxito'),
            backgroundColor: Colors.green,
          ),
        );
        // Volver atrás o ir al inicio
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        } else {
          context.go('/');
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al registrar: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('REGISTRO DE VEHÍCULO'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          _buildBackground(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                children: [
                  const VehicleHeader(),
                  VehicleForm(
                    plateController: _plateController,
                    brandController: _brandController,
                    modelController: _modelController,
                    yearController: _yearController,
                    isLoading: _isLoading,
                    onRegister: _handleRegister,
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1B262C),
            Color(0xFF0F172A),
            Color(0xFF000000),
          ],
        ),
      ),
    );
  }
}
