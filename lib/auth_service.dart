import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Instancias centralizadas para evitar repetición
final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

/// Registrar un cliente (único rol que se registra solo)
Future<String?> registerClient({
  required String email,
  required String password,
  required String name,
  required String plate,
  required String fuelType,
}) async {
  try {
    // Verificar si la placa ya existe
    var plateCheck = await _firestore
        .collection('users')
        .where('vehiclePlate', isEqualTo: plate)
        .get();
    if (plateCheck.docs.isNotEmpty) {
      return 'La placa ya está registrada.';
    }
 
    // Crear el usuario en Firebase Auth
    UserCredential userCredential =
        await _auth.createUserWithEmailAndPassword(email: email, password: password);
    String uid = userCredential.user!.uid;
 
    // Guardar datos en Firestore
    await _firestore.collection('users').doc(uid).set({
      'name': name,
      'email': email,
      'vehiclePlate': plate,
      'fuelType': fuelType,
      'createdAt': FieldValue
          .serverTimestamp(), // ← Se guarda la fecha/hora del servidor
    });
 
    return null; // null indica éxito
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return 'La contraseña es muy débil.';
    } else if (e.code == 'email-already-in-use') {
      return 'Este correo electrónico ya está en uso.';
    }
    return 'Ocurrió un error de autenticación.';
  } catch (e) {
    return 'Ocurrió un error inesperado. Inténtalo de nuevo.';
  }
}

/// Registra un administrador (solo desde interfaz de admin)
Future<String?> registerAdmin({
  required String name,
  required String email,
  required String password,
}) async {
  try {
    UserCredential userCredential =
        await _auth.createUserWithEmailAndPassword(email: email, password: password);
    String uid = userCredential.user!.uid;
 
    await _firestore.collection('admins').doc(uid).set({
      'name': name,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    });
 
    return null;
  } on FirebaseAuthException catch (e) {
    return e.message ?? 'Error al registrar administrador.';
  } catch (e) {
    return 'Ocurrió un error inesperado.';
  }
}

/// Registra una gasolinera (solo desde interfaz de admin)
Future<String?> registerGasStation({
  required String name,
  required String email,
  required String password,
  required String nit,
  required String address,
  required String schedule,
}) async {
  try {
    var nitCheck = await _firestore
        .collection('gas_stations')
        .where('NIT', isEqualTo: nit)
        .get();
    if (nitCheck.docs.isNotEmpty) {
      return 'El NIT ya está registrado.';
    }
 
    UserCredential userCredential =
        await _auth.createUserWithEmailAndPassword(email: email, password: password);
    String uid = userCredential.user!.uid;
 
    await _firestore.collection('gas_stations').doc(uid).set({
      'name': name,
      'email': email,
      'NIT': nit,
      'address': address,
      'schedule': schedule,
      'active': true,
      'createdAt': FieldValue.serverTimestamp(),
    });
 
    return null;
  } on FirebaseAuthException catch (e) {
    return e.message ?? 'Error al registrar la gasolinera.';
  } catch (e) {
    return 'Ocurrió un error inesperado.';
  }
}

/// Iniciar sesión
Future<String?> login({
  required String email,
  required String password,
}) async {
  try {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return null; // Éxito
  } on FirebaseAuthException catch (e) {
    // Mensajes más específicos para errores comunes de login
    if (e.code == 'user-not-found' || e.code == 'wrong-password' || e.code == 'invalid-credential') {
      return 'Correo o contraseña incorrectos.';
    }
    return 'Error al iniciar sesión. Inténtalo de nuevo.';
  } catch (e) {
    return 'Ocurrió un error inesperado.';
  }
}
