import 'package:flutter/material.dart';

class ReconocimientoFacialScreen extends StatelessWidget {
  const ReconocimientoFacialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reconocimiento Facial'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.face_retouching_natural, size: 80, color: Colors.deepPurple),
            SizedBox(height: 24),
            Text(
              'Reconocimiento Facial',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Aquí irá la funcionalidad de reconocimiento facial.',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),
            ElevatedButton.icon(
              icon: Icon(Icons.camera_alt),
              label: Text('Iniciar reconocimiento'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
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
