import 'package:flutter/material.dart';
import 'package:navbar/Servicios/database.dart';
import 'package:navbar/homeState.dart';
import 'package:navbar/login.dart';
import 'package:navbar/login_google.dart';
import 'package:navbar/searchBarCustom.dart';
import 'inicio.dart';
import 'cuidadoPrenatal.dart';
import 'hospitales.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHelper db = DatabaseHelper();
  await db.testDatabase;

  runApp(MyApp());
}//LLamar la base de datos al main

class MyApp extends StatefulWidget {

  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App con Navegación',
      home: LoginScreen(),
    );
  }
}

