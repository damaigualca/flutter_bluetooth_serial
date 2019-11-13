import 'package:flutter_bluetooth_serial_example/src/models/unidad_atencion.dart';
import 'package:flutter_bluetooth_serial_example/src/providers/database_creator.dart';

class Persona{
  int id;
  String nombres;
  String apellidos;
  String cedula;
  String sexo;
  String telefonoContacto;
  String direccion;
  DateTime fechaNacimiento;
  String etnia;
  String viveCon;
  String tipoCasa;
  String tipoVivienda;
  String estructuraVivienda;
  bool poseeDiscapacidad;
  String tipoServicio;
  bool poseeCarnetDiscapacidad;
  UnidadAtencion unidadAtencion;

  Persona(
    this.id,
    this.nombres,
    this.apellidos,
    this.cedula,
    this.sexo,
    this.telefonoContacto,
    this.direccion,
    this.fechaNacimiento,
    this.etnia,
    this.viveCon,
    this.tipoCasa,
    this.tipoVivienda,
    this.estructuraVivienda,
    this.poseeDiscapacidad,
    this.tipoServicio,
    this.poseeCarnetDiscapacidad,
    this.unidadAtencion
  );

  Persona.fromJson(Map<String, dynamic> json) {
    this.id = json[DataBaseCreator.id];
    this.nombres = json[DataBaseCreator.nombres];
    this.apellidos = json[DataBaseCreator.apellidos];
    this.cedula = json[DataBaseCreator.cedula];
    this.sexo = json[DataBaseCreator.sexo];
    this.telefonoContacto = json[DataBaseCreator.telefonoContacto];
    this.direccion = json[DataBaseCreator.direccion];
    this.fechaNacimiento = json[DataBaseCreator.fechaNacimiento];
    this.etnia = json[DataBaseCreator.etnia];
    this.viveCon = json[DataBaseCreator.viveCon];
    this.tipoCasa = json[DataBaseCreator.tipoCasa];
    this.tipoVivienda = json[DataBaseCreator.tipoVivienda];
    this.estructuraVivienda = json[DataBaseCreator.estructuraVivienda];
    this.poseeDiscapacidad = json[DataBaseCreator.poseeDiscapacidad] == 1;
    this.tipoServicio = json[DataBaseCreator.tipoServicio];
    this.poseeCarnetDiscapacidad = json[DataBaseCreator.poseeCarnetDiscapacidad] == 1;
    this.unidadAtencion.id = json[DataBaseCreator.unidadAtencionId];
  }
}