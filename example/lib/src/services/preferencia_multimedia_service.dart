import 'package:flutter_bluetooth_serial_example/src/models/preferencia_multimedia.dart';
import 'package:flutter_bluetooth_serial_example/src/providers/database_creator.dart';

class PreferenciaMultimediaService {
  
  static Future<List<PreferenciaMultimedia>> findByPaciente(int idPersona) async {
    final sql = '''
      SELECT c.nombre, c.imagen
      FROM ${DataBaseCreator.preferenciaMultimedialTable} as pm, ${DataBaseCreator.categoriaTable} as c, ${DataBaseCreator.personaTable} as p
      WHERE pm.id_persona = p.id AND pm.id_categoria = c.id AND pm.id_persona = ${idPersona.toString()};
    ''';
    final data = await db.rawQuery(sql);
    List<PreferenciaMultimedia> preferenciasMultimediales = List();

    for (final node in data) {
      final todo = PreferenciaMultimedia.fromJson(node);
      preferenciasMultimediales.add(todo);
    }
    return preferenciasMultimediales;
  }
}