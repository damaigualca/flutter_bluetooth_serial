import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial_example/MainPage.dart';
import 'package:flutter_bluetooth_serial_example/src/models/resource_parameter.dart';

class TerapiaResultPage extends StatefulWidget {

  TerapiaResultPage({Key key}) : super(key: key);

  @override
  _TerapiaResultPageState createState() => _TerapiaResultPageState();
}

class _TerapiaResultPageState extends State<TerapiaResultPage> {
  ResourceParameter resourceParameter;

  @override
  Widget build(BuildContext context) {
    resourceParameter = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      body: _showBodyInfo(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed:(){
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => MainPage()
          ));
        },
        backgroundColor: Colors.blue,
        label: Text('Menu Principal'),
        icon: Icon(Icons.apps),
        tooltip: 'Menu principal'
      ),
    );
  }

  Widget _showBodyInfo(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 40.0),
      child: ListView(
        children: _createTextFildInputs(),
      ),
    );
  }

  List<Widget> _createTextFildInputs(){
    List<Widget> textFildWidgets=[];
    textFildWidgets.add(_createIcon());
    textFildWidgets.add(_createTitle());
    textFildWidgets.add(SizedBox(height: 40.0));
    //textFildWidgets.add(_createSubtitle());
    //textFildWidgets.add(SizedBox(height: 40.0));
    // for (var terapia in resourceParameter.terapias) {
    //   textFildWidgets.add(
    //     Text(terapia.getNameFromTerapiaType())
    //   );
    //   textFildWidgets.add(SizedBox(height: 10.0));
    //   textFildWidgets.add(
    //     TextFormField(
    //       textCapitalization: TextCapitalization.sentences,
    //       keyboardType: TextInputType.multiline,
    //       maxLines: 2,
    //       decoration: InputDecoration(
    //         fillColor: Colors.white,
    //         border: OutlineInputBorder(
    //           borderRadius: BorderRadius.circular(10.0),
    //         )
    //       ),
    //       onChanged: (valor){
    //         terapia.observaciones = valor;
    //       },
    //     ),
    //   );
    //   textFildWidgets.add(SizedBox(height: 40.0));
    // }
    return textFildWidgets;
  }

  Widget _createIcon(){
    return Icon(
      Icons.check_circle_outline,
      size: 100.0,
      color: Colors.blue,
    );
  }

  Widget _createTitle(){
    return Text(
      '!Felicidades!\nHas finalizado con las terapias asignadas',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 30.0,
        height: 1.5
      ),
    );
  }

  Widget _createSubtitle(){
    return Text(
      'Observaciones',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 15.0,
        height: 1.5
      ),
    );
  }

  // int _countTerapias(){
  //   int contador = 0;
  //   widget.resourceParameter.terapias.forEach((f) => {
  //     contador = contador + 1
  //   });
  //   return contador;
  // }
}