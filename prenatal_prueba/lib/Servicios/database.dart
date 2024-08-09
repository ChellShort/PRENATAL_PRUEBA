
//import 'package:sqflite/sqflite.dart' y descargar la dependencia
//agregar dependencia en pubspec.yaml
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
//ignore: depend_on_referenced_packages
import 'package:path/path.dart';


//inicia la preparacion de base de datos con SQlite, en esta DB se describen
//Definicion de clase con instancia factory
//la clase database nos permite hacer una sola instancia de la clase para todo el proyecto y asi evitar multiples conexiones con la base de datos

//Se crea la base de datos
class DatabaseHelper {
  
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  //Cada Future<Database> es una ruta, future representa un valor que estara disponible en el futuro
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    //Await es una palabra reservada que permite esperar a que la funcion asincrona
    _database = await initDataBase();
    return _database!;
  }

  Future<Database> initDataBase() async {
    //Aqui se asegura de que la base de datos
    //se abra correctamente con el nombre 'my_db.db'
    String path = join(await getDatabasesPath(), 'prenatal.db');
    return await openDatabase(
      path,
      version: 1, 
      onCreate: _onCreate,
    );
  }

  //Crear las tablas

  Future _onCreate(Database db, int version) async {
    await db.execute(
      '''
        CREATE TABLE users (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nombre TEXT,
          password TEXT,
          fecha_nacimiento TEXT,
          primer_embarazo BOOLEAN,
          numero_embarazo INTEGER
        )
      '''
    );
    await db.execute(
      '''
        CREATE TABLE controles_prenatales (
          id_control INTEGER PRIMARY KEY AUTOINCREMENT,
          id_usuario INTEGER,
          examenes_clinicos INTEGER,
          visitas_ginecologicas INTEGER,
          imc FLOAT,
          talla FLOAT
        )
      '''
    );
    await db.execute(
      '''
        CREATE TABLE hospitales (
          id_hospital INTEGER PRIMARY KEY AUTOINCREMENT,
          nombre_hospital TEXT,
          direccion TEXT,
          telefono INTEGER
        )
      '''
    );
    await db.execute(
      '''
        CREATE TABLE examenes_laboratorio (
          id_examen INTEGER PRIMARY KEY AUTOINCREMENT,
          nombre_examen TEXT,
          descripcion TEXT,
          semana_asignada INTEGER
        )
      '''
    );
    await db.execute(
      '''
        CREATE TABLE archivos (
          id_archivo INTEGER PRIMARY KEY AUTOINCREMENT,
          id_usuario INTEGER,
          semana INTEGER,
          tipo_archivo INTEGER,
          ruta_archivo TEXT
        )
      '''
    );
  }

  Future<void> insertTestData() async {
    var db = await database;
    await db.insert('users', {
      'nombre': 'Maria',
      'password': '1234',
      'fecha_nacimiento': '1990-01-01',
      'primer_embarazo': '1',
      'numero_embarazos': '2',      
    }

    );
  }

  Future<bool> authenticateUser(String nombre, String password) async {
    var db = await database;
    var result = await db.query(
      'users',//nombre de la tabla
      where: 'nombre = ? AND password = ?',
      whereArgs: [nombre, password],
    );
    return result.isNotEmpty;
  }//database.dart

//Test DB
  Future<void> testDatabase() async {
    var db = await database;
    print('Base de datos: $db');

    //Insertar datos de prueba
    await insertTestData();

    //Leer datos de prueba
    var result = await db.query('users');
    if (kDebugMode) {
      print('Datos de prueba insertados: $result');
    }
  }

}