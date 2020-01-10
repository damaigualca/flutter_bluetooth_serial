import 'package:flutter_bluetooth_serial_example/src/models/categoria.dart';
import 'package:flutter_bluetooth_serial_example/src/models/persona.dart';
import 'package:flutter_bluetooth_serial_example/src/providers/database_creator.dart';

class PreferenciaMultimedia{
  int id;
  int idPersona;
  int idCategoria;
  Categoria categoria;
  Persona persona;
  String nombre;

  PreferenciaMultimedia(
    this.id, 
    this.idPersona,
    this.idCategoria
  );
  
  PreferenciaMultimedia.fromJson(Map<String, dynamic> json) {
    this.id = json[DataBaseCreator.id];
    this.idCategoria = json[DataBaseCreator.categoriaId];
    this.idPersona = json[DataBaseCreator.personaId];
    this.nombre = json[DataBaseCreator.nombre];
  }
}