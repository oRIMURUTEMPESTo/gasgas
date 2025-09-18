// lib/register_admin_screen.dart
import 'package:flutter/material.dart';
import '../auth_service.dart';


class AdminRegisterScreen extends StatefulWidget {
  const AdminRegisterScreen({super.key});

  @override
  AdminRegisterScreenState createState() => AdminRegisterScreenState();
}

class AdminRegisterScreenState extends State<AdminRegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool loading = false;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro Administrador')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: "Nombre")),
            TextField(controller: emailController, decoration: const InputDecoration(labelText: "Correo")),
            TextField(controller: passwordController, decoration: const InputDecoration(labelText: "Contraseña"), obscureText: true),
            const SizedBox(height: 16),
            if (loading) const CircularProgressIndicator(),
            if (errorMessage != null) Text(errorMessage!, style: const TextStyle(color: Colors.red)),
            ElevatedButton(
              onPressed: () async {
                if (!mounted) return;

                setState(() {
                  loading = true;
                  errorMessage = null;
                });

                String? error = await registerAdmin(
                  name: nameController.text.trim(),
                  email: emailController.text.trim(),
                  password: passwordController.text.trim(),
                );

                if (!mounted) return;

                setState(() {
                  loading = false;
                  errorMessage = error;
                });

                if (error == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Registro exitoso')),
                  );
                }
              },
              child: const Text("Registrarse"),
            ),
          ],
        ),
      ),
    );
  }
}
