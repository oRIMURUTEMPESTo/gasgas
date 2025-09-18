// lib/register_gas_station_screen.dart
import 'package:flutter/material.dart';
import '../auth_service.dart';


class GasStationRegisterScreen extends StatefulWidget {
  const GasStationRegisterScreen({super.key});

  @override
  GasStationRegisterScreenState createState() => GasStationRegisterScreenState();
}

class GasStationRegisterScreenState extends State<GasStationRegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nitController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController scheduleController = TextEditingController();

  bool loading = false;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro Gasolinera')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: "Nombre")),
            TextField(controller: emailController, decoration: const InputDecoration(labelText: "Correo")),
            TextField(controller: passwordController, decoration: const InputDecoration(labelText: "Contraseña"), obscureText: true),
            TextField(controller: nitController, decoration: const InputDecoration(labelText: "NIT")),
            TextField(controller: addressController, decoration: const InputDecoration(labelText: "Dirección")),
            TextField(controller: scheduleController, decoration: const InputDecoration(labelText: "Horario")),
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

                String? error = await registerGasStation(
                  name: nameController.text.trim(),
                  email: emailController.text.trim(),
                  password: passwordController.text.trim(),
                  nit: nitController.text.trim(),
                  address: addressController.text.trim(),
                  schedule: scheduleController.text.trim(),
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
