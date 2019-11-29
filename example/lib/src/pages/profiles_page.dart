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
      color: Colors.white,
      child: CustomScrollView(
        slivers: <Widget>[
          _createAppbar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                FutureBuilder(
                  future: future,
                  builder: (BuildContext context, AsyncSnapshot<List> snapshot){
                    if (snapshot.hasData) {
                      return Container(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Column(
                          children: snapshot.data.map((todo) => _construirItemList(todo)).toList()
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                )
              ]
            ),
          )
        ],
      ),
    );
  }

  Widget _createAppbar(){
    return SliverAppBar(
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      expandedHeight: 100.0,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          'Pacientes', 
          style: TextStyle(color: Colors.black, fontSize: 20.0),
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add, color: Colors.blue),
          tooltip: 'Agregar',
          onPressed: (){
          },
        )
      ],
    );
  }

  Widget _construirItemList(Persona persona) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
          backgroundColor: Colors.transparent,
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