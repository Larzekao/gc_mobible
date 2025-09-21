import 'package:flutter/material.dart';
import '../../models/residente.dart';
import '../../components/custom_text_field.dart';

class CreateResidenteScreen extends StatefulWidget {
  @override
  _CreateResidenteScreenState createState() => _CreateResidenteScreenState();
}

class _CreateResidenteScreenState extends State<CreateResidenteScreen> {
  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController();
    _apellidosController = TextEditingController();
    _dniController = TextEditingController();
    _telefonoController = TextEditingController();
    _correoController = TextEditingController();
    _sexoController = TextEditingController();
    _tipoController = TextEditingController();
    _residenciaController = TextEditingController();
  }
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreController;
  late TextEditingController _apellidosController;
  late TextEditingController _dniController;
  late TextEditingController _telefonoController;
  late TextEditingController _correoController;
  late TextEditingController _sexoController;
  late TextEditingController _tipoController;
  late TextEditingController _residenciaController;
  bool activo = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Residente', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.white)),
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
                      label: 'Apellidos',
                      controller: _apellidosController,
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
                      label: 'Sexo',
                      controller: _sexoController,
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      label: 'Tipo',
                      controller: _tipoController,
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      label: 'Residencia',
                      controller: _residenciaController,
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
                          // Aquí iría la lógica para guardar el residente
                          Navigator.pop(context);
                        }
                      },
                      child: Text('Guardar', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18)),
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
