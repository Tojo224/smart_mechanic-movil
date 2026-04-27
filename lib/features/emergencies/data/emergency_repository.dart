import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_client.dart';
import '../domain/incident.dart';

final emergencyRepositoryProvider = Provider<EmergencyRepository>((ref) {
  return EmergencyRepository(dio: ref.watch(dioProvider));
});

class EmergencyRepository {
  final Dio _dio;

  EmergencyRepository({required Dio dio}) : _dio = dio;

  Future<IncidentResponse> reportIncident(IncidentCreate create) async {
    final response = await _dio.post(
      '/api/v1/emergencies/',
      data: create.toJson(),
    );
    return IncidentResponse.fromJson(response.data);
  }

  Future<IncidentResponse?> getActiveIncident() async {
    try {
      final response = await _dio.get('/api/v1/emergencies/me/active');
      if (response.data == null) return null;
      return IncidentResponse.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<IncidentResponse> getIncident(String id) async {
    final response = await _dio.get('/api/v1/emergencies/$id');
    return IncidentResponse.fromJson(response.data);
  }

  Future<List<IncidentResponse>> getIncidentHistory() async {
    final response = await _dio.get('/api/v1/emergencies/me/history');
    final List list = response.data;
    return list.map((json) => IncidentResponse.fromJson(json)).toList();
  }

  Future<IncidentResponse> cancelIncident(String id) async {
    final response = await _dio.post('/api/v1/emergencies/$id/cancel');
    return IncidentResponse.fromJson(response.data);
  }
}
