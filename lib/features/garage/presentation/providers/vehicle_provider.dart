import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/vehicle_repository.dart';
import '../../domain/vehicle.dart';
import '../../../identity/presentation/providers/auth_provider.dart';

final vehicleListProvider = AsyncNotifierProvider<VehicleList, List<Vehicle>>(() {
  return VehicleList();
});

class VehicleList extends AsyncNotifier<List<Vehicle>> {
  @override
  FutureOr<List<Vehicle>> build() async {
    final authState = ref.watch(authProvider);
    if (authState.status != AuthStatus.authenticated) {
      return [];
    }
    return ref.watch(vehicleRepositoryProvider).getMyVehicles();
  }

  Future<void> addVehicle(VehicleCreate create) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(vehicleRepositoryProvider).registerVehicle(create);
      final vehicles = await ref.read(vehicleRepositoryProvider).getMyVehicles();
      state = AsyncValue.data(vehicles);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> updateVehicle(String id, VehicleCreate update) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(vehicleRepositoryProvider).updateVehicle(id, update);
      final vehicles = await ref.read(vehicleRepositoryProvider).getMyVehicles();
      state = AsyncValue.data(vehicles);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> deleteVehicle(String id) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(vehicleRepositoryProvider).deleteVehicle(id);
      final vehicles = await ref.read(vehicleRepositoryProvider).getMyVehicles();
      state = AsyncValue.data(vehicles);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => ref.read(vehicleRepositoryProvider).getMyVehicles());
  }
}
