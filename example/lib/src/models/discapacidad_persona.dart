import 'package:flutter_bluetooth_serial_example/src/models/discapacidad.dart';
import 'package:flutter_bluetooth_serial_example/src/models/persona.dart';
import 'package:flutter_bluetooth_serial_example/src/providers/database_creator.dart';

class DiscapacidadPersona{
  int id;
  double porcentaje;
  String descripcion;
  String nombre;
  int idDiscapacidad;
  int idPersona;
  Persona persona;
  Discapacidad discapacidad;

  DiscapacidadPersona(
    this.porcentaje,
    this.descripcion,
    this.nombre,
    this.idDiscapacidad,
    this.idPersona,
  );

  DiscapacidadPersona.fromJson(Map<String, dynamic> json) {
    this.id = json[DataBaseCreator.id];
    this.porcentaje = json[DataBaseCreator.porcentaje];
    this.descripcion = json[DataBaseCreator.descripcion];
    this.nombre = json[DataBaseCreator.nombre];
    this.idDiscapacidad = json[DataBaseCreator.discapacidadId];
    this.idPersona = json[DataBaseCreator.personaId];
  }
}