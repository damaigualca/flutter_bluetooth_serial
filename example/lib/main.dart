import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial_example/src/pages/profiles_detail_page.dart';
import 'package:flutter_bluetooth_serial_example/src/pages/terapia_page.dart';
import 'package:flutter_bluetooth_serial_example/src/providers/database_creator.dart';

import './MainPage.dart';

void main() async{
  await DataBaseCreator().initDatabase();
  runApp(new ExampleApplication());
}

class ExampleApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color.fromRGBO(250, 250, 250, 1)
    )); 
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
      routes: {
        'perfil_detalle': (BuildContext context) => ProfileDetail(),
        'terapia': (BuildContext context) => TerapiaPage()
      },
    );
  }
}
