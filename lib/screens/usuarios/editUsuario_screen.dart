import 'package:flutter/material.dart';
import '../../models/usuario.dart';
import '../../models/rol.dart';
import '../../components/custom_text_field.dart';
import '../../components/custom_dropdown.dart';
import '../../components/custom_switch_row.dart';
import '../../components/custom_button.dart';

class EditUsuarioScreen extends StatefulWidget {
  final Usuario usuario;

  EditUsuarioScreen({required this.usuario});

  @override
  _EditUsuarioScreenState createState() => _EditUsuarioScreenState();
}

class _EditUsuarioScreenState extends State<EditUsuarioScreen> {
  late TextEditingController _correoController;
  late TextEditingController _nombreController;
  late TextEditingController _apellidoController;
  late TextEditingController _telefonoController;

  Rol? _selectedRol;
  bool _isActive = true;
  bool _isStaff = false;

  // Simulación de roles, reemplaza por tu lista real
  final List<Rol> _roles = [
    Rol(id: 1, nombre: 'Administrador'),
    Rol(id: 2, nombre: 'Residente'),
    Rol(id: 3, nombre: 'Personal'),
  ];

  @override
  void initState() {
    super.initState();
    _correoController = TextEditingController(text: widget.usuario.correo);
    _nombreController = TextEditingController(text: widget.usuario.nombre ?? '');
    _apellidoController = TextEditingController(text: widget.usuario.apellido ?? '');
    _telefonoController = TextEditingController(text: widget.usuario.telefono ?? '');
    _selectedRol = widget.usuario.rol;
    _isActive = widget.usuario.isActive;
    _isStaff = widget.usuario.isStaff;
  }

  void _submit() {
    if (_correoController.text.isEmpty) return;
    // Aquí puedes llamar a tu servicio para actualizar el usuario
    Usuario usuarioEditado = Usuario(
      id: widget.usuario.id,
      correo: _correoController.text,
      nombre: _nombreController.text,
      apellido: _apellidoController.text,
      telefono: _telefonoController.text,
      rol: _selectedRol,
      isActive: _isActive,
      isStaff: _isStaff,
    );
    print(usuarioEditado.toJson());
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Usuario editado correctamente')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Usuario', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.white)),
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
              child: ListView(
                shrinkWrap: true,
                children: [
                  Text('Editar Usuario', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, fontSize: 22, color: Color(0xFF283593)), textAlign: TextAlign.center),
                  SizedBox(height: 18),
                  CustomTextField(
                    controller: _correoController,
                    label: 'Correo',
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
                    text: 'Guardar Cambios',
                    onPressed: _submit,
                  ),
                ],
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