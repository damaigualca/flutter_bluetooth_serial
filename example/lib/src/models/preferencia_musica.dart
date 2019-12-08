import 'package:flutter_bluetooth_serial_example/src/models/cancion.dart';
import 'package:flutter_bluetooth_serial_example/src/models/persona.dart';
import 'package:flutter_bluetooth_serial_example/src/providers/database_creator.dart';

class PreferenciaMusica{
  int id;
  int idPersona;
  int idCancion;
  Cancion cancion;
  Persona persona;

  PreferenciaMusica(
    this.id, 
    this.idPersona,
    this.idCancion
  );
  
  PreferenciaMusica.fromJson(Map<String, dynamic> json) {
    this.id = json[DataBaseCreator.id];
    this.idCancion = json[DataBaseCreator.cancionId];
    this.idPersona = json[DataBaseCreator.personaId];
  }
}