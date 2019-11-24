import 'package:flutter/material.dart';

class StatPage extends StatefulWidget {
  StatPage({Key key}) : super(key: key);

  @override
  _StatPageState createState() => _StatPageState();
}

class _StatPageState extends State<StatPage> {

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Completar basandose en las demas'),
    );
  }
}