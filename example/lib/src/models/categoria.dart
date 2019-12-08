import 'package:flutter_bluetooth_serial_example/src/providers/database_creator.dart';

class Categoria{
  int id;
  String nombre;
  String imagen;

  Categoria(
    this.id, 
    this.nombre,
    this.imagen,
  );
  
  Categoria.fromJson(Map<String, dynamic> json) {
    this.id = json[DataBaseCreator.id];
    this.nombre = json[DataBaseCreator.nombre];
    this.imagen = json[DataBaseCreator.imagen];
  }
}