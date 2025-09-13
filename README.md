GasolinerApp

Aplicación móvil para gestión de reservas de gasolina en Bolivia. Permite a gasolineras publicar disponibilidad, a clientes realizar reservas con pago anticipado y a los administradores gestionar el ecosistema.

Características principales

Registro de usuarios (Administrador, Gasolinera, Cliente).

Gestión de stock en tiempo real por gasolineras.

Reservas de gasolina con asignación automática de horario.

Validación de entregas mediante placa del vehículo.

Reprogramación de reservas (máximo 1 vez) y cancelación automática en caso de incumplimiento o vencimiento de 24h.

Notificaciones push a clientes cuando llega gasolina o hay cambios en su reserva.

Créditos en la app en caso de cancelación.

Arquitectura

Frontend: Flutter (propuesto para versión móvil).

Backend: Firebase (Firestore, Cloud Functions, Auth, Notifications).

Base de datos: Firestore (NoSQL).

Estructura de la Base de Datos

usuarios → clientes, gasolineras y administradores.

gasolineras → información de estaciones y stock disponible.

reservas → control de litros, horarios y estados de entrega.

ventas → historial de ventas de cada gasolinera.

notificaciones → mensajes y alertas para los clientes.

Roadmap (MVP en 3 sprints)

Sprint 1: Registro de usuarios y gasolineras, gestión de stock inicial y consulta de disponibilidad.

Sprint 2: Reservas con comprobante de pago, actualización automática de stock, validación por placa y registro de ventas.

Sprint 3: Notificaciones de llegada de gasolina, reprogramación y cancelaciones automáticas con créditos en la app.
