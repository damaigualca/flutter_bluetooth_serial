import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial_example/src/models/enfermedad.dart';
import 'package:flutter_bluetooth_serial_example/src/services/enfermedad_service.dart';

class StatPage extends StatefulWidget {
  StatPage({Key key}) : super(key: key);

  @override
  _StatPageState createState() => _StatPageState();
}

class _StatPageState extends State<StatPage> {
  final _formKey = GlobalKey<FormState>();
  Future<List<Enfermedad>> future;
  String name;
  int id;

  @override
  initState() {
    super.initState();
    future = EnfermedadService.getAll();
  }

  Card buildItem(Enfermedad todo) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'name: ${todo.nombre}',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'todo: ${todo.id}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        FutureBuilder<List<Enfermedad>>(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(children: snapshot.data.map((todo) => buildItem(todo)).toList());
              } else {
                return SizedBox();
              }
            }
        )
      ],
    );
  }
}