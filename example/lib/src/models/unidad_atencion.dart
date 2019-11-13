
import 'package:flutter_bluetooth_serial_example/src/providers/database_creator.dart';

class UnidadAtencion{
  int id;
  String nombreUnidad;
  String canton;
  String ciudad;
  String parroquia;
  String sector;
  String tecnicoEncargado;
  String celularTecnico;
  String correo;

  UnidadAtencion(
    this.id,
    this.nombreUnidad,
    this.canton,
    this.ciudad,
    this.parroquia,
    this.sector,
    this.tecnicoEncargado,
    this.celularTecnico,
    this.correo
  );

  UnidadAtencion.fromJson(Map<String, dynamic> json) {
    this.id = json[DataBaseCreator.id];
    this.nombreUnidad = json[DataBaseCreator.nombreUnidad];
    this.canton = json[DataBaseCreator.canton];
    this.ciudad = json[DataBaseCreator.ciudad];
    this.parroquia = json[DataBaseCreator.parroquia];
    this.sector = json[DataBaseCreator.sector];
    this.tecnicoEncargado = json[DataBaseCreator.tecnicoEncargado];
    this.celularTecnico = json[DataBaseCreator.celularTecnico];
    this.correo = json[DataBaseCreator.correo];
  }
}