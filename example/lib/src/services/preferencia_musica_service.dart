import 'package:flutter_bluetooth_serial_example/src/models/preferencia_musica.dart';
import 'package:flutter_bluetooth_serial_example/src/providers/database_creator.dart';

class PreferenciaMusicaService {
  
  static Future<List<PreferenciaMusica>> findByPersona(int idPersona) async {
    final sql = '''
      SELECT c.nombre, c.imagen, c.artista
      FROM ${DataBaseCreator.preferenciaMusicaTable} as pm, ${DataBaseCreator.cancionTable} as c, ${DataBaseCreator.personaTable} as p
      WHERE pm.id_persona = p.id AND pm.id_cancion = c.id AND pm.id_persona = ${idPersona.toString()};
    ''';
    final data = await db.rawQuery(sql);
    List<PreferenciaMusica> preferenciasMusicales = List();

    for (final node in data) {
      final todo = PreferenciaMusica.fromJson(node);
      preferenciasMusicales.add(todo);
    }
    return preferenciasMusicales;
  }
}