class User {
  final String id;
  final String nombre;
  final String? telefono;
  final String correo;
  final String rol;
  final String estado; // Changed to String to match OpenAPI response or just keep as bool if it was bool

  User({
    required this.id,
    required this.nombre,
    this.telefono,
    required this.correo,
    required this.rol,
    required this.estado,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id_usuario'] as String,
      nombre: json['nombre'] as String,
      telefono: json['telefono'] as String?,
      correo: json['correo'] as String,
      rol: json['rol_nombre'] as String,
      estado: json['estado'].toString(), // Handle both bool and string
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_usuario': id,
      'nombre': nombre,
      'telefono': telefono,
      'correo': correo,
      'rol_nombre': rol,
      'estado': estado,
    };
  }
}

class UserCreate {
  final String nombre;
  final String? telefono;
  final String correo;
  final String contrasena;

  UserCreate({
    required this.nombre,
    this.telefono,
    required this.correo,
    required this.contrasena,
  });

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'telefono': telefono,
      'correo': correo,
      'contrasena': contrasena,
    };
  }
}

class UserLogin {
  final String correo;
  final String contrasena;

  UserLogin({
    required this.correo,
    required this.contrasena,
  });

  Map<String, dynamic> toJson() {
    return {
      'correo': correo,
      'contrasena': contrasena,
    };
  }
}

class TokenSchema {
  final String accessToken;
  final String tokenType;
  final User user;

  TokenSchema({
    required this.accessToken,
    this.tokenType = 'bearer',
    required this.user,
  });

  factory TokenSchema.fromJson(Map<String, dynamic> json) {
    return TokenSchema(
      accessToken: json['access_token'] as String,
      tokenType: json['token_type'] as String? ?? 'bearer',
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}

class UserProfileUpdate {
  final String? nombre;
  final String? telefono;

  UserProfileUpdate({this.nombre, this.telefono});

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'telefono': telefono,
    };
  }
}
