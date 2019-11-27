import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial_example/src/models/persona.dart';
import 'package:intl/intl.dart';

class ProfileDetail extends StatefulWidget {
  @override
  _ProfileDetailState createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  final estiloTitulo = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  final estiloSubtitulo = TextStyle(fontSize: 18.0, color: Colors.grey);
  int selectedRadio = 0;
  int sexDefault = 1;
  int viaAccesoDefault = 1;
  int selectedViaAccesoRadio = 0;
  bool editable = false;
  Persona personaSelected;
  TextEditingController fechaNacimientoIController = new TextEditingController();

  @override
  void initState() { 
    super.initState();
    selectedRadio = 0;
  }

  setSelectedRadio(int val){
    setState(() {
      selectedRadio = val;
    });
  }

  setSelectedViaAccesoRadio(int val){
    setState(() {
      selectedViaAccesoRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    personaSelected = ModalRoute.of(context).settings.arguments;
    sexDefault = personaSelected.getSexState();
    viaAccesoDefault = personaSelected.viaAcceso;
    fechaNacimientoIController.text = personaSelected.fechaNacimiento;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            _createAppbar(),
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

  Widget _createAppbar(){
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
          personaSelected.getFullName(), 
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: AssetImage(personaSelected.getImage()),
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
        ListView(
          padding: EdgeInsets.all(20.0),
          children: <Widget>[
            _showInformacionPersonal(),
          ],
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
        _createTitle(),
        SizedBox(height: 20.0),
        _createNombresInput(),
        SizedBox(height: 20.0),
        _createApellidosInput(),
        SizedBox(height: 20.0),
        _createCedulaInput(),
        SizedBox(height: 20.0),
        _createTelefonoInput(),
        SizedBox(height: 20.0),
        _createDireccionInput(),
        SizedBox(height: 20.0),
        _createFechaNacimientoInput(context),
        SizedBox(height: 20.0),
        _createEtniaInput(),
        SizedBox(height: 20.0),
        _createViveConInput(),
        SizedBox(height: 20.0),
        Container(padding: EdgeInsets.only(left: 15.0), child: Text('Sexo', style: TextStyle(color: Colors.grey, fontSize: 13.0))),
        _createSexoRadioButton(),
        SizedBox(height: 20.0),
        Container(padding: EdgeInsets.only(left: 15.0), child: Text('Via de acceso', style: TextStyle(color: Colors.grey, fontSize: 13.0))),
        _createViaAccesoRadio(),
        SizedBox(height: 20.0),
        _createSaveButton(),
      ],
    );
  }
  
  Widget _createTitle(){
    return Row(
      children: <Widget>[
        Text('Información personal',style: estiloTitulo),
        SizedBox(width: 50.0),
        IconButton(
          icon: (editable) ? Icon(Icons.mode_edit, color: Colors.blue): Icon(Icons.edit, color: Colors.black),
          tooltip: 'Editar',
          onPressed: (){
            setState(() {
              if (editable){
                editable = false;
              }else{
                editable = true;
              }
            });
          },
        )
      ],
    );
  }

  Widget _createNombresInput() {
    return TextFormField(
      initialValue: personaSelected.nombres,
      enabled: (editable) ? (true) : false,
      decoration: InputDecoration(
        labelText: 'Nombres',
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        )
      ),
      onChanged: (value){
        personaSelected.nombres = value;
      },
    );
  }

  Widget _createApellidosInput() {
    return TextFormField(
      initialValue: personaSelected.apellidos,
      enabled: (editable) ? (true) : false,
      decoration: InputDecoration(
        labelText: 'Apellidos',
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        )
      ),
      onChanged: (value){
        personaSelected.apellidos = value;
      },
    );
  }

  Widget _createCedulaInput() {
    return TextFormField(
      initialValue: personaSelected.cedula,
      enabled: (editable) ? (true) : false,
      decoration: InputDecoration(
        labelText: 'Cédula',
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        )
      ),
      onChanged: (value){
        personaSelected.cedula = value;
      },
    );
  }

  Widget _createSexoRadioButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Radio(
          value: sexDefault - 1,
          groupValue: selectedRadio,
          onChanged: editable ? (value){setSelectedRadio(value);} : null,
        ),
        new Text(
          'Masculino',
          style: new TextStyle(fontSize: 16.0),
        ),
        new Radio(
          value: sexDefault,
          groupValue: selectedRadio,
          onChanged: editable ? (value){setSelectedRadio(value);} : null,
        ),
        new Text(
          'Femenino',
          style: new TextStyle(
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }

  Widget _createTelefonoInput() {
    return TextFormField(
      initialValue: personaSelected.telefonoContacto,
      enabled: (editable) ? (true) : false,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Teléfono',
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        )
      ),
      onChanged: (value){
        personaSelected.telefonoContacto = value;
      },
    );
  }

  Widget _createDireccionInput() {
    return TextFormField(
      initialValue: personaSelected.direccion,
      enabled: (editable) ? (true) : false,
      decoration: InputDecoration(
        labelText: 'Dirección',
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        )
      ),
      onChanged: (value){
        personaSelected.direccion = value;
      },
    );
  }

  Widget _createFechaNacimientoInput(BuildContext context){
    return TextFormField(
      controller: fechaNacimientoIController,
      enabled: (editable) ? (true) : false,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
        labelText: 'Fecha nacimiento',
        fillColor: Colors.white,
        suffixIcon: Icon(Icons.calendar_today),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        )
      ),
      onTap: (){
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
    );
  }

  _selectDate(BuildContext context) async{
    String fechaSeleccionada = '';
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: personaSelected.getEdadInDateTimeFormat(),
      firstDate: new DateTime(1900),
      lastDate: new DateTime(2025),
      locale: Locale('es', 'ES')
    );
    if (picked != null) {
      setState(() {
        fechaSeleccionada = DateFormat('yyyy-MM-dd').format(picked);
        personaSelected.fechaNacimiento = fechaSeleccionada;
        fechaNacimientoIController.text = personaSelected.fechaNacimiento;
      });
    }
  }

  Widget _createEtniaInput(){
    return TextFormField(
      initialValue: personaSelected.etnia,
      enabled: (editable) ? (true) : false,
      decoration: InputDecoration(
        labelText: 'Etnia',
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        )
      ),
      onChanged: (value){
        personaSelected.etnia = value;
      },
    );
  }

  Widget _createViveConInput(){
    return TextFormField(
      initialValue: personaSelected.viveCon,
      enabled: (editable) ? (true) : false,
      decoration: InputDecoration(
        labelText: 'Vive con',
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        )
      ),
      onChanged: (value){
        personaSelected.viveCon = value;
      },
    );
  }

  Widget _createViaAccesoRadio(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Radio(
          value: viaAccesoDefault - 1,
          groupValue: selectedViaAccesoRadio,
          onChanged: editable ? (value){setSelectedViaAccesoRadio(value);} : null,
        ),
        new Text(
          'Si',
          style: new TextStyle(fontSize: 16.0),
        ),
        new Radio(
          value: viaAccesoDefault,
          groupValue: selectedViaAccesoRadio,
          onChanged: editable ? (value){setSelectedViaAccesoRadio(value);} : null,
        ),
        new Text(
          'No',
          style: new TextStyle(
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }

  Widget _createSaveButton() {
    if (editable){
      return ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            color: Colors.blue,
            child: Text('Guardar', style: TextStyle(fontSize: 15.0, color: Colors.white)),
            onPressed: (){},
          ),
        ],
      );
    }else{
      return Container();
    }
    
  }
}