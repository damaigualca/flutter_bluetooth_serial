import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';

Database db;

class DataBaseCreator{

  //Unidad Atencion
  static const unidadAtencionTable = 'UNIDADES_ATENCION';
  static const id = 'id';
  static const nombreUnidad = 'name';
  static const canton = 'canton';
  static const ciudad = 'ciudad';
  static const parroquia = 'parroquia';
  static const sector = 'sector';
  static const tecnicoEncargado = 'tecnico_encargado';
  static const celularTecnico = 'celular_tecnico';
  static const correo = 'correo';


  // Persona
  static const personaTable = "PERSONAS";
  static const nombres = 'nombres';
  static const apellidos = "apellidos";
  static const cedula = "cedula";
  static const sexo = "sexo";
  static const telefonoContacto = "telefono_contacto";
  static const direccion = "direccion";
  static const fechaNacimiento ="fecha_nacimiento";
  static const etnia = "etnia";
  static const viveCon = "vive_con";
  static const tipoCasa = "tipo_casa";
  static const tipoVivienda = "tipo_vivienda";
  static const estructuraVivienda = "estructura_vivienda";
  static const viaAcceso = "via_acceso";
  static const poseeDiscapacidad = "posee_discapacidad";
  static const tipoServicio = "tipo_servicio";
  static const poseeCarnetDiscapacidad = "posee_carnet_discapacidad";
  static const unidadAtencionId = "id_unidad_atencion";

  // Enfermedad
  static const enfermedadTable = "ENFERMEDADES";
  static const nombre = "nombre";

  // Enfermedad Persona
  static const enfermedadPersonaTable = "ENFERMEDAD_PERSONA";
  static const nivelEnfermedad = "nivel_enfermedad";
  static const tipoTratamiento = "tipo_tratamiento";
  static const recomendacion = "recomendacion";
  static const lugarAtencion = "lugar_atencion";
  static const enfermedadId = "id_enfermedad";
  static const personaId = "id_persona";

  // Discapaciadad
  static const discapacidadTable = "DISCAPACIDADES";

  // Discapacidad Persona
  static const discapacidadPersonaTable = "DISCAPACIDAD_PERSONA";
  static const discapacidadId = "id_discapacidad";
  static const porcentaje = "porcentaje";

  // Terapia
  static const terapiaTable = "TERAPIAS";
  static const fecha = "fecha";
  static const tipoTerapia = "tipo_terapia";
  static const repeticionesAsignadas = "repeticiones_asignadas";
  static const observaciones = "observaciones";
  static const completado = "completado";
  static const tiempoEmpleado = "tiempo_empleado";
  static const repeticionesCorrectas = "repeticiones_correctas";



  static void databaseLog(String functionName, String sql,
  [List<Map<String, dynamic>> selectQueryResult, int insertAndUpdateQueryResult]){
    print(functionName);
    print(sql);
    if(selectQueryResult != null){
      print(selectQueryResult);
    }else if(insertAndUpdateQueryResult != null){
      print(insertAndUpdateQueryResult);
    }
  }

  Future<void> createUnidadAtencionTable(Database db) async {
    final unidadAtencionSql = '''CREATE TABLE $unidadAtencionTable
    (
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $nombreUnidad TEXT,
      $canton TEXT,
      $ciudad TEXT,
      $parroquia TEXT,
      $sector TEXT,
      $tecnicoEncargado TEXT,
      $celularTecnico TEXT,
      $correo TEXT
    )''';
    await db.execute(unidadAtencionSql);
  }

  Future<void> createPersonaTable(Database db) async {
    final personaSql = '''CREATE TABLE $personaTable
    (
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $nombres TEXT,
      $apellidos TEXT,
      $cedula TEXT,
      $sexo TEXT,
      $telefonoContacto TEXT,
      $direccion TEXT,
      $fechaNacimiento TEXT,
      $etnia TEXT,
      $viveCon TEXT,
      $tipoCasa TEXT,
      $tipoVivienda TEXT,
      $estructuraVivienda TEXT,
      $viaAcceso BIT NOT NULL,
      $poseeDiscapacidad BIT NOT NULL,
      $tipoServicio TEXT,
      $poseeCarnetDiscapacidad BIT NOT NULL,
      $unidadAtencionId INTEGER NOT NULL,
      FOREIGN KEY($unidadAtencionId) REFERENCES $unidadAtencionTable($id)
    )''';
    await db.execute(personaSql);
  }

  Future<void> createDiscapacidadTable(Database db) async {
    final discapacidadSql = '''CREATE TABLE $discapacidadTable
    (
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $nombre TEXT
    )''';
    await db.execute(discapacidadSql);
  }

  Future<void> createDiscapacidadPersonaTable(Database db) async {
    final discapacidadPersonaSql = '''CREATE TABLE $discapacidadPersonaTable
    (
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $porcentaje REAL,
      $personaId INTEGER NOT NULL,
      $unidadAtencionId INTEGER NOT NULL,
      FOREIGN KEY($unidadAtencionId) REFERENCES $unidadAtencionTable($id),
      FOREIGN KEY($personaId) REFERENCES $personaTable($id)
    )''';
    await db.execute(discapacidadPersonaSql);
  }

  Future<void> createEnfermedadTable(Database db) async {
    final enfermedadSql = '''CREATE TABLE $enfermedadTable
    (
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $nombre TEXT
    )''';
    await db.execute(enfermedadSql);
  }

  Future<void> createEnfermedadPersonaTable(Database db) async {
    final enfermedadPersonaSql = '''CREATE TABLE $enfermedadPersonaTable
    (
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $nivelEnfermedad TEXT,
      $tipoTratamiento TEXT,
      $recomendacion TEXT,
      $lugarAtencion TEXT,
      $personaId INTEGER NOT NULL,
      $enfermedadId INTEGER NOT NULL,
      FOREIGN KEY($enfermedadId) REFERENCES $enfermedadTable($id),
      FOREIGN KEY($personaId) REFERENCES $personaTable($id)
    )''';
    await db.execute(enfermedadPersonaSql);
  }

  Future<void> createTerapiaTable(Database db) async {
    final terapiaSql = '''CREATE TABLE $terapiaTable
    (
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $fecha TEXT,
      $tipoTerapia TEXT,
      $repeticionesAsignadas TEXT,
      $observaciones TEXT,
      $completado BIT NOT NULL,
      $tiempoEmpleado TEXT,
      $repeticionesCorrectas INTEGER,
      $personaId INTEGER NOT NULL,
      FOREIGN KEY($personaId) REFERENCES $personaTable($id)
    )''';
    await db.execute(terapiaSql);
  }


  Future<void> initDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, 'vinculacion_db.db');

    // Verificar si existe la bd
    var exists = await databaseExists(path);
    if (!exists){
      // Deberia pasar solo la primera vez que lances tu aplicacion
      print("Creando una nueva copia de asset");
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {
      }
      // Copia de asset
      ByteData data = await rootBundle.load(join("assets", "vinculacion_db.db"));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Escribe y vacia los bytes escritos
      await File(path).writeAsBytes(bytes, flush: true);
    } else{
      print("Abriendo db existente");
    }
    db = await openDatabase(path, version: 3);
    print(db);
  }
}