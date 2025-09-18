// lib/screens/register_client_screen.dart
import 'package:flutter/material.dart';
import '../auth_service.dart';

class RegisterClientScreen extends StatefulWidget {
  const RegisterClientScreen({super.key});

  @override
  _RegisterClientScreenState createState() => _RegisterClientScreenState();
}

class _RegisterClientScreenState extends State<RegisterClientScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController plateController = TextEditingController();
  final TextEditingController fuelTypeController = TextEditingController();

  bool loading = false;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro Cliente')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: "Nombre")),
            TextField(controller: emailController, decoration: InputDecoration(labelText: "Correo")),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: "Contraseña"), obscureText: true),
            TextField(controller: plateController, decoration: InputDecoration(labelText: "Placa")),
            TextField(controller: fuelTypeController, decoration: InputDecoration(labelText: "Tipo de combustible")),
            SizedBox(height: 16),
            if (loading) CircularProgressIndicator(),
            if (errorMessage != null) Text(errorMessage!, style: TextStyle(color: Colors.red)),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  loading = true;
                  errorMessage = null;
                });

                String? error = await registerClient(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim(),
                  name: nameController.text.trim(),
                  plate: plateController.text.trim(),
                  fuelType: fuelTypeController.text.trim(),
                );

                setState(() {
                  loading = false;
                  errorMessage = error;
                });

                if (error == null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registro exitoso')));
                }
              },
              child: Text("Registrarse"),
            ),
          ],
        ),
      ),
    );
  }
}
