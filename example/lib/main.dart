import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial_example/src/pages/create_terapia_page.dart';
import 'package:flutter_bluetooth_serial_example/src/pages/profiles_detail_page.dart';
import 'package:flutter_bluetooth_serial_example/src/pages/terapia_page.dart';
import 'package:flutter_bluetooth_serial_example/src/providers/database_creator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import './MainPage.dart';

void main() async{
  await DataBaseCreator().initDatabase();
  runApp(new ExampleApplication());
}

class ExampleApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
    )); 
    return MaterialApp(
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
          const Locale('en', 'US'), // English
          const Locale('es', 'ES'), // Hebrew
      ],
      debugShowCheckedModeBanner: false,
      home: MainPage(),
      routes: {
        'perfil_detalle': (BuildContext context) => ProfileDetail(),
        'terapia': (BuildContext context) => TerapiaPage(),
        'nueva_terapia': (BuildContext context) => CreateTerapiaPage()
      },
    );
  }
}
