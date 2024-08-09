import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navbar/HomeState.dart';
import 'package:navbar/Servicios/database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';

  final ImagePicker _picker = ImagePicker();
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    _recorder.openRecorder();
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    super.dispose();
  }

  Future<void> _loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final String? idToken = googleAuth.idToken;
        final String? accessToken = googleAuth.accessToken;

        print(
            'Google User: ${googleUser.displayName}, ID Token: $idToken, Access Token: $accessToken');

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage()),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _loginWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final userData = await FacebookAuth.instance.getUserData();
        print('Facebook User: ${userData['name']}, Access Token: $accessToken');

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage()),
        );
      } else {
        print('Facebook login failed: ${result.status}');
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al iniciar sesión $e')),
      );
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      print('Picked image: ${pickedFile.path}');
    } else {
      print('No image selected.');
    }
  }

  Future<void> _recordAudio() async {
    if (_isRecording) {
      await _recorder.stopRecorder();
      setState(() {
        _isRecording = false;
      });
      print('Recording stopped.');
    } else {
      var status = await Permission.microphone.request();
      if (status.isGranted) {
        await _recorder.startRecorder(
          toFile: 'audio_record.aac',
        );
        setState(() {
          _isRecording = true;
        });
        print('Recording started.');
      } else {
        print('Microphone permission denied.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Inicio de Sesión')),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/img/Texto.png',
                          width: 250,
                        ),
                        Image.asset(
                          'assets/img/image.png',
                          width: 250,
                        ),
                      ],
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Usuario'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese su usuario';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _username = value!;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Contraseña'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese su contraseña';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _password = value!;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        DatabaseHelper db = DatabaseHelper();
                        bool isAuthenticated =
                            await db.authenticateUser(_username, _password);

                        if (isAuthenticated) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Inicio de sesión exitoso')),
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyHomePage()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Usuario o contraseña incorrectos')),
                          );
                        }
                      }
                    },
                    child: const Text('Iniciar Sesión'),
                  ),
                  const SizedBox(height: 20),
                  const Text("Iniciar sesión con:"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _loginWithGoogle,
                        child: const Text('Google'),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _loginWithFacebook,
                        child: const Text('Facebook'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: const Text('Usar Cámara'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _recordAudio,
                    child: Text(_isRecording ? 'Detener Grabación' : 'Grabar Audio'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navegar a la pantalla de registro
                    },
                    child: const Text('Registrar'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
