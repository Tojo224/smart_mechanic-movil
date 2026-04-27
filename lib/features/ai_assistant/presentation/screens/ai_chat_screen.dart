import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vibration/vibration.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/services/socket_service.dart';
import '../../domain/chat_message.dart';
import '../providers/chat_provider.dart';
import '../../../emergencies/data/emergency_repository.dart';

class AIChatScreen extends ConsumerStatefulWidget {
  const AIChatScreen({super.key});

  @override
  ConsumerState<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends ConsumerState<AIChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    _startListening();
    _loadActiveIncidentData();
  }

  Future<void> _loadActiveIncidentData() async {
    try {
      final incident = await ref.read(emergencyRepositoryProvider).getActiveIncident();
      if (incident != null && incident.resumenIa != null) {
        ref.read(chatProvider.notifier).initializeWithContext(
          'ANÁLISIS DEL SISTEMA: ${incident.resumenIa}'
        );
        _scrollToBottom();
      }
    } catch (e) {
      debugPrint('Error loading active incident: $e');
    }
  }

  void _startListening() {
    final socketService = ref.read(socketServiceProvider);
    socketService.connect();

    _subscription = socketService.messages.listen((msg) {
      if (msg['type'] == 'ANALYSIS_COMPLETED') {
        _handleAIAnalysis(msg['resumen_ia']);
      } else if (msg['type'] == 'WORKSHOP_ASSIGNED') {
        _handleMatch(msg['workshop_name'], msg['id']);
      }
    });
  }

  void _handleAIAnalysis(String summary) {
    ref.read(chatProvider.notifier).setTyping(false);
    ref.read(chatProvider.notifier).addMessage(
      ChatMessage(
        text: 'ANÁLISIS DEL SISTEMA: $summary',
        role: MessageRole.assistant,
      ),
    );
    _scrollToBottom();
  }

  void _handleMatch(String workshopName, String incidentId) async {
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate(duration: 500);
    }

    try {
      final incident = await ref
          .read(emergencyRepositoryProvider)
          .getIncident(incidentId);
      final aiSummary =
          incident.resumenIa ?? 'No se pudo generar un resumen detallado.';

      ref
          .read(chatProvider.notifier)
          .addMessage(
            ChatMessage(
              text:
                  '¡Buenas noticias! He analizado tu situación y encontré el taller más cercano: "$workshopName".\n\n'
                  'DIAGNÓSTICO DEL SISTEMA: $aiSummary\n\n'
                  'Recomendaciones:\n1. Coloca las luces de emergencia.\n2. No intentes mover el vehículo si hay humo.\n3. El mecánico llegará en unos minutos.',
              role: MessageRole.assistant,
            ),
          );
    } catch (e) {
      ref
          .read(chatProvider.notifier)
          .addMessage(
            ChatMessage(
              text:
                  '¡Buenas noticias! He encontrado el taller más cercano: "$workshopName".\n\n'
                  'Recomendaciones:\n1. Coloca las luces de emergencia.\n2. El mecánico llegará en unos minutos.',
              role: MessageRole.assistant,
            ),
          );
    }

    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white70),
          onPressed: () => context.go('/'),
        ),
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: AppTheme.electricBlue,
              child: Icon(Icons.psychology, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ASISTENTE IA',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  chatState.isTyping ? 'Escribiendo...' : 'En línea',
                  style: TextStyle(
                    color: chatState.isTyping
                        ? AppTheme.electricBlue
                        : Colors.greenAccent,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.black.withValues(alpha: 0.3),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: chatState.messages.length,
              itemBuilder: (context, index) {
                final msg = chatState.messages[index];
                return _buildMessageBubble(msg);
              },
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage msg) {
    final isUser = msg.role == MessageRole.user;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isUser
              ? AppTheme.electricBlue
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(isUser ? 20 : 0),
            bottomRight: Radius.circular(isUser ? 0 : 20),
          ),
          border: isUser
              ? null
              : Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: Text(
          msg.text,
          style: TextStyle(
            color: isUser ? Colors.white : Colors.white.withValues(alpha: 0.9),
            fontSize: 14,
            height: 1.4,
          ),
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.5),
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  controller: _messageController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Describe tu problema...',
                    hintStyle: TextStyle(color: Colors.white24),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            FloatingActionButton.small(
              onPressed: () {
                if (_messageController.text.trim().isEmpty) return;
                ref
                    .read(chatProvider.notifier)
                    .addMessage(
                      ChatMessage(
                        text: _messageController.text,
                        role: MessageRole.user,
                      ),
                    );
                _messageController.clear();
                _scrollToBottom();
                
                // Indicamos que el sistema está procesando el reporte
                ref.read(chatProvider.notifier).setTyping(true);
              },
              backgroundColor: AppTheme.electricBlue,
              child: const Icon(Icons.send, color: Colors.white, size: 18),
            ),
          ],
        ),
      ),
    );
  }
}
