import 'package:flutter_bluetooth_serial_example/src/models/categoria.dart';
import 'package:flutter_bluetooth_serial_example/src/providers/database_creator.dart';

class CategoriaService {
  
  static Future<List<Categoria>> getAll() async {
    final sql = 'SELECT * FROM ${DataBaseCreator.categoriaTable}';
    final data = await db.rawQuery(sql);
    List<Categoria> categorias = List();

    for (final node in data) {
      final todo = Categoria.fromJson(node);
      categorias.add(todo);
    }
    return categorias;
  }
}