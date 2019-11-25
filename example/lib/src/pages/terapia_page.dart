import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial_example/src/models/persona.dart';
import 'package:flutter_bluetooth_serial_example/src/models/terapia.dart';
class TerapiaPage extends StatefulWidget {
  TerapiaPage({Key key}) : super(key: key);

  @override
  _TerapiaPageState createState() => _TerapiaPageState();
}

class _TerapiaPageState extends State<TerapiaPage> {
  Stopwatch watch = Stopwatch();
  Timer timer;
  bool detenido = false;

  String elapsedTime = '';
  int intentos = 0;
  int intentoCorrectos = 0;
  int intentosFallidos = 0;
  Persona personaSelected;
  Terapia terapiaSelected;
  int posicionActualListaTerapias = 0;
  String obervaciones = '';
  int totalTerapias;

  void updateTime(Timer timer){
    if (!mounted) return;
    setState(() {
      elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
    });
  }

  @override
  void initState() { 
    super.initState();
    watch.start();
    timer = new Timer.periodic(Duration(milliseconds: 100), updateTime); 
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Terapia> terapias = ModalRoute.of(context).settings.arguments;
    personaSelected = terapias[0].persona;
    terapiaSelected = terapias[posicionActualListaTerapias];
    totalTerapias = _countTerapias(terapias);

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _createAppbar(terapias),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _createIntentos(),
              ]
            ),
          ),
          SliverFillRemaining(
            child: _createBodyInfo(),
          )
        ],
      ),
    );
  }

  Widget _createAppbar(List<Terapia> terapias){
    return SliverAppBar(
      leading: BackButton(color: Colors.blue),
      elevation: 2.0,
      backgroundColor: Colors.white,
      brightness: Brightness.light,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          elapsedTime,
          style: TextStyle(fontSize: 40.0, color: Colors.black),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(10.0),
        child: Container(
          child: Text('Duración', style: TextStyle(fontSize: 15.0),),
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: (!detenido) ? Icon(Icons.pause, color: Colors.blue): Icon(Icons.play_arrow, color: Colors.blue),
          tooltip: 'Pausar',
          onPressed: (){
            if (!detenido){
              stopWatch();
            }else if(detenido){
              startWatch();
            }
          },
        )
      ],
    );
  }

  Widget _createIntentos(){
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(intentos.toString(), style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
              Text('Intentos', style: TextStyle(fontSize: 15.0))
            ],
          ),
          VerticalDivider(color: Colors.grey, width: 50.0),
          Column(
            children: <Widget>[
              Text(intentoCorrectos.toString(), style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
              Text('Correctos', style: TextStyle(fontSize: 15.0))
            ],
          ),
          VerticalDivider(color: Colors.grey, width: 50.0),
          Column(
            children: <Widget>[
              Text(intentosFallidos.toString(), style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
              Text('Fallidos', style: TextStyle(fontSize: 15.0))
            ],
          ),
        ],
      ),
    );
  }

  Widget _createBodyInfo(){
    return Container(
      padding: EdgeInsets.only(right: 20.0, left: 20.0),
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Repeticiones asignadas: ' + terapiaSelected.repeticionesAsignadas.toString())
              ],
            ),
          ),
          ListTile(
            leading: CircleAvatar(
            backgroundColor: Colors.blue,
            backgroundImage: AssetImage('${terapiaSelected.getImageFromTerapiaType()}'),
              radius: 25.0,
            ),
            title: Text('Terapia en curso'),
            subtitle: Text('${terapiaSelected.getNameFromTerapiaType()}'),
            trailing: Text('${(posicionActualListaTerapias+1).toString()}' + '/' + totalTerapias.toString()),
            onTap: (){}
          ),
          Divider(),
          ListTile(
            leading: CircleAvatar(
            backgroundColor: Colors.blue,
            backgroundImage: AssetImage('${personaSelected.getImage()}'),
              radius: 25.0,
            ),
            title: Text('Paciente actual'),
            subtitle: Text('${personaSelected.getFullName()}'),
            trailing: Text('${personaSelected.getEdad() + ' años'}'),
            onTap: (){}
          ),
          Divider(),
          Container(
            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: Text('Observaciones', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
          ),
          TextFormField(
            textCapitalization: TextCapitalization.sentences,
            keyboardType: TextInputType.multiline,
            maxLines: 2,
            decoration: InputDecoration(
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              
              )
            ),
            onChanged: (valor){
              obervaciones = valor;
            },
          ),
          Divider(height: 40.0, thickness: 0.0, color: Colors.white,),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: Text('Reiniciar', style: TextStyle(fontSize: 15.0),),
              ),
              RaisedButton(
                child: Text('Finalizar', style: TextStyle(fontSize: 15.0)),
              ),
            ],
          )
        ],
      ),
    );
  }
  startWatch(){
    watch.start();
    detenido = false;
  }

  stopWatch(){
    watch.stop();
    detenido = true;
    setTime();
  }

  resetWatch(){
    watch.reset();
    setTime();
  }

  setTime(){
    var timeSoFar = watch.elapsedMilliseconds;
    if (!mounted) return;
    setState(() {
      elapsedTime = transformMilliSeconds(timeSoFar);
    });
  }

  transformMilliSeconds(int milliseconds){
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();

    String minutessStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    return '$minutessStr:$secondsStr';
  }

  int _countTerapias(List<Terapia> t){
    int contador = 0;
    t.forEach((f) => {
      contador = contador + 1
    });
    return contador;
  }
}