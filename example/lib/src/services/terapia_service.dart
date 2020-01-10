import 'package:flutter_bluetooth_serial_example/src/models/terapia.dart';
import 'package:flutter_bluetooth_serial_example/src/providers/database_creator.dart';

class TerapiaService {
  
  static Future<List<Terapia>> getAll() async {
    final sql = 'SELECT * FROM ${DataBaseCreator.personaTable}';
    final data = await db.rawQuery(sql);
    List<Terapia> terapias = List();

    for (final node in data) {
      final todo = Terapia.fromJson(node);
      terapias.add(todo);
    }
    return terapias;
  }

  static Future<List<Terapia>> findByPaciente(int idPersona) async {
    final sql = 'SELECT * FROM ${DataBaseCreator.terapiaTable} WHERE ${DataBaseCreator.personaId}=${idPersona.toString()};';
    final data = await db.rawQuery(sql);
    List<Terapia> terapias = List();

    for (final node in data) {
      final todo = Terapia.fromJson(node);
      terapias.add(todo);
    }
    return terapias;
  }

  static Future<void> addTerapia(Terapia terapia) async {
    final sql = '''INSERT INTO ${DataBaseCreator.terapiaTable}(
      ${DataBaseCreator.fecha},
      ${DataBaseCreator.tipoTerapia},
      ${DataBaseCreator.repeticionesAsignadas},
      ${DataBaseCreator.observaciones},
      ${DataBaseCreator.completado},
      ${DataBaseCreator.tiempoEmpleado},
      ${DataBaseCreator.repeticionesCorrectas},
      ${DataBaseCreator.repeticionesFallidas},
      ${DataBaseCreator.personaId}
    )
    VALUES(
      '${terapia.fecha}',
      '${terapia.tipoTerapia}',
      ${terapia.repeticionesAsignadas},
      '${terapia.observaciones}',
      ${terapia.completado ? 1 : 0},
      '${terapia.tiempoEmpleado}',
      ${terapia.repeticionesCorrectas},
      ${terapia.repeticionesFallidas},
      ${terapia.personaId}
    );''';

    final result = await db.rawInsert(sql);
    DataBaseCreator.databaseLog('Add terapia', sql, null, result);
  }

  static Future<void> updateTerapia(Terapia terapia) async {
    final sql = '''UPDATE ${DataBaseCreator.terapiaTable} 
    SET ${DataBaseCreator.fecha} = "${terapia.fecha}",
    SET ${DataBaseCreator.tipoTerapia} = "${terapia.tipoTerapia}",
    SET ${DataBaseCreator.repeticionesAsignadas} = "${terapia.repeticionesAsignadas}",
    SET ${DataBaseCreator.observaciones} = "${terapia.observaciones}",
    SET ${DataBaseCreator.completado} = "${terapia.completado ? 1 : 0}",
    SET ${DataBaseCreator.tiempoEmpleado} "${terapia.tiempoEmpleado}",
    SET ${DataBaseCreator.repeticionesCorrectas} = "${terapia.repeticionesCorrectas}",
    SET ${DataBaseCreator.repeticionesFallidas} = "${terapia.repeticionesFallidas}",
    SET ${DataBaseCreator.personaId} = "${terapia.personaId}" 
    WHERE ${DataBaseCreator.id} == ${terapia.id}
    ''';

    final result = await db.rawUpdate(sql);
    DataBaseCreator.databaseLog('Update terapia', sql, null, result);

  }
}