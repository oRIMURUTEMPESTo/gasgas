// lib/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'register_client_screen.dart'; // Ruta correcta a tu pantalla de registro
import '../auth_service.dart'; // Asegúrate de que la ruta sea correcta

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key}); // Const y key agregado

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool loading = false;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inicio de sesión')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Correo"),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: "Contraseña"),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            if (loading) const CircularProgressIndicator(),
            if (errorMessage != null)
              Text(errorMessage!, style: const TextStyle(color: Colors.red)),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  loading = true;
                  errorMessage = null;
                });

                String? error = await login(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim(),
                );

                if (!mounted) return; // Evita usar context después de async

                setState(() {
                  loading = false;
                  errorMessage = error;
                });

                if (error == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Inicio de sesión exitoso')),
                  );
                  // Aquí puedes navegar a otra pantalla, por ejemplo al home
                }
              },
              child: const Text("Iniciar sesión"),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterClientScreen(),
                  ),
                );
              },
              child: const Text("¿No tienes cuenta? Regístrate"),
            ),
          ],
        ),
      ),
    );
  }
}
