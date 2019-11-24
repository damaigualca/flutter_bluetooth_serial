import 'package:flutter_bluetooth_serial_example/src/models/persona.dart';
import 'package:flutter_bluetooth_serial_example/src/providers/database_creator.dart';

class PersonaService {
  
  static Future<List<Persona>> getAll() async {
    final sql = 'SELECT * FROM ${DataBaseCreator.personaTable}';
    final data = await db.rawQuery(sql);
    List<Persona> personas = List();

    for (final node in data) {
      final todo = Persona.fromJson(node);
      personas.add(todo);
    }
    return personas;
  }
}