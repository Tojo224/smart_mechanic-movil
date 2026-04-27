import 'package:firebase_messaging/firebase_messaging.dart';
import '../../../../core/services/notification_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/auth_repository.dart';
import '../../domain/user.dart';
import '../../../garage/presentation/providers/vehicle_provider.dart';
import '../../../emergencies/presentation/providers/emergency_provider.dart';
import '../../../ai_assistant/presentation/providers/evidence_provider.dart';

import '../../../ai_assistant/presentation/providers/chat_provider.dart';
import '../../../../core/local_storage/secure_storage_provider.dart';

enum AuthStatus { authenticated, unauthenticated, initial }

class AuthState {
  final AuthStatus status;
  final User? user;
  final String? errorMessage;

  AuthState({this.status = AuthStatus.initial, this.user, this.errorMessage});

  AuthState copyWith({AuthStatus? status, User? user, String? errorMessage}) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    Future.microtask(() => _checkToken());
    return AuthState();
  }

  Future<void> _checkToken() async {
    try {
      final user = await ref.read(authRepositoryProvider).getMe();
      state = state.copyWith(status: AuthStatus.authenticated, user: user);
    } catch (e) {
      state = state.copyWith(status: AuthStatus.unauthenticated);
    }
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(status: AuthStatus.initial);
    try {
      final tokenSchema = await ref
          .read(authRepositoryProvider)
          .login(email, password);
      state = state.copyWith(
        status: AuthStatus.authenticated,
        user: tokenSchema.user,
        errorMessage: null,
      );

      // Sincronizar token FCM después de loguear con éxito
      final token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        await ref.read(notificationServiceProvider).syncToken(token);
      }
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        errorMessage: 'Error al iniciar sesión: Verifique sus credenciales',
      );
    }
  }

  Future<void> register(UserCreate userCreate) async {
    state = state.copyWith(status: AuthStatus.initial);
    try {
      await ref.read(authRepositoryProvider).register(userCreate);
      await login(userCreate.correo, userCreate.contrasena);
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        errorMessage:
            'Error en el registro: Correo ya en uso o datos inválidos',
      );
    }
  }

  Future<void> updateProfile(UserProfileUpdate update) async {
    try {
      final user = await ref.read(authRepositoryProvider).updateMe(update);
      state = state.copyWith(user: user, errorMessage: null);
    } catch (e) {
      state = state.copyWith(errorMessage: 'Error al actualizar el perfil');
    }
  }

  Future<void> logout() async {
    print('🔄 AUTH: Iniciando proceso de logout...');
    try {
      await ref.read(authRepositoryProvider).logout();
      print('✅ AUTH: Logout en servidor (FCM) exitoso');
    } catch (e) {
      print('⚠️ AUTH: Error al notificar logout al servidor (ignorado): $e');
    }
    await _clearLocalData();
  }

  Future<void> forceLogout() async {
    print('🚨 AUTH: Forzando logout local...');
    await _clearLocalData();
  }

  Future<void> _clearLocalData() async {
    print('🧹 AUTH: Limpiando datos locales...');
    
    // 1. Borrar token físicamente
    try {
      final storage = ref.read(secureStorageProvider);
      await storage.delete(key: 'jwt_token');
      print('🗑️ AUTH: Token borrado de SecureStorage');
    } catch (e) {
      print('❌ AUTH: Error al borrar token: $e');
    }

    // 2. Invalidar proveedores de datos
    print('🔄 AUTH: Invalidando proveedores...');
    ref.invalidate(vehicleListProvider);
    ref.invalidate(emergencyNotifierProvider);
    ref.invalidate(evidenceProvider);
    ref.invalidate(chatProvider);

    // 3. Cambiar estado (Esto dispara la redirección del router)
    state = state.copyWith(status: AuthStatus.unauthenticated, user: null);
    print('🚪 AUTH: Sesión cerrada localmente. Estado: unauthenticated');
  }
}
