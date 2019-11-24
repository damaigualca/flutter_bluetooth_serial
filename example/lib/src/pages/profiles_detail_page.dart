import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial_example/src/models/persona.dart';

class ProfileDetail extends StatefulWidget {
  @override
  _ProfileDetailState createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  final estiloTitulo = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  final estiloSubtitulo = TextStyle(fontSize: 18.0, color: Colors.grey);
  @override
  Widget build(BuildContext context) {
    final Persona persona = ModalRoute.of(context).settings.arguments;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            _createAppbar(persona),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  _createTabs()
                ]
              ),
            ),
            SliverFillRemaining(
              child: _createTabViews(),
            )
          ],
        )
      )
    );
    
  }

  Widget _createAppbar(Persona persona){
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.blue,
      brightness: Brightness.light,
      expandedHeight: 300.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          persona.getFullName(), 
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: AssetImage(persona.getImage()),
          placeholder: AssetImage('assets/images/loading.gif'),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        )
      ),
    );
  }

  Widget _createTabs() {
    return Column(
      children: <Widget>[
        Container(
          constraints: BoxConstraints.expand(height: 50),
          child: TabBar(
            labelColor: Colors.black,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.person)),
              Tab(icon: Icon(Icons.local_hospital)),
              Tab(icon: Icon(Icons.accessible)),
              Tab(icon: Icon(Icons.assignment))
            ],
          ),
        ),
      ],
    );
  }
  Widget _createTabViews(){
    return TabBarView(
      children: [
        Container(
          padding: EdgeInsets.all(20.0),
          child: _showInformacionPersonal(),
        ),
        Icon(Icons.directions_transit),
        Icon(Icons.directions_bike),
        Icon(Icons.directions_bike),
      ],
    );
  }

  Widget _showInformacionPersonal() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text('Información personal',style: estiloTitulo),
            SizedBox(width: 50.0),
            Icon(Icons.edit)
          ],
        ),
        SizedBox(height: 20.0),
        Text('Nombres: '),
        TextFormField(
              enabled: false,
              decoration: InputDecoration(labelText: 'First name'),
        ),
      ],
    );
  }
}