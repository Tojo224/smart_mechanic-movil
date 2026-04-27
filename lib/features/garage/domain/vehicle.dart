class Vehicle {
  final String id;
  final String userId;
  final String matricula;
  final String marca;
  final String modelo;
  final int year;
  final String? color;
  final String? foto;

  Vehicle({
    required this.id,
    required this.userId,
    required this.matricula,
    required this.marca,
    required this.modelo,
    required this.year,
    this.color,
    this.foto,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id_vehiculo'] as String,
      userId: json['id_usuario'] as String,
      matricula: json['matricula'] as String,
      marca: json['marca'] as String,
      modelo: json['modelo'] as String,
      year: json['ano'] as int,
      color: json['color'] as String?,
      foto: json['foto'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_vehiculo': id,
      'id_usuario': userId,
      'matricula': matricula,
      'marca': marca,
      'modelo': modelo,
      'ano': year,
      'color': color,
      'foto': foto,
    };
  }
}

class VehicleCreate {
  final String matricula;
  final String marca;
  final String modelo;
  final int year;
  final String? color;

  VehicleCreate({
    required this.matricula,
    required this.marca,
    required this.modelo,
    required this.year,
    this.color,
  });

  Map<String, dynamic> toJson() {
    return {
      'matricula': matricula,
      'marca': marca,
      'modelo': modelo,
      'ano': year,
      'color': color,
    };
  }
}
