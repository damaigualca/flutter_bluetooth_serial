import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial_example/src/models/persona.dart';
import 'package:flutter_bluetooth_serial_example/src/services/persona_service.dart';
class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<List<Persona>> future;

  @override
  initState() {
    super.initState();
    future = PersonaService.getAll();
  }

  

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: ListView(
        children: <Widget>[
          Center(
            child: Text('Pacientes', style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold)),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            width: MediaQuery.of(context).size.width,
            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
            decoration: BoxDecoration( 
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26, 
                  blurRadius: 20.0, 
                  spreadRadius: 2.0, 
                  offset: Offset(1.0, 15.0)
                ),
              ]
            ),
            child: _getPersonas(context),
          )
        ],
      )
    );
  }

  Widget  _getPersonas(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40.0),
      child: ListView(
        children: <Widget>[
          FutureBuilder(
            future: future,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot){
               if (snapshot.hasData) {
                return Column(
                  children: snapshot.data.map((todo) => _construirItemList(todo)).toList()
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          )
        ],
      )
    );
  }

  Widget _construirItemList(Persona persona) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
          backgroundColor: Colors.blue,
          backgroundImage: AssetImage('${persona.getImage()}'),
            radius: 25.0,
          ),
          title: Text('${persona.nombres + ' ' + persona.apellidos}'),
          subtitle: Text('${persona.direccion + ' | ' + persona.cedula}'),
          trailing: Text('${persona.getEdad() + ' años'}'),
          onTap: (){
            Navigator.pushNamed(context, 'perfil_detalle', arguments: persona);
          },
        ),
        Divider()
      ],
    );
  }
}