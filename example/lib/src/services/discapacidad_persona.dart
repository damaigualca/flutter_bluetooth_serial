import 'package:flutter_bluetooth_serial_example/src/models/discapacidad_persona.dart';
import 'package:flutter_bluetooth_serial_example/src/providers/database_creator.dart';

class DiscapacidadPersonaService {
  
  static Future<List<DiscapacidadPersona>> getAll(int idPersona) async {
    final sql = '''
      SELECT dp.id, porcentaje, descripcion, d.nombre, dp.id_persona, dp.id_discapacidad
      FROM ${DataBaseCreator.discapacidadPersonaTable} as dp, ${DataBaseCreator.discapacidadTable} as d, ${DataBaseCreator.personaTable} as p
      WHERE dp.id_discapacidad = d.id AND dp.id_persona = p.id AND dp.id_persona = ${idPersona.toString()};
    ''';
    final data = await db.rawQuery(sql);
    List<DiscapacidadPersona> discapacidades = List();

    for (final node in data) {
      final todo = DiscapacidadPersona.fromJson(node);
      discapacidades.add(todo);
    }
    return discapacidades;
  }
}