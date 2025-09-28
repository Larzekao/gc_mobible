import 'package:condominium_app/screens/homeResidente.dart';
import 'package:condominium_app/screens/login_screen.dart';
import 'package:condominium_app/screens/areas/consultarDisponibilidad_screen.dart';
import 'package:condominium_app/screens/areas/reservarArea_screen.dart';
import 'package:condominium_app/screens/areas/cancelarReserva_screen.dart';
import 'package:condominium_app/screens/ia/reconocimiento_facial_screen.dart';
import 'package:condominium_app/screens/ia/reconocimiento_placa_screen.dart';
import 'package:condominium_app/screens/ia/camera_preview_screen.dart';
import 'package:flutter/material.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Condominium',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/homeResidente': (context) => HomeResidente(),
        '/consultarDisponibilidadArea': (context) => ConsultarDisponibilidadScreen(),
        '/reservarArea': (context) => ReservarAreaScreen(),
        '/cancelarReservaArea': (context) => CancelarReservaScreen(),
        '/ia/reconocimientoFacial': (context) => const ReconocimientoFacialScreen(),
        '/ia/reconocimientoPlaca': (context) => const ReconocimientoPlacaScreen(),
        '/ia/cameraPreview': (context) => const CameraPreviewScreen(),
      },
    );
  }
}