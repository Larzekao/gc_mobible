import 'package:flutter/material.dart';
import '../../models/regla.dart';
import '../../models/area_comun.dart';
import '../../components/custom_text_field.dart';

class CreateReglaScreen extends StatefulWidget {
  @override
  _CreateReglaScreenState createState() => _CreateReglaScreenState();
}

class _CreateReglaScreenState extends State<CreateReglaScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreController;
  late TextEditingController _descripcionController;
  
  bool activo = true;
  List<AreaComun> todasLasAreas = [
    AreaComun(id: 1, nombre: 'Piscina', descripcion: 'Área de piscina principal'),
    AreaComun(id: 2, nombre: 'Salón de eventos', descripcion: 'Salón para eventos sociales'),
    AreaComun(id: 3, nombre: 'Gimnasio', descripcion: 'Área de ejercicio y fitness'),
    AreaComun(id: 4, nombre: 'Terraza', descripcion: 'Área de terraza común'),
    AreaComun(id: 5, nombre: 'Jardín', descripcion: 'Jardines del condominio'),
  ];
  
  List<AreaComun> areasSeleccionadas = [];

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController();
    _descripcionController = TextEditingController();
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
        title: Text('Crear Regla', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.white)),
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
                    // Campo Nombre
                    CustomTextField(
                      label: 'Nombre',
                      controller: _nombreController,
                      validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
                    ),
                    SizedBox(height: 16),
                    
                    // Campo Descripción
                    Container(
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
                        controller: _descripcionController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          labelText: 'Descripción',
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
                        ),
                        style: TextStyle(fontFamily: 'Montserrat'),
                      ),
                    ),
                    SizedBox(height: 16),
                    
                    // Switch Estado Activo
                    Card(
                      elevation: 0,
                      color: Colors.indigo[50],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Estado Activo',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Switch(
                              value: activo,
                              onChanged: (value) => setState(() => activo = value),
                              activeColor: Color(0xFF283593),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    
                    // Selección de Áreas
                    Text(
                      'Áreas Aplicables',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF283593),
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: todasLasAreas.map((area) {
                          bool isSelected = areasSeleccionadas.any((a) => a.id == area.id);
                          return CheckboxListTile(
                            title: Text(
                              area.nombre,
                              style: TextStyle(fontFamily: 'Montserrat'),
                            ),
                            subtitle: area.descripcion != null 
                              ? Text(
                                  area.descripcion!,
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                )
                              : null,
                            value: isSelected,
                            activeColor: Color(0xFF283593),
                            onChanged: (bool? value) {
                              setState(() {
                                if (value == true) {
                                  areasSeleccionadas.add(area);
                                } else {
                                  areasSeleccionadas.removeWhere((a) => a.id == area.id);
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 24),
                    
                    // Botón Guardar
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF283593),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        elevation: 6,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Crear nueva regla
                          final nuevaRegla = Regla(
                            nombre: _nombreController.text,
                            descripcion: _descripcionController.text.isEmpty ? null : _descripcionController.text,
                            areas: List.from(areasSeleccionadas),
                            activo: activo,
                          );
                          
                          // Aquí implementarías la lógica para guardar la regla
                          // Por ahora solo navegamos de vuelta
                          
                          Navigator.pop(context, nuevaRegla);
                        }
                      },
                      child: Text(
                        'Guardar Regla', 
                        style: TextStyle(
                          fontFamily: 'Montserrat', 
                          fontWeight: FontWeight.bold, 
                          color: Colors.white, 
                          fontSize: 18
                        )
                      ),
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