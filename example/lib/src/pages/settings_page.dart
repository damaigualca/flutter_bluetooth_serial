import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_bluetooth_serial_example/BackgroundCollectedPage.dart';
import 'package:flutter_bluetooth_serial_example/BackgroundCollectingTask.dart';
import 'package:flutter_bluetooth_serial_example/ChatPage.dart';
import 'package:flutter_bluetooth_serial_example/DiscoveryPage.dart';
import 'package:flutter_bluetooth_serial_example/SelectBondedDevicePage.dart';
import 'package:scoped_model/scoped_model.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  String _address = "...";
  String _name = "...";

  Timer _discoverableTimeoutTimer;
  int _discoverableTimeoutSecondsLeft = 0;

  BackgroundCollectingTask _collectingTask;

  bool _autoAcceptPairingRequests = false;

  @override
  void initState() { 
    super.initState();

    //Obtener estado actual
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() { _bluetoothState = state; });
    });

    Future.doWhile(() async{
      // Esperar si el adaptador no esta encendido
      if (await FlutterBluetoothSerial.instance.isEnabled) {
        return false;
      }
      await Future.delayed(Duration(milliseconds: 0xDD));
      return true;
    }).then((_){
      FlutterBluetoothSerial.instance.address.then((address){
        setState(() {
         _address = address; 
        });
      });
    });

    FlutterBluetoothSerial.instance.name.then((name) {
      setState(() { _name = name; });
    });

    // Escuchar los cambios de estados posteriores
    FlutterBluetoothSerial.instance.onStateChanged().listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;

        // Modo detectable se deshabilita cuando el bluetooth se deshabilita
        _discoverableTimeoutTimer = null;
        _discoverableTimeoutSecondsLeft = 0;
      });
    });
  }

  @override
  void dispose() {
    FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
    _collectingTask?.dispose();
    _discoverableTimeoutTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Center(
              child: const Text('Configuraciones', style: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
              )),
            )
          ),
          Center(
            child: _createEnableBluetoothCard()
          ),
          Center(
            child: _createAboutDeviceCard(),
          ),
            ListTile(
              title: const Text('Devices discovery and connection')
            ),
            SwitchListTile(
              title: const Text('Auto-try specific pin when pairing'),
              subtitle: const Text('Pin 1234'),
              value: _autoAcceptPairingRequests,
              onChanged: (bool value) {
                setState(() {
                  _autoAcceptPairingRequests = value;
                });
                if (value) {
                  FlutterBluetoothSerial.instance.setPairingRequestHandler((BluetoothPairingRequest request) {
                    print("Trying to auto-pair with Pin 1234");
                    if (request.pairingVariant == PairingVariant.Pin) {
                      return Future.value("1234");
                    }
                    return null;
                  });
                }
                else {
                  FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
                }
              },
            ),
            ListTile(
              title: RaisedButton(
                child: const Text('Explore discovered devices'),
                onPressed: () async {
                  final BluetoothDevice selectedDevice = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) { return DiscoveryPage(); })
                  );

                  if (selectedDevice != null) {
                    print('Discovery -> selected ' + selectedDevice.address);
                  }
                  else {
                    print('Discovery -> no device selected');
                  }
                }
              ),
            ),
            ListTile(
              title: RaisedButton(
                child: const Text('Connect to paired device to chat'),
                onPressed: () async {
                  final BluetoothDevice selectedDevice = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) { return SelectBondedDevicePage(checkAvailability: false); })
                  );

                  if (selectedDevice != null) {
                    print('Connect -> selected ' + selectedDevice.address);
                    _startChat(context, selectedDevice);
                  }
                  else {
                    print('Connect -> no device selected');
                  }
                },
              ),
            ),

            Divider(),
            ListTile(
              title: const Text('Multiple connections example')
            ),
            ListTile(
              title: RaisedButton(
                child: (
                  (_collectingTask != null && _collectingTask.inProgress) 
                  ? const Text('Disconnect and stop background collecting')
                  : const Text('Connect to start background collecting') 
                ),
                onPressed: () async {
                  if (_collectingTask != null && _collectingTask.inProgress) {
                    await _collectingTask.cancel();
                    setState(() {/* Update for `_collectingTask.inProgress` */});
                  }
                  else {
                    final BluetoothDevice selectedDevice = await Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) { return SelectBondedDevicePage(checkAvailability: false); })
                    );

                    if (selectedDevice != null) {
                      await _startBackgroundTask(context, selectedDevice);
                      setState(() {/* Update for `_collectingTask.inProgress` */});
                    }
                  }
                },
              ),
            ),
            ListTile(
              title: RaisedButton(
                child: const Text('View background collected data'),
                onPressed: (_collectingTask != null) ? () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return ScopedModel<BackgroundCollectingTask>(
                        model: _collectingTask,
                        child: BackgroundCollectedPage(),
                      );
                    })
                  );
                } : null,
              )
            ),
        ],
      ),
    );
  }

  Widget _createEnableBluetoothCard(){
    return Card(
      margin: EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0 ,bottom: 20.0),
      color: Color.fromRGBO(231, 244, 235, 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle
            ),
            margin: EdgeInsets.only(top: 20.0),
            child: Icon(Icons.settings_bluetooth, size: 30.0, color: Colors.blue,)
          ),
          const ListTile(
            title: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text('Configuración Bluetooth', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
              )
            ),
            subtitle: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
                child: Text(
                  'Para iniciar con la terapia es necesario activar la configuracion de Bluetooth', 
                  textAlign: TextAlign.center
                )
              )
            )
          ),
          SwitchListTile(
            title: const Text('Encender Bluetooth'),
            value: _bluetoothState.isEnabled,
            onChanged: (bool value) {
              // Haga la solicitud y actualice con el valor verdadero y luego
              future() async { // async lambda seems to not working
                if (value)
                  await FlutterBluetoothSerial.instance.requestEnable();
                else
                  await FlutterBluetoothSerial.instance.requestDisable();
              }
              future().then((_) {
                setState(() {});
              });
            },
          ),
        ],
      ),
    );
  }

  

  Widget _createAboutDeviceCard(){
    return Card(
      margin: EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0 ,bottom: 20.0),
      color: Color.fromRGBO(245, 231, 254, 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle
            ),
            margin: EdgeInsets.only(top: 20.0),
            child: Icon(Icons.account_circle, size: 30.0, color: Colors.blue,)
          ),
          ListTile(
            title: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text('Informacion de su dispositivo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
              )
            ),
            subtitle:  Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
                child: Text(
                  'Nombre dispositivo: $_name \nDirección adaptador: $_address', 
                  textAlign: TextAlign.center
                )
              )
            )
          ),
          ListTile(
            title: Text('Estado adaptador bluetooth'),
            subtitle: _getBluetoothState(),
            trailing: FlatButton(
              color: Colors.blue,
              child: Icon(Icons.settings, color: Colors.white,),
              onPressed: () { 
                FlutterBluetoothSerial.instance.openSettings();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _getBluetoothState(){
    String message = "";
    if (_bluetoothState.toString() == "BluetoothState.STATE_ON") {
      message = "Estado actual: Activo";
    } else if(_bluetoothState.toString() == "BluetoothState.STATE_OFF") {
      message = "Estado actual: Inactivo";
    } else if(_bluetoothState.toString() == "BluetoothState.STATE_TURNING_ON"){
      message = "Estado actual: Encendiendo";
    } else if(_bluetoothState.toString() == "BluetoothState.STATE_TURNING_OFF"){
      message = "Estado actual: Apagando";
    } 
    return Text(message);
  }

  void _startChat(BuildContext context, BluetoothDevice server) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) { return ChatPage(server: server); }));
  }

  Future<void> _startBackgroundTask(BuildContext context, BluetoothDevice server) async {
    try {
      _collectingTask = await BackgroundCollectingTask.connect(server);
      await _collectingTask.start();
    }
    catch (ex) {
      if (_collectingTask != null) {
        _collectingTask.cancel();
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error occured while connecting'),
            content: Text("${ex.toString()}"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}