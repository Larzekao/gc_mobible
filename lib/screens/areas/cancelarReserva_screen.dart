
import 'package:flutter/material.dart';
import '../../models/reserva.dart';
import '../../services/reserva_service.dart';


class CancelarReservaScreen extends StatefulWidget {
  @override
  _CancelarReservaScreenState createState() => _CancelarReservaScreenState();
}

class _CancelarReservaScreenState extends State<CancelarReservaScreen> {
  late Future<List<Reserva>> _reservasFuture;
  final ReservaService _reservaService = ReservaService();

  @override
  void initState() {
    super.initState();
    _loadReservas();
  }

  void _loadReservas() {
    setState(() {
      _reservasFuture = _reservaService.fetchReservas();
    });
  }

  Future<void> cancelarReserva(int id) async {
    try {
      await _reservaService.deleteReserva(id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Reserva cancelada')),
      );
      _loadReservas();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cancelar la reserva')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cancelar Reserva de Área')),
      body: FutureBuilder<List<Reserva>>(
        future: _reservasFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al cargar reservas'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No tienes reservas activas.'));
          }
          final reservas = snapshot.data!;
          return ListView.builder(
            itemCount: reservas.length,
            itemBuilder: (context, index) {
              final reserva = reservas[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(reserva.nombre, style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Fecha: ${reserva.fechaReserva?.day ?? '-'}' '/${reserva.fechaReserva?.month ?? '-'}' '/${reserva.fechaReserva?.year ?? '-'}'),
                  trailing: ElevatedButton.icon(
                    icon: Icon(Icons.cancel, color: Colors.white),
                    label: Text('Cancelar', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () => cancelarReserva(reserva.id!),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
