import 'package:flutter/material.dart';
import '../../models/usuario.dart';
import '../../models/rol.dart';
import '../../components/custom_text_field.dart';
import '../../components/custom_dropdown.dart';
import '../../components/custom_switch_row.dart';
import '../../components/custom_button.dart';

class CreateUsuarioScreen extends StatefulWidget {
  @override
  _CreateUsuarioScreenState createState() => _CreateUsuarioScreenState();
}

class _CreateUsuarioScreenState extends State<CreateUsuarioScreen> {
  final _formKey = GlobalKey<FormState>();
  final _correoController = TextEditingController();
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _telefonoController = TextEditingController();

  Rol? _selectedRol;
  bool _isActive = true;
  bool _isStaff = false;

  // Simulación de roles, reemplaza por tu lista real
  final List<Rol> _roles = [
    Rol(id: 1, nombre: 'Administrador'),
    Rol(id: 2, nombre: 'Residente'),
    Rol(id: 3, nombre: 'Personal'),
  ];

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      Usuario usuario = Usuario(
        correo: _correoController.text,
        nombre: _nombreController.text,
        apellido: _apellidoController.text,
        telefono: _telefonoController.text,
        rol: _selectedRol,
        isActive: _isActive,
        isStaff: _isStaff,
      );
      // Aquí puedes llamar a tu servicio para guardar el usuario
      print(usuario.toJson());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuario creado correctamente')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Usuario', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Color(0xFF283593),
        elevation: 0,
        iconTheme: IconThemeData(color: const Color.fromARGB(255, 175, 186, 201), size: 28),
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
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            color: Colors.white.withOpacity(0.97),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
              child: Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Text('Crear Usuario', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, fontSize: 22, color: Color(0xFF283593)), textAlign: TextAlign.center),
                    SizedBox(height: 18),
                    CustomTextField(
                      controller: _correoController,
                      label: 'Correo',
                      validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 12),
                    CustomTextField(
                      controller: _nombreController,
                      label: 'Nombre',
                    ),
                    SizedBox(height: 12),
                    CustomTextField(
                      controller: _apellidoController,
                      label: 'Apellido',
                    ),
                    SizedBox(height: 12),
                    CustomTextField(
                      controller: _telefonoController,
                      label: 'Teléfono',
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 12),
                    CustomDropdown<Rol>(
                      value: _selectedRol,
                      label: 'Rol',
                      items: _roles
                          .map((rol) => DropdownMenuItem(
                                value: rol,
                                child: Text(rol.nombre, style: TextStyle(fontFamily: 'Montserrat')),
                              ))
                          .toList(),
                      onChanged: (rol) => setState(() => _selectedRol = rol),
                      validator: (value) => value == null ? 'Selecciona un rol' : null,
                    ),
                    SizedBox(height: 12),
                    CustomSwitchRow(
                      isActive: _isActive,
                      isStaff: _isStaff,
                      onActiveChanged: (val) => setState(() => _isActive = val),
                      onStaffChanged: (val) => setState(() => _isStaff = val),
                    ),
                    SizedBox(height: 24),
                    CustomButton(
                      text: 'Crear Usuario',
                      onPressed: _submit,
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

  @override
  void dispose() {
    _correoController.dispose();
    _nombreController.dispose();
    _apellidoController.dispose();
    _telefonoController.dispose();
    super.dispose();
  }
}