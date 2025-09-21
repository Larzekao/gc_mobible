import 'package:flutter/material.dart';
import '../../models/tarea.dart';
import '../../components/custom_text_field.dart';
import '../../components/custom_dropdown.dart';

class EditTareaScreen extends StatefulWidget {
  final Tarea tarea;
  EditTareaScreen({required this.tarea});

  @override
  _EditTareaScreenState createState() => _EditTareaScreenState();
}

class _EditTareaScreenState extends State<EditTareaScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreController;
  late TextEditingController _descripcionController;
  late String estado;
  DateTime? fechaVencimiento;

  // Lista de estados disponibles
  final List<String> estadoChoices = [
    'PENDIENTE',
    'PROGRESO', 
    'COMPLETADO',
  ];

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.tarea.nombre);
    _descripcionController = TextEditingController(text: widget.tarea.descripcion ?? '');
    estado = widget.tarea.estado;
    fechaVencimiento = widget.tarea.fechaVencimiento;
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Tarea', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.white)),
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
                      controller: _nombreController,
                      label: 'Nombre',
                      validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      controller: _descripcionController,
                      label: 'Descripción',
                      validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
                    ),
                    SizedBox(height: 16),
                    CustomDropdown<String>(
                      value: estado,
                      label: 'Estado',
                      items: estadoChoices.map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(_getEstadoDisplay(e), style: TextStyle(fontFamily: 'Montserrat')),
                      )).toList(),
                      onChanged: (value) => setState(() => estado = value ?? estadoChoices[0]),
                      validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
                    ),
                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: fechaVencimiento ?? DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) {
                          setState(() => fechaVencimiento = picked);
                        }
                      },
                      child: AbsorbPointer(
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.18),
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: TextFormField(
                            controller: TextEditingController(
                              text: fechaVencimiento != null 
                                ? fechaVencimiento!.toLocal().toString().split(' ')[0] 
                                : ''
                            ),
                            decoration: InputDecoration(
                              labelText: 'Fecha límite',
                              labelStyle: TextStyle(fontFamily: 'Montserrat'),
                              filled: true,
                              fillColor: Color(0xFFe3f2fd),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: Colors.transparent, width: 0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: Colors.transparent, width: 0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: Color(0xFF1976d2), width: 2),
                              ),
                              suffixIcon: Icon(Icons.calendar_today, color: Color(0xFF283593)),
                            ),
                            style: TextStyle(fontFamily: 'Montserrat'),
                          ),
                        ),
                      ),
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
                          // Crear tarea actualizada
                          final tareaActualizada = Tarea(
                            id: widget.tarea.id,
                            nombre: _nombreController.text,
                            descripcion: _descripcionController.text.isEmpty ? null : _descripcionController.text,
                            estado: estado,
                            fechaVencimiento: fechaVencimiento,
                            personal: widget.tarea.personal, // Mantener el personal original
                            creado: widget.tarea.creado,
                            actualizado: DateTime.now(),
                          );
                          
                          // Aquí puedes agregar la lógica para guardar la tarea
                          // Por ahora solo navega de vuelta con la tarea actualizada
                          Navigator.pop(context, tareaActualizada);
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

  String _getEstadoDisplay(String estado) {
    switch (estado) {
      case 'PENDIENTE':
        return 'Pendiente';
      case 'PROGRESO':
        return 'En Progreso';
      case 'COMPLETADO':
        return 'Completado';
      default:
        return estado;
    }
  }
}
