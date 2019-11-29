import 'package:flutter_bluetooth_serial_example/src/providers/database_creator.dart';

class Discapacidad{
  int id;
  String nombre;

  Discapacidad(this.id, this.nombre);
  
  Discapacidad.fromJson(Map<String, dynamic> json) {
    this.id = json[DataBaseCreator.id];
    this.nombre = json[DataBaseCreator.nombre];
  }
}