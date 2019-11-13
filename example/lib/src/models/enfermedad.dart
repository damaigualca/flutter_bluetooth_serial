import 'package:flutter_bluetooth_serial_example/src/providers/database_creator.dart';

class Enfermedad{
  int id;
  String nombre;

  Enfermedad(this.id, this.nombre);
  
  Enfermedad.fromJson(Map<String, dynamic> json) {
    this.id = json[DataBaseCreator.id];
    this.nombre = json[DataBaseCreator.nombre];
  }
}