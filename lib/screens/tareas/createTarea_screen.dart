import 'package:flutter/material.dart';
import '../../models/tarea.dart';
import '../../components/custom_text_field.dart';
import '../../components/custom_dropdown.dart';

class CreateTareaScreen extends StatefulWidget {
  @override
  _CreateTareaScreenState createState() => _CreateTareaScreenState();
}

class _CreateTareaScreenState extends State<CreateTareaScreen> {
  final _formKey = GlobalKey<FormState>();
  String nombre = '';
  String descripcion = '';
  String estado = ESTADO_CHOICES[0];
  DateTime? fechaVencimiento;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Tarea', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.white)),
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
                      controller: TextEditingController(text: nombre),
                      label: 'Nombre',
                      validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      controller: TextEditingController(text: descripcion),
                      label: 'Descripción',
                      validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(height: 16),
                    CustomDropdown<String>(
                      value: estado,
                      label: 'Estado',
                      items: ESTADO_CHOICES.map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e, style: TextStyle(fontFamily: 'Montserrat')),
                      )).toList(),
                      onChanged: (value) => setState(() => estado = value ?? ESTADO_CHOICES[0]),
                      validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
                    ),
                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) {
                          setState(() => fechaVencimiento = picked);
                        }
                      },
                      child: AbsorbPointer(
                        child: CustomTextField(
                          controller: TextEditingController(text: fechaVencimiento != null ? fechaVencimiento!.toLocal().toString().split(' ')[0] : ''),
                          label: 'Fecha límite',
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    // Eliminado campo 'activo'
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
                          // Guardar tarea
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
