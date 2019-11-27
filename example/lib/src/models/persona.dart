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
  String fechaNacimiento;
  String etnia;
  String viveCon;
  String imagen;
  int viaAcceso;
  bool poseeDiscapacidad;
  bool poseeCarnetDiscapacidad;
  int unidadAtencionId;

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
    this.imagen,
    this.viaAcceso,
    this.poseeDiscapacidad,
    this.poseeCarnetDiscapacidad,
    this.unidadAtencionId
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
    this.viaAcceso = json[DataBaseCreator.viaAcceso];
    this.imagen = json[DataBaseCreator.imagen];
    this.poseeDiscapacidad = json[DataBaseCreator.poseeDiscapacidad] == 1;
    this.poseeCarnetDiscapacidad = json[DataBaseCreator.poseeCarnetDiscapacidad] == 1;
    this.unidadAtencionId = json[DataBaseCreator.unidadAtencionId];
  }

  getImage(){
    if (this.imagen == ''){
      if(this.sexo == 'Femenino'){
        return 'assets/images/avatar-femenino.jpg';
      }else{
        return 'assets/images/avatar-masculino.jpg';
      }
    }else{
      // Implentar la decodificacion del string a imagen usando base 64
    }
  }

  getEdad(){
    DateTime currentDate = DateTime.now();
    DateTime birthDate = DateTime.parse(this.fechaNacimiento);
    Duration dur = currentDate.difference(birthDate);
    return (dur.inDays/365).floor().toString();
  }

  getFullName(){
    return this.nombres + ' ' + this.apellidos;
  }

  getSexState(){
    if(this.sexo == 'masculino' || this.sexo == 'Masculino' || this.sexo == 'MASCULINO'){
      return 1;
    }else{
      return 0;
    }
  }

  getEdadInDateTimeFormat(){
    if(this.fechaNacimiento != ''){
      return DateTime.parse(this.fechaNacimiento);
    }else{
      return DateTime.now();
    }
    
  }
}