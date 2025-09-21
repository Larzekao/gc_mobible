import 'package:flutter/material.dart';
import '../../models/personal.dart';
import '../../components/custom_text_field.dart';

class EditPersonalScreen extends StatefulWidget {
  final Personal personal;
  EditPersonalScreen({required this.personal});

  @override
  _EditPersonalScreenState createState() => _EditPersonalScreenState();
}

class _EditPersonalScreenState extends State<EditPersonalScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreController;
  late TextEditingController _apellidoController;
  late TextEditingController _dniController;
  late TextEditingController _telefonoController;
  late TextEditingController _correoController;
  late TextEditingController _direccionController;
  late TextEditingController _puestoController;
  late TextEditingController _estadoController;
  late bool activo;
  DateTime? _fechaNacimiento;
  DateTime? _fechaContratacion;
  DateTime? _fechaSalida;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.personal.nombre);
    _apellidoController = TextEditingController(text: widget.personal.apellido);
    _dniController = TextEditingController(text: widget.personal.dni);
    _telefonoController = TextEditingController(text: widget.personal.telefono ?? '');
    _correoController = TextEditingController(text: widget.personal.correo ?? '');
    _direccionController = TextEditingController(text: widget.personal.direccion ?? '');
    _puestoController = TextEditingController(text: widget.personal.puesto ?? '');
    _estadoController = TextEditingController(text: widget.personal.estado ?? '');
    activo = widget.personal.activo;
    _fechaNacimiento = widget.personal.fechaNacimiento;
    _fechaContratacion = widget.personal.fechaContratacion;
    _fechaSalida = widget.personal.fechaSalida;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Personal', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Color(0xFF283593),
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
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextField(
                      label: 'Nombre',
                      controller: _nombreController,
                      validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      label: 'Apellido',
                      controller: _apellidoController,
                      validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      label: 'DNI',
                      controller: _dniController,
                      validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      label: 'Teléfono',
                      controller: _telefonoController,
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      label: 'Correo',
                      controller: _correoController,
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      label: 'Dirección',
                      controller: _direccionController,
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      label: 'Puesto',
                      controller: _puestoController,
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      label: 'Estado',
                      controller: _estadoController,
                      validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
                    ),
                    SizedBox(height: 16),
                    ListTile(
                      title: Text('Fecha de Nacimiento', style: TextStyle(fontFamily: 'Montserrat', color: Color(0xFF283593))),
                      subtitle: Text(_fechaNacimiento != null ? _fechaNacimiento!.toLocal().toString().split(' ')[0] : 'Seleccionar fecha'),
                      trailing: Icon(Icons.calendar_today, color: Color(0xFF283593)),
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: _fechaNacimiento ?? DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) setState(() => _fechaNacimiento = picked);
                      },
                    ),
                    SizedBox(height: 16),
                    ListTile(
                      title: Text('Fecha de Contratación', style: TextStyle(fontFamily: 'Montserrat', color: Color(0xFF283593))),
                      subtitle: Text(_fechaContratacion != null ? _fechaContratacion!.toLocal().toString().split(' ')[0] : 'Seleccionar fecha'),
                      trailing: Icon(Icons.calendar_today, color: Color(0xFF283593)),
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: _fechaContratacion ?? DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) setState(() => _fechaContratacion = picked);
                      },
                    ),
                    SizedBox(height: 16),
                    ListTile(
                      title: Text('Fecha de Salida', style: TextStyle(fontFamily: 'Montserrat', color: Color(0xFF283593))),
                      subtitle: Text(_fechaSalida != null ? _fechaSalida!.toLocal().toString().split(' ')[0] : 'Seleccionar fecha'),
                      trailing: Icon(Icons.calendar_today, color: Color(0xFF283593)),
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: _fechaSalida ?? DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) setState(() => _fechaSalida = picked);
                      },
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Activo', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Color(0xFF283593))),
                        Switch(
                          value: activo,
                          activeColor: Color(0xFF283593),
                          onChanged: (value) => setState(() => activo = value),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF283593),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        elevation: 6,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Aquí iría la lógica para guardar los cambios
                          Navigator.pop(context);
                        }
                      },
                      child: Text('Guardar Cambios', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
