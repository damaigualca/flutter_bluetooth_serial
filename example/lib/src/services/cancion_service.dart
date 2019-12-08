import 'package:flutter_bluetooth_serial_example/src/models/cancion.dart';
import 'package:flutter_bluetooth_serial_example/src/providers/database_creator.dart';

class CancionService {
  
  static Future<List<Cancion>> getAll() async {
    final sql = 'SELECT * FROM ${DataBaseCreator.cancionTable}';
    final data = await db.rawQuery(sql);
    List<Cancion> canciones = List();

    for (final node in data) {
      final todo = Cancion.fromJson(node);
      canciones.add(todo);
    }
    return canciones;
  }
}