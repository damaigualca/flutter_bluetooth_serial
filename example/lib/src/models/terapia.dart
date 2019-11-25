import 'package:flutter_bluetooth_serial_example/src/models/persona.dart';
import 'package:flutter_bluetooth_serial_example/src/providers/database_creator.dart';

class Terapia{
  int id;
  String fecha;
  String tipoTerapia;
  int repeticionesAsignadas;
  String observaciones;
  bool completado;
  String tiempoEmpleado;
  int repeticionesCorrectas;
  int repeticionesFallidas;
  int personaId;
  Persona persona;

  Terapia(
    this.fecha,
    this.tipoTerapia,
    this.repeticionesAsignadas,
    this.observaciones,
    this.completado,
    this.tiempoEmpleado,
    this.repeticionesCorrectas,
    this.repeticionesFallidas,
    this.personaId,
    this.persona,
  );

  Terapia.fromJson(Map<String, dynamic> json) {
    this.id = json[DataBaseCreator.id];
    this.fecha = json[DataBaseCreator.fecha];
    this.tipoTerapia = json[DataBaseCreator.tipoTerapia];
    this.repeticionesAsignadas = json[DataBaseCreator.repeticionesAsignadas];
    this.observaciones = json[DataBaseCreator.observaciones];
    this.completado = json[DataBaseCreator.completado] == 1;
    this.tiempoEmpleado = json[DataBaseCreator.tiempoEmpleado];
    this.repeticionesCorrectas = json[DataBaseCreator.fechaNacimiento];
    this.repeticionesFallidas = json[DataBaseCreator.repeticionesFallidas];
    this.personaId = json[DataBaseCreator.personaId];
  }

  getImageFromTerapiaType(){
    if (this.tipoTerapia == 'ESCALERA'){
      return 'assets/images/escalera.jpg';
    } else if(this.tipoTerapia == 'PIEZAS'){
      return 'assets/images/piezas.jpg';
    } else if(this.tipoTerapia == 'RECORRIDO') {
      return 'assets/images/recorrido.jpg';
    } else if(this.tipoTerapia == 'FOCOS'){
      return 'assets/images/focos.jpg';
    } else {
      return 'assets/images/escalera.jpg';
    }
  }

  getNameFromTerapiaType(){
    if (this.tipoTerapia == 'ESCALERA'){
      return 'Terapia 1';
    } else if(this.tipoTerapia == 'PIEZAS'){
      return 'Terapia 2';
    } else if(this.tipoTerapia == 'RECORRIDO') {
      return 'Terapia 3';
    } else if(this.tipoTerapia == 'FOCOS'){
      return 'Terapia 4';
    } else {
      return 'Otro';
    }
  }
}