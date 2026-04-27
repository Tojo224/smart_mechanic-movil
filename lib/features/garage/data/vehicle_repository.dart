import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_client.dart';
import '../domain/vehicle.dart';

final vehicleRepositoryProvider = Provider<VehicleRepository>((ref) {
  return VehicleRepository(dio: ref.watch(dioProvider));
});

class VehicleRepository {
  final Dio _dio;

  VehicleRepository({required Dio dio}) : _dio = dio;

  Future<List<Vehicle>> getMyVehicles() async {
    final response = await _dio.get('/api/v1/identity/users/me/vehicles');
    final List<dynamic> data = response.data;
    return data.map((e) => Vehicle.fromJson(e)).toList();
  }

  Future<Vehicle> registerVehicle(VehicleCreate create) async {
    final response = await _dio.post(
      '/api/v1/identity/users/me/vehicles',
      data: create.toJson(),
    );
    return Vehicle.fromJson(response.data);
  }

  Future<Vehicle> updateVehicle(String id, VehicleCreate update) async {
    final response = await _dio.put(
      '/api/v1/identity/users/me/vehicles/$id',
      data: update.toJson(),
    );
    return Vehicle.fromJson(response.data);
  }

  Future<void> deleteVehicle(String id) async {
    await _dio.delete('/api/v1/identity/users/me/vehicles/$id');
  }
}
