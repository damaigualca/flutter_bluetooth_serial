import 'package:flutter_bluetooth_serial_example/src/models/enfermedad.dart';
import 'package:flutter_bluetooth_serial_example/src/providers/database_creator.dart';

class EnfermedadService {
  static Future<List<Enfermedad>> getAll() async {
    final sql = 'SELECT * FROM ${DataBaseCreator.enfermedadTable}';
    final data = await db.rawQuery(sql);
    List<Enfermedad> enfermedades = List();

    for (final node in data) {
      final todo = Enfermedad.fromJson(node);
      enfermedades.add(todo);
    }
    return enfermedades;
  }
}