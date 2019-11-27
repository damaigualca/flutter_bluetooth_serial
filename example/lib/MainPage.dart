import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial_example/src/models/persona.dart';
import 'package:flutter_bluetooth_serial_example/src/models/terapia.dart';
import 'package:flutter_bluetooth_serial_example/src/pages/dashboard_page.dart';
import 'package:flutter_bluetooth_serial_example/src/pages/profiles_page.dart';
import 'package:flutter_bluetooth_serial_example/src/pages/settings_page.dart';
import 'package:flutter_bluetooth_serial_example/src/pages/stats_page.dart';
import 'package:flutter_bluetooth_serial_example/src/services/persona_service.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

//import './LineChart.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPage createState() => new _MainPage();
}

class _MainPage extends State<MainPage> {

  int currentTab = 0;
  final List<Widget> screens = [
    DashboardPage(),
    StatPage(),
    ProfilePage(),
    SettingPage()
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = DashboardPage(); // Our first view in viewport
  Future<List<Persona>> future;
  Persona personaSelected;
  String fecha = '';
  Map<String, bool> terapias = {
    'ESCALERA': false,
    'PIEZAS': false,
    'RECORRIDO': false,
    'FOCOS': false
  };
  Map<String, double> repeticionesTerapia = {
    'ESCALERA': 1.0,
    'PIEZAS': 1.0,
    'RECORRIDO': 1.0,
    'FOCOS': 1.0
  };
  final TextEditingController _typeAheadController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    future = PersonaService.getAll();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        brightness: Brightness.light,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: (){
          _showModal();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = DashboardPage(); // if user taps on this dashboard tab will be active
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.dashboard, color: currentTab == 0 ? Colors.blue : Colors.grey,),
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = StatPage(); // if user taps on this dashboard tab will be active
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.bubble_chart, color: currentTab == 1 ? Colors.blue : Colors.grey,),
                      ],
                    ),
                  )
                ],
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = ProfilePage(); // if user taps on this dashboard tab will be active
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.people,color: currentTab == 2 ? Colors.blue : Colors.grey,),
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = SettingPage(); // if user taps on this dashboard tab will be active
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.settings_bluetooth,color: currentTab == 3 ? Colors.blue : Colors.grey,),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      )
        
    );
  }

  void _showModal(){
    showModalBottomSheet(context: context, builder: (BuildContext context){
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState){
          return CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      color: Color(0xFF737373),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(20),
                            topRight: const Radius.circular(20),
                          )
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            _createHeader(),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                              alignment: Alignment.centerLeft,
                              child: Text('Complete los siguientes datos', style: TextStyle(fontWeight: FontWeight.bold),),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: TypeAheadField(
                                textFieldConfiguration: TextFieldConfiguration(
                                  controller: _typeAheadController,
                                  decoration: InputDecoration(
                                    labelText: 'Seleccione un paciente',
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    )
                                  ),
                                ),
                                suggestionsCallback: (pattern) async {
                                  return await PersonaService.findByNombre(pattern);
                                },
                                itemBuilder: (context, persona) {
                                  return ListTile(
                                    leading: Icon(Icons.person),
                                    title: Text(persona.getFullName()),
                                  );
                                },
                                onSuggestionSelected: (persona) {
                                  personaSelected = persona;
                                  _typeAheadController.text = persona.getFullName();
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                              child: Scrollbar(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                      alignment: Alignment.centerLeft,
                                      child: Text('Seleccione una o más terapias', style: TextStyle(fontWeight: FontWeight.bold),),
                                    ),
                                    Row(
                                    children: <Widget>[
                                    Checkbox(
                                      value: terapias['ESCALERA'],
                                      onChanged: (bool value){
                                        setModalState(() {
                                          terapias['ESCALERA'] = value;
                                        });
                                      }
                                    ),
                                    SizedBox(width: 20.0),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Image(
                                        image: AssetImage('assets/images/escalera.jpg'),
                                        height: 80.0,
                                      ),
                                    ),
                                    SizedBox(width: 20.0),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text('Tratamiento 1', style: TextStyle(fontSize: 14.0), overflow: TextOverflow.ellipsis,),
                                          Text('Número repeticiones: ${repeticionesTerapia['ESCALERA'].round().toString()}', style: TextStyle(fontSize: 10.0), overflow: TextOverflow.ellipsis,),
                                          Slider(
                                            label: repeticionesTerapia['ESCALERA'].round().toString(),
                                            value: repeticionesTerapia['ESCALERA'],
                                            min: 0.0,
                                            max: 5.0,
                                            divisions: 5,
                                            onChanged: (valor){
                                              setModalState(() {
                                                repeticionesTerapia['ESCALERA'] = valor;
                                              });
                                            },
                                          )
                                        ],
                                      ),
                                    )
                              ],
                            ),
                            SizedBox(height: 5.0),
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  value: terapias['PIEZAS'],
                                  onChanged: (bool value){
                                    setModalState(() {
                                      terapias['PIEZAS'] = value;
                                    });
                                  }
                                ),
                                SizedBox(width: 20.0),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Image(
                                    image: AssetImage('assets/images/piezas.jpg'),
                                    height: 80.0,
                                  ),
                                ),
                                SizedBox(width: 20.0),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text('Tratamiento 2', style: TextStyle(fontSize: 14.0), overflow: TextOverflow.ellipsis,),
                                      Text('Número repeticiones: ${repeticionesTerapia['PIEZAS'].round().toString()}', style: TextStyle(fontSize: 10.0), overflow: TextOverflow.ellipsis,),
                                      Slider(
                                        label: repeticionesTerapia['PIEZAS'].round().toString(),
                                        value: repeticionesTerapia['PIEZAS'],
                                        min: 0.0,
                                        max: 5.0,
                                        divisions: 5,
                                        onChanged: (valor){
                                          setModalState(() {
                                            repeticionesTerapia['PIEZAS'] = valor;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 5.0),
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  value: terapias['RECORRIDO'],
                                  onChanged: (bool value){
                                    setModalState(() {
                                      terapias['RECORRIDO'] = value;
                                    });
                                  }
                                ),
                                SizedBox(width: 20.0),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Image(
                                    image: AssetImage('assets/images/recorrido.jpg'),
                                    height: 80.0,
                                  ),
                                ),
                                SizedBox(width: 20.0),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text('Tratamiento 3', style: TextStyle(fontSize: 14.0), overflow: TextOverflow.ellipsis,),
                                      Text('Número repeticiones: ${repeticionesTerapia['RECORRIDO'].round().toString()}', style: TextStyle(fontSize: 10.0), overflow: TextOverflow.ellipsis,),
                                      Slider(
                                        label: repeticionesTerapia['RECORRIDO'].round().toString(),
                                        value: repeticionesTerapia['RECORRIDO'],
                                        min: 0.0,
                                        max: 5.0,
                                        divisions: 5,
                                        onChanged: (valor){
                                          setModalState(() {
                                            repeticionesTerapia['RECORRIDO'] = valor;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 5.0),
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  value: terapias['FOCOS'],
                                  onChanged: (bool value){
                                    setModalState(() {
                                      terapias['FOCOS'] = value;
                                    });
                                  }
                                ),
                                SizedBox(width: 20.0),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Image(
                                    image: AssetImage('assets/images/focos.jpg'),
                                    height: 80.0,
                                  ),
                                ),
                                SizedBox(width: 20.0),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text('Tratamiento 4', style: TextStyle(fontSize: 14.0), overflow: TextOverflow.ellipsis,),
                                      Text('Número repeticiones: ${repeticionesTerapia['FOCOS'].round().toString()}', style: TextStyle(fontSize: 10.0), overflow: TextOverflow.ellipsis,),
                                      Slider(
                                        label: repeticionesTerapia['FOCOS'].round().toString(),
                                        value: repeticionesTerapia['FOCOS'],
                                        min: 0.0,
                                        max: 5.0,
                                        divisions: 5,
                                        onChanged: (valor){
                                          setModalState(() {
                                            repeticionesTerapia['FOCOS'] = valor;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Center(
                              child: RaisedButton(
                                color: Colors.blue,
                                child: Text('Iniciar terapia', style: TextStyle(color: Colors.white),),
                                onPressed: (personaSelected == null || !_verifyExistOneTerapiaSelected()) ? (null) : (){
                                  Navigator.pushNamed(context, 'terapia', arguments: _buildTerapias());
                                },
                              ),
                            )
                          ],
                        ),
                        )
                      ),
                          ],
                        ),
                      )
                    )
                  ]
                ),
              )
            ],
          );
        } 
      );
    });
  }

  void _closeModal(){
    Navigator.pop(context);
  }
  bool _verifyExistOneTerapiaSelected(){
    bool exist = false;
    terapias.forEach((k , v){
      if (v){
        exist = true;
      }
    });
    return exist;
  }

  List<Terapia> _buildTerapias(){
    List<Terapia> listNuevasTerapias = new List<Terapia>();
    DateTime currentDate = DateTime.now();
    String fechaCreacion = currentDate.year.toString() + '-' + currentDate.month.toString() + '-' + currentDate.day.toString();
    int repeticiones = 1;
    terapias.forEach((k, v) {
      repeticionesTerapia.forEach((clave, valor){
        if (clave == k){
          repeticiones = valor.round();
        }
      });
      if (v){
        listNuevasTerapias.add(new Terapia(fechaCreacion, k, repeticiones, '', false, '', 0, 0, personaSelected.id, personaSelected));
      }
    });
    return listNuevasTerapias;
  }

  Widget _createHeader(){
    return Row(
      children: <Widget>[
        MaterialButton(
          elevation: 30,
          padding: EdgeInsets.only(right: 40.0),
          child: Icon(Icons.close, size: 30, color: Colors.grey,),
          onPressed: () => _closeModal(),
        ),
        Container(
          child: Center(
            child: Text('Creación terapia recreativa', style: TextStyle(fontSize: 18.0),),
          ),
        )
      ],
    );
  }
}
