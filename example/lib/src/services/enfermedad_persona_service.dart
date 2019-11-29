import 'package:flutter_bluetooth_serial_example/src/models/enfermedad_persona.dart';
import 'package:flutter_bluetooth_serial_example/src/providers/database_creator.dart';

class EnfermedadPersonaService {
  
  static Future<List<EnfermedadPersona>> getAll(int idPersona) async {
    final sql = '''
      SELECT ep.id, nivel_enfermedad, tipo_tratamiento, recomendacion, lugar_atencion, e.nombre, ep.id_persona, ep.id_enfermedad
      FROM ${DataBaseCreator.enfermedadPersonaTable} as ep, ${DataBaseCreator.enfermedadTable} as e, ${DataBaseCreator.personaTable} as p
      WHERE ep.id_enfermedad = e.id AND ep.id_persona = p.id AND ep.id_persona = ${idPersona.toString()};
    ''';
    final data = await db.rawQuery(sql);
    List<EnfermedadPersona> enfermedades = List();

    for (final node in data) {
      final todo = EnfermedadPersona.fromJson(node);
      enfermedades.add(todo);
    }
    return enfermedades;
  }
}