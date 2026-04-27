class IncidentCreate {
  final String vehicleId;
  final String? descripcion;
  final String? telefono;
  final double? latitud;
  final double? longitud;
  final String prioridad;

  IncidentCreate({
    required this.vehicleId,
    this.descripcion,
    this.telefono,
    this.latitud,
    this.longitud,
    this.prioridad = 'MEDIA',
  });

  Map<String, dynamic> toJson() {
    return {
      'id_vehiculo': vehicleId,
      'descripcion': descripcion,
      'telefono': telefono,
      'latitud': latitud,
      'longitud': longitud,
      'prioridad': prioridad,
    };
  }
}

class IncidentResponse {
  final String id;
  final String vehicleId;
  final String? workshopId;
  final String? technicianId;
  final String? workshopName;
  final String? technicianName;
  final String? technicianPhone;
  final String? descripcion;
  final String? telefono;
  final String estado;
  final String prioridad;
  final String? fecha;
  final double? latitud;
  final double? longitud;
  final String? resumenIa;
  final String? analisisConsolidado;

  IncidentResponse({
    required this.id,
    required this.vehicleId,
    this.workshopId,
    this.technicianId,
    this.workshopName,
    this.technicianName,
    this.technicianPhone,
    this.descripcion,
    this.telefono,
    required this.estado,
    required this.prioridad,
    this.fecha,
    this.latitud,
    this.longitud,
    this.resumenIa,
    this.analisisConsolidado,
  });

  factory IncidentResponse.fromJson(Map<String, dynamic> json) {
    return IncidentResponse(
      id: json['id_incidente'] as String,
      vehicleId: json['id_vehiculo'] as String,
      workshopId: json['id_taller'] as String?,
      technicianId: json['id_tecnico'] as String?,
      workshopName: json['workshop_name'] as String?,
      technicianName: json['technician_name'] as String?,
      technicianPhone: json['technician_phone'] as String?,
      descripcion: json['descripcion'] as String?,
      telefono: json['telefono'] as String?,
      estado: json['estado_incidente'] as String,
      prioridad: json['prioridad_incidente'] as String,
      fecha: json['fecha_reporte'] as String?,
      latitud: (json['latitud'] as num?)?.toDouble(),
      longitud: (json['longitud'] as num?)?.toDouble(),
      resumenIa: json['resumen_ia'] as String?,
      analisisConsolidado: json['analisis_consolidado'] as String?,
    );
  }
}
