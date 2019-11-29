import 'package:flutter_bluetooth_serial_example/src/models/enfermedad.dart';
import 'package:flutter_bluetooth_serial_example/src/models/persona.dart';
import 'package:flutter_bluetooth_serial_example/src/providers/database_creator.dart';

class EnfermedadPersona{
  int id;
  String nivelEnfermedad;
  String tipoTratamiento;
  String recomendacion;
  String lugarAtencion;
  String nombre;
  int idEnfermedad;
  int idPersona;
  Persona persona;
  Enfermedad enfermedad;

  EnfermedadPersona(
    this.nivelEnfermedad,
    this.tipoTratamiento,
    this.recomendacion,
    this.lugarAtencion,
    this.nombre,
    this.idEnfermedad,
    this.idPersona,
  );

  EnfermedadPersona.fromJson(Map<String, dynamic> json) {
    this.id = json[DataBaseCreator.id];
    this.nivelEnfermedad = json[DataBaseCreator.nivelEnfermedad];
    this.tipoTratamiento = json[DataBaseCreator.tipoTratamiento];
    this.recomendacion = json[DataBaseCreator.recomendacion];
    this.lugarAtencion = json[DataBaseCreator.lugarAtencion];
    this.idEnfermedad = json[DataBaseCreator.enfermedadId];
    this.idPersona = json[DataBaseCreator.personaId];
    this.nombre = json[DataBaseCreator.nombre];
  }
}