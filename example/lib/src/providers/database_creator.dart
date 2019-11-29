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
  static const viaAcceso = "via_acceso";
  static const poseeDiscapacidad = "posee_discapacidad";
  static const imagen = "imagen";
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
  static const descripcion = "descripcion";

  // Terapia
  static const terapiaTable = "TERAPIAS";
  static const fecha = "fecha";
  static const tipoTerapia = "tipo_terapia";
  static const repeticionesAsignadas = "repeticiones_asignadas";
  static const observaciones = "observaciones";
  static const completado = "completado";
  static const tiempoEmpleado = "tiempo_empleado";
  static const repeticionesCorrectas = "repeticiones_correctas";
  static const repeticionesFallidas = "repeticiones_fallidas";



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
    db = await openDatabase(path, version: 5);
    print(db);
  }
}