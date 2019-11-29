import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial_example/src/models/discapacidad_persona.dart';
import 'package:flutter_bluetooth_serial_example/src/models/enfermedad_persona.dart';
import 'package:flutter_bluetooth_serial_example/src/models/persona.dart';
import 'package:flutter_bluetooth_serial_example/src/services/discapacidad_persona.dart';
import 'package:flutter_bluetooth_serial_example/src/services/enfermedad_persona_service.dart';
import 'package:intl/intl.dart';

class ProfileDetail extends StatefulWidget {
  @override
  _ProfileDetailState createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> with SingleTickerProviderStateMixin{
  final estiloTitulo = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  final estiloSubtitulo = TextStyle(fontSize: 18.0, color: Colors.grey);
  int selectedRadio = 0;
  int sexDefault = 1;
  int viaAccesoDefault = 1;
  int selectedViaAccesoRadio = 0;
  bool editable = false;
  Persona personaSelected;
  TextEditingController fechaNacimientoIController = new TextEditingController();
  Future<List<EnfermedadPersona>> futureEnfermedad;
  Future<List<DiscapacidadPersona>> futureDiscapacidad;
TabController controller;
  @override
  void initState() { 
    super.initState();
    selectedRadio = 0;
    controller = TabController(
      length: 4,
      vsync: this,
    );
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
    futureEnfermedad = EnfermedadPersonaService.getAll(personaSelected.id);
    futureDiscapacidad = DiscapacidadPersonaService.getAll(personaSelected.id);

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _createAppbar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _createTabs(),
              ]
            ),
          ),
          SliverFillRemaining(
            child: _createTabViews(),
          )
        ],
      ),
    );
  }

  Widget _createAppbar(){
    return SliverAppBar(
      backgroundColor: Colors.blue,
      brightness: Brightness.light,
      expandedHeight: 250.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          personaSelected.getFullName(), 
          style: TextStyle(color: Colors.white, fontSize: 12.0),
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
            controller: controller,
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
      controller: controller,
      children: [
        SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(20.0),
          child: _showInformacionPersonal()
        ),
        SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(20.0),
          child: _showEnfermedadesDiscapacidades(),
        ),
        ListView(
          padding: EdgeInsets.all(20.0),
          children: <Widget>[
            _createTitleDiscapacidades(),
          ],
        ),
        ListView(
          padding: EdgeInsets.only(top: 30.0, left: 20.0),
          children: <Widget>[
            _createTitleTerapias(),
          ],
        )
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

  Widget _showEnfermedadesDiscapacidades(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _createTitleEnfermades(),
        _buildEnfermedades(),
        SizedBox(height: 20.0),
        _createTitleDiscapacidades(),
        _buildDiscapacidades()
      ],
    );
  }
  
  Widget _buildEnfermedades(){
    return FutureBuilder(
      future: futureEnfermedad,
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if(snapshot.hasData){
          return SingleChildScrollView(
            child: DataTable(
              columns: [
                DataColumn(label: Text('Enfermedad')),
                DataColumn(label: Text('Nivel')),
                DataColumn(label: Text('Tratamiento')),
              ],
              rows: snapshot.data
                .map((ep) => DataRow(
                  cells: [
                    DataCell(Text(ep.nombre)),
                    DataCell(Text(ep.nivelEnfermedad)),
                    DataCell(Text(ep.tipoTratamiento)),
                  ]
                )).toList()
            ),
          );
        }else{
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget _buildDiscapacidades(){
    return FutureBuilder(
      future: futureDiscapacidad,
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if(snapshot.hasData){
          return SingleChildScrollView(
            child: DataTable(
              columns: [
                DataColumn(label: Text('Discapacidad')),
                DataColumn(label: Text('Porcentaje')),
                DataColumn(label: Text('Descripción')),
              ],
              rows: snapshot.data
                .map((dp) => DataRow(
                  cells: [
                    DataCell(Text(dp.nombre)),
                    DataCell(Text('${dp.porcentaje.round().toString()} %')),
                    DataCell(Text(dp.descripcion)),
                  ]
                )).toList()
            ),
          );
        }else{
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget _createTitle(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('Información personal',style: estiloTitulo),
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

  Widget _createTitleEnfermades(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('Enfermedades',style: estiloTitulo),
        IconButton(
          icon: (editable) ? Icon(Icons.mode_edit, color: Colors.blue): Icon(Icons.edit, color: Colors.black),
          tooltip: 'Editar',
          onPressed: (){
            // setState(() {
            //   if (editable){
            //     editable = false;
            //   }else{
            //     editable = true;
            //   }
            // });
          },
        )
      ],
    );
  }

  Widget _createTitleDiscapacidades(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('Discapacidades',style: estiloTitulo),
        IconButton(
          icon: (editable) ? Icon(Icons.mode_edit, color: Colors.blue): Icon(Icons.edit, color: Colors.black),
          tooltip: 'Editar',
          onPressed: (){
            // setState(() {
            //   if (editable){
            //     editable = false;
            //   }else{
            //     editable = true;
            //   }
            // });
          },
        )
      ],
    );
  }

  Widget _createTitleTerapias(){
    return Row(
      children: <Widget>[
        Text('Lista de terapias completadas',style: estiloTitulo),
        SizedBox(width: 50.0),
      ],
    );
  }
}