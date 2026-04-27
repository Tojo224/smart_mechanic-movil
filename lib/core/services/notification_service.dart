import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/identity/data/auth_repository.dart';

// Esta función DEBE ser global y de alto nivel
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log("Mensaje en segundo plano: ${message.messageId}");
}

class NotificationService {
  final Ref _ref;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  GlobalKey<ScaffoldMessengerState>? _messengerKey;

  NotificationService(this._ref);

  Future<void> initialize(GlobalKey<ScaffoldMessengerState> key) async {
    _messengerKey = key;
    
    // Registrar el manejador de segundo plano
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // 1. Solicitar permisos
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('Usuario otorgó permisos de notificación');
      print('🔔 NOTIFICACIONES: Permisos autorizados');
      
      // 2. Obtener el Token
      String? token = await _fcm.getToken();
      if (token != null) {
        log('FCM Token: $token');
        print('🔑 FCM TOKEN: $token');
        await syncToken(token);
      }

      // 3. Configurar listeners
      _setupForegroundService();
    } else {
      log('Usuario denegó los permisos de notificación');
      print('❌ NOTIFICACIONES: Permisos denegados');
    }
  }

  Future<void> syncToken(String token) async {
    try {
      final authRepo = _ref.read(authRepositoryProvider);
      await authRepo.updateFcmToken(token);
      log('Token sincronizado con el servidor');
    } catch (e) {
      log('Error al sincronizar token: $e');
    }
  }

  void _setupForegroundService() {
    // Escuchar notificaciones cuando la app está abierta (Primer Plano)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final title = message.notification?.title ?? 'Notificación';
      final body = message.notification?.body ?? '';
      
      log('Mensaje recibido en primer plano: $title');

      // Mostrar un SnackBar visual porque Android NO lo muestra en foreground por defecto
      _messengerKey?.currentState?.showSnackBar(
        SnackBar(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              if (body.isNotEmpty) Text(body),
            ],
          ),
          backgroundColor: const Color(0xFF1E293B),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 4),
          action: SnackBarAction(
            label: 'VER',
            textColor: Colors.blueAccent,
            onPressed: () {
              // Lógica para ir a la pantalla correspondiente
            },
          ),
        ),
      );
    });

    // Escuchar cuando el usuario toca la notificación y la app se abre
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('El usuario tocó la notificación: ${message.data}');
      // Aquí puedes navegar a una pantalla específica según los datos del mensaje
    });
  }
}

// Provider para acceder al servicio desde cualquier parte de la app
final notificationServiceProvider = Provider((ref) => NotificationService(ref));
