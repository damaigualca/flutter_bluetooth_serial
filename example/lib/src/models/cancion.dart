import 'package:flutter_bluetooth_serial_example/src/providers/database_creator.dart';

class Cancion{
  int id;
  String nombre;
  String imagen;
  String codigoArduino;

  Cancion(
    this.id, 
    this.nombre,
    this.imagen,
    this.codigoArduino
  );
  
  Cancion.fromJson(Map<String, dynamic> json) {
    this.id = json[DataBaseCreator.id];
    this.nombre = json[DataBaseCreator.nombre];
    this.imagen = json[DataBaseCreator.imagen];
    this.codigoArduino = json[DataBaseCreator.codigoArduino];
  }
}