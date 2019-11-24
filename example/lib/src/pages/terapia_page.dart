import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial_example/src/models/terapia.dart';
class TerapiaPage extends StatefulWidget {
  TerapiaPage({Key key}) : super(key: key);

  @override
  _TerapiaPageState createState() => _TerapiaPageState();
}

class _TerapiaPageState extends State<TerapiaPage> {
  
  @override
  Widget build(BuildContext context) {
    final List<Terapia> terapias = ModalRoute.of(context).settings.arguments;
    return Container(
       child: Text('data'),
    );
  }
}