import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/emergency_repository.dart';
import '../../domain/incident.dart';

final historyProvider = FutureProvider<List<IncidentResponse>>((ref) async {
  return ref.watch(emergencyRepositoryProvider).getIncidentHistory();
});
