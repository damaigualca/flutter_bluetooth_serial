import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial_example/src/models/persona.dart';
import 'package:flutter_bluetooth_serial_example/src/models/terapia.dart';
import 'package:flutter_bluetooth_serial_example/src/services/persona_service.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class CreateTerapiaPage extends StatefulWidget {
  CreateTerapiaPage({Key key}) : super(key: key);

  @override
  _CreateTerapiaPageState createState() => _CreateTerapiaPageState();
}

class _CreateTerapiaPageState extends State<CreateTerapiaPage> {
  final TextEditingController _typeAheadController = TextEditingController();
  Persona personaSelected;
  int selectedRadio = 0;


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

  Map<String, int> selectedRadioGroup = {
    'ESCALERA': -1,
    'PIEZAS': -1,
    'RECORRIDO': -1,
    'FOCOS': -1
  };

  @override
  void initState() {
    super.initState();
    selectedRadioGroup['ESCALERA'] = 1;
    selectedRadioGroup['PIEZAS'] = 1;
    selectedRadioGroup['RECORRIDO'] = 1;
    selectedRadioGroup['FOCOS'] = 1;
  }

  setSelectedRadio(int val, String nombreTerapia){
    setState(() {
      selectedRadioGroup[nombreTerapia] = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          _createAppbar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _createTitle('Escriba el nombre del paciente'),
                _createSearchPacienteInput(),
                _createTitle('Seleccione una o más terapias'),
                _createTerapias(),
                SizedBox(height: 20.0),
              ]
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _createStartTerapiaButton(),
    );
  }

  Widget _createTitle(String title){
    return Container(
      padding: EdgeInsets.only(top: 20.0, left: 20.0),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold)
      ),
    );
  }

  Widget _createAppbar(){
    return SliverAppBar(
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      leading: new IconButton(
        icon: new Icon(Icons.arrow_back, color: Colors.blue),
        onPressed: () => Navigator.of(context).pop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          'Creación terapia recreativa',
          style: TextStyle(color: Colors.black, fontSize: 20.0),
        ),
      ),
    );
  }

  Widget _createSearchPacienteInput(){
    return Container(
      padding: EdgeInsets.all(20.0),
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
        noItemsFoundBuilder: (context){
          personaSelected = null;
          return ListTile(
            title: Text('No se encontraron elementos',style: TextStyle(color: Colors.blue)),
          );
        }
      )
    );
  }

  Widget _createTerapias(){
    return Container(
      padding: EdgeInsets.only(top: 20.0, left: 20.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              _createCheckbox('ESCALERA'),
              SizedBox(width: 10.0),
              _createImageTerapia('escalera.jpg'),
              SizedBox(width: 10.0),
              _createOptionsRadioButton('ESCALERA'),
              SizedBox(width: 10.0),
              _createSliderTerapias('Escalera', 'ESCALERA'),
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              _createCheckbox('PIEZAS'),
              SizedBox(width: 10.0),
              _createImageTerapia('piezas.jpg'),
              SizedBox(width: 10.0),
              _createOptionsRadioButton('PIEZAS'),
              SizedBox(width: 10.0),
              _createSliderTerapias('Completa las piezas', 'PIEZAS'),
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              _createCheckbox('RECORRIDO'),
              SizedBox(width: 10.0),
              _createImageTerapia('recorrido.jpg'),
              SizedBox(width: 10.0),
              _createOptionsRadioButton('RECORRIDO'),
              SizedBox(width: 10.0),
              _createSliderTerapias('Laberito', 'RECORRIDO'),
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              _createCheckbox('FOCOS'),
              SizedBox(width: 10.0),
              _createImageTerapia('focos.jpg'),
              SizedBox(width: 10.0),
              _createOptionsRadioButton('FOCOS'),
              SizedBox(width: 10.0),
              _createSliderTerapias('Tareas cotidianas', 'FOCOS'),
            ],
          ),
        ],
      )
    );
  }

  Widget _createCheckbox(String nombreTerapia){
    return Checkbox(
      value: terapias[nombreTerapia],
      onChanged: (bool value){
        setState(() {
          terapias[nombreTerapia] = value;
        });
      }
    );
  }

  Widget _createImageTerapia(String nombreImagen){
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Image(
        image: AssetImage('assets/images/$nombreImagen'),
        height: 100.0,
      ),
    );
  }

  Widget _createOptionsRadioButton(String nombreTerapia) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Radio(
              value: 1,
              groupValue: selectedRadioGroup[nombreTerapia],
              onChanged: (value){
                setSelectedRadio(value, nombreTerapia);
              },
            ),
            Text(
              'Audio',
              style: new TextStyle(fontSize: 12.0),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Radio(
              value: 0,
              groupValue: selectedRadioGroup[nombreTerapia],
              onChanged: (value){
                setSelectedRadio(value, nombreTerapia);
              },
            ),
            Text(
              'Video',
              style: new TextStyle(fontSize: 12.0),
            ),
          ],
        ),
      ],
    );
  }

  Widget _createSliderTerapias(String titulo, String nombreTerapia){
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            titulo,
            style: TextStyle(fontSize: 14.0),
            overflow: TextOverflow.ellipsis
          ),
          Text(
            'Número repeticiones: ${repeticionesTerapia[nombreTerapia].round().toString()}',
            style: TextStyle(fontSize: 10.0), overflow: TextOverflow.ellipsis
          ),
          Slider(
            label: repeticionesTerapia[nombreTerapia].round().toString(),
            value: repeticionesTerapia[nombreTerapia],
            min: 0.0,
            max: 5.0,
            divisions: 5,
            onChanged: (valor){
              setState(() {
                repeticionesTerapia[nombreTerapia] = valor;
              });
            },
          )
        ],
      ),
    );
  }

  Widget _createStartTerapiaButton(){
    return FloatingActionButton.extended(
      onPressed: (personaSelected == null || !_verifyExistOneTerapiaSelected()) ? (null) : (){
        Navigator.pushNamed(context, 'terapia', arguments: _buildTerapias());
      },
      backgroundColor: (personaSelected == null || !_verifyExistOneTerapiaSelected())
          ? (Colors.grey) : Colors.blue,
      label: Text('Iniciar'),
      icon: Icon(
        Icons.play_circle_filled,
      ),
    );
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
    String motivacion = 'AUDIO';
    terapias.forEach((k, v) {
      repeticionesTerapia.forEach((clave, valor){
        if (clave == k){
          repeticiones = valor.round();
        }
      });
      selectedRadioGroup.forEach((c, v) {
        if (c == k){
          motivacion = (v == 1) ? 'AUDIO' : 'VIDEO';
        }
      });
      if (v){
        listNuevasTerapias.add(Terapia(
            fechaCreacion,
            k,
            repeticiones,
            '',
            false,
            '',
            0,
            0,
            personaSelected.id,
            personaSelected,
            motivacion)
        );
      }
    });
    return listNuevasTerapias;
  }
}