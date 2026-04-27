import 'dart:ui';
import 'package:flutter/material.dart';

class RegisterForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isLoading;
  final VoidCallback onRegister;

  const RegisterForm({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.emailController,
    required this.passwordController,
    required this.isLoading,
    required this.onRegister,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.1),
                    Colors.white.withValues(alpha: 0.01),
                  ],
                ),
              ),
              child: Column(
                children: [
                  _buildField(nameController, 'Nombre Completo', Icons.person_outline),
                  _buildDivider(),
                  _buildField(phoneController, 'Número de Teléfono', Icons.phone_outlined, type: TextInputType.phone),
                  _buildDivider(),
                  _buildField(emailController, 'Correo Electrónico', Icons.email_outlined, type: TextInputType.emailAddress),
                  _buildDivider(),
                  _buildField(passwordController, 'Contraseña', Icons.lock_outline, isObscure: true),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: isLoading ? null : onRegister,
          child: isLoading 
            ? const SizedBox(
                height: 20, 
                width: 20, 
                child: CircularProgressIndicator(
                  strokeWidth: 3, 
                  color: Colors.white,
                ),
              )
            : const Text(
                'CREAR CUENTA',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
        ),
      ],
    );
  }

  Widget _buildField(TextEditingController controller, String hint, IconData icon, {TextInputType? type, bool isObscure = false}) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      style: const TextStyle(color: Colors.white),
      keyboardType: type,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.transparent,
      ),
    );
  }

  Widget _buildDivider() => Container(height: 1, color: Colors.white.withValues(alpha: 0.05));
}
