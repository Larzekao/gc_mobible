import 'package:flutter/material.dart';

class ReconocimientoPlacaScreen extends StatelessWidget {
  const ReconocimientoPlacaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reconocimiento de Placa'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.directions_car, size: 80, color: Colors.teal),
            SizedBox(height: 24),
            Text(
              'Reconocimiento de Placa',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Aquí irá la funcionalidad de reconocimiento de placa vehicular.',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),
            ElevatedButton.icon(
              icon: Icon(Icons.camera_alt),
              label: Text('Iniciar reconocimiento'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/ia/cameraPreview');
              },
            ),
          ],
        ),
      ),
    );
  }
}
