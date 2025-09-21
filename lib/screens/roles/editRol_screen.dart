import 'package:flutter/material.dart';
import '../../models/rol.dart';
import '../../components/custom_text_field.dart';

class EditRolScreen extends StatefulWidget {
  final Rol rol;
  EditRolScreen({required this.rol});

  @override
  _EditRolScreenState createState() => _EditRolScreenState();
}

class _EditRolScreenState extends State<EditRolScreen> {
  final _formKey = GlobalKey<FormState>();
  late String nombre;
  late TextEditingController _nombreController;

  @override
  void initState() {
  super.initState();
  nombre = widget.rol.nombre;
  _nombreController = TextEditingController(text: nombre);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Rol', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.white)),
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
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF283593),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        elevation: 6,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            nombre = _nombreController.text;
                          });
                          // Guardar cambios
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
