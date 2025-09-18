// lib/main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth_service.dart'; // Asegúrate de que la ruta sea correcta
import 'firebase_options.dart'; // Generado por flutterfire configure
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // ← super.key para seguir recomendaciones

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GasGas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}

class ClientRegisterScreen extends StatefulWidget {
  const ClientRegisterScreen({super.key}); // ← Añadido const y key

  @override
  ClientRegisterScreenState createState() => ClientRegisterScreenState();
}

class ClientRegisterScreenState extends State<ClientRegisterScreen> {
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
      appBar: AppBar(title: const Text('Registro Cliente')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Nombre"),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Correo"),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: "Contraseña"),
              obscureText: true,
            ),
            TextField(
              controller: plateController,
              decoration: const InputDecoration(labelText: "Placa"),
            ),
            TextField(
              controller: fuelTypeController,
              decoration: const InputDecoration(labelText: "Tipo de combustible"),
            ),
            const SizedBox(height: 16),
            if (loading) const CircularProgressIndicator(),
            if (errorMessage != null)
              Text(errorMessage!, style: const TextStyle(color: Colors.red)),
            ElevatedButton(
              onPressed: () async {
                if (!mounted) return; // ← Evita problemas de BuildContext

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

                if (!mounted) return;

                setState(() {
                  loading = false;
                  errorMessage = error;
                });

                if (error == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Registro exitoso')),
                  );
                  // Aquí puedes redirigir a otra pantalla si lo deseas
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
