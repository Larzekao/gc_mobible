import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  bool _isLoading = false;
  bool _obscurePassword = true;
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2196F3), Color(0xFF21CBF3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Bienvenido',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[700],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Inicia sesión',
                          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                        ),
                        SizedBox(height: 32),
                        // Campo Email
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                          ),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Email es requerido';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        // Campo Password
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            labelText: 'Contraseña',
                            prefixIcon: Icon(Icons.lock),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                            suffixIcon: IconButton(
                              icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Contraseña es requerida';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 18),
                        // Mensaje de Error
                        if (_errorMessage.isNotEmpty)
                          Container(
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: Colors.red.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              _errorMessage,
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        SizedBox(height: 8),
                        // Botón Login
                        SizedBox(
                          width: 200,
                          height: 48,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              backgroundColor: const Color.fromARGB(255, 11, 73, 135),
                            ),
                            onPressed: _isLoading ? null : _login,
                            child: _isLoading
                                ? CircularProgressIndicator(color: const Color.fromARGB(255, 255, 255, 255))
                                : Text('Iniciar Sesión', style: TextStyle(fontSize: 18, color: Colors.white)),
                          ),
                        ),
                        SizedBox(height: 18),
                        // Link a registro
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: Text('¿No tienes cuenta? Regístrate'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }




  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      try {
        // Simular llamada a API
        await Future.delayed(Duration(seconds: 2));
        
        final email = _emailController.text;
        final password = _passwordController.text;
        
        // Aquí harías la llamada real a tu API
        if (email == 'admin@admin.com' && password == '123456') {
          // Login exitoso
          Navigator.pushReplacementNamed(context, '/homeAdministrador');
        } else {
          setState(() {
            _errorMessage = 'Email o contraseña incorrectos';
          });
        }
      } catch (e) {
        print('Login error: ' + e.toString());
        setState(() {
          _errorMessage = 'Error de conexión. Intenta nuevamente.';
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}