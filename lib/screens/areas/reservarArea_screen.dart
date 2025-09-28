import '../../models/area_comun.dart';
import '../../models/reserva.dart';
import '../../services/area_comun_service.dart';
import '../../services/reserva_service.dart';
import 'package:flutter/material.dart';

class ReservarAreaScreen extends StatefulWidget {
  final AreaComun? area;
  final DateTime? fecha;
  const ReservarAreaScreen({Key? key, this.area, this.fecha}) : super(key: key);

  @override
  _ReservarAreaScreenState createState() => _ReservarAreaScreenState();
}

class _ReservarAreaScreenState extends State<ReservarAreaScreen> {
  late Future<List<AreaComun>> _areasFuture;
  final AreaComunService _areaService = AreaComunService();
  final ReservaService _reservaService = ReservaService();
  List<AreaComun> areas = [];
  AreaComun? selectedArea;
  DateTime? selectedDate;
  TimeOfDay? selectedHoraInicio;
  TimeOfDay? selectedHoraFin;
  String mensaje = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _areasFuture = _areaService.fetchAreas();
    // Inicializar con los argumentos si existen
    selectedArea = widget.area;
    selectedDate = widget.fecha;
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        title: Text('Reservar Área Común', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Color(0xFF2196F3),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white, size: 28),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFe3f2fd), Color(0xFFbbdefb)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Selecciona el área:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              FutureBuilder<List<AreaComun>>(
                future: _areasFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error al cargar áreas'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No hay áreas disponibles'));
                  }
                  areas = snapshot.data!;
                  return DropdownButtonFormField<AreaComun>(
                    value: selectedArea,
                    items: areas
                        .where((area) => area.estado.toLowerCase() == 'disponible')
                        .map((area) {
                      return DropdownMenuItem<AreaComun>(
                        value: area,
                        child: Text(area.nombre),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedArea = value;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
              Text('Selecciona la fecha:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      selectedDate == null
                          ? 'No seleccionada'
                          : 'Fecha: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  ElevatedButton.icon(
                    icon: Icon(Icons.calendar_today),
                    label: Text('Elegir Fecha'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2196F3),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate ?? DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 365)),
                      );
                      if (picked != null) setState(() => selectedDate = picked);
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text('Hora de inicio:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      selectedHoraInicio == null
                          ? 'No seleccionada'
                          : 'Inicio: ${selectedHoraInicio!.format(context)}',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  ElevatedButton.icon(
                    icon: Icon(Icons.access_time),
                    label: Text('Elegir Hora'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2196F3),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () async {
                      TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (picked != null) setState(() => selectedHoraInicio = picked);
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text('Hora de fin:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      selectedHoraFin == null
                          ? 'No seleccionada'
                          : 'Fin: ${selectedHoraFin!.format(context)}',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  ElevatedButton.icon(
                    icon: Icon(Icons.access_time),
                    label: Text('Elegir Hora'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2196F3),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () async {
                      TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: selectedHoraInicio ?? TimeOfDay.now(),
                      );
                      if (picked != null) setState(() => selectedHoraFin = picked);
                    },
                  ),
                ],
              ),
              SizedBox(height: 24),
              if (selectedArea != null && selectedHoraInicio != null && selectedHoraFin != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    'Precio total: Bs ${selectedArea!.costoReserva}',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[700], fontSize: 16),
                  ),
                ),
              Center(
                child: ElevatedButton(
                  onPressed: (selectedArea != null && selectedDate != null && selectedHoraInicio != null && selectedHoraFin != null && !_isLoading)
                      ? () async {
                          setState(() {
                            _isLoading = true;
                            mensaje = '';
                          });
                          try {
                            // TODO: Reemplaza este residenteId por el real del usuario logueado
                            final int residenteId = 1;
                            final reserva = Reserva(
                              id: null,
                              residenteId: residenteId,
                              areaId: selectedArea!.id!,
                              nombre: selectedArea!.nombre,
                              descripcion: selectedArea!.descripcion,
                              fechaReserva: selectedDate,
                              horaInicio: selectedHoraInicio!.format(context),
                              horaFin: selectedHoraFin!.format(context),
                            );
                            await _reservaService.createReserva(reserva);
                            setState(() {
                              mensaje = 'Reserva realizada para ${selectedArea!.nombre} el ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year} de ${selectedHoraInicio!.format(context)} a ${selectedHoraFin!.format(context)}. Precio: Bs ${selectedArea!.costoReserva}';
                            });
                            Future.delayed(const Duration(milliseconds: 1200), () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                '/consultarDisponibilidadArea',
                                (route) => route.isFirst,
                              );
                            });
                          } catch (e) {
                            setState(() {
                              mensaje = 'Error al realizar la reserva';
                            });
                          } finally {
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        }
                      : null,
                  child: _isLoading
                      ? SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : Text('Reservar', style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2196F3),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  ),
                ),
              ),
              if (mensaje.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: Text(
                      mensaje,
                      style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
