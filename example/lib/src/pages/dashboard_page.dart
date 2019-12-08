import 'package:flutter/material.dart';
class DashboardPage extends StatefulWidget {
  DashboardPage({Key key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  
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
                _createInfoPacientesCard(),
                _createInfoTratamientosCard(),
                _createInfoEstadisticasCard(),
                _createExportInfoCard(),
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
          'Inicio', 
          style: TextStyle(color: Colors.black, fontSize: 20.0),
        ),
      ),
    );
  }

  Widget _createInfoPacientesCard(){
    return Card(
      margin: EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0 ,bottom: 20.0),
      color: Color.fromRGBO(231, 244, 235, 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 20.0),
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(
              'assets/images/avatar-masculino.jpg',
            ),
          ),
          const ListTile(
            title: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text('Gestionar pacientes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
              )
            ),
            subtitle: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
                child: Text(
                  'Revisa y actualiza la información personal, enfermedades, discapacidades, gustos y tratamientos de un paciente.', 
                  textAlign: TextAlign.center
                )
              )
            )
          ),          
          SizedBox(height: 10.0),
          Container(
            height: 40.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              )
            ),
          )
        ],
      ),
    );
  }
  
  Widget _createInfoTratamientosCard(){
    return Card(
      margin: EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0 ,bottom: 20.0),
      color: Color.fromRGBO(245, 231, 254, 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 20.0),
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(
              'assets/images/tratamiento.jpg',
            ),
          ),
          const ListTile(
            title: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text('Terapias motivacionales', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
              )
            ),
            subtitle: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
                child: Text(
                  'Crea y configura una terapia motivacional. Puedes incentivar a tu paciente con imagenes, videos y música.', 
                  textAlign: TextAlign.center
                )
              )
            )
          ),          
          SizedBox(height: 10.0),
          Container(
            height: 40.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              )
            ),
          )
        ],
      ),
    );
  }

  Widget _createInfoEstadisticasCard(){
    return Card(
      margin: EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0 ,bottom: 20.0),
      color: Color.fromRGBO(229, 247, 251, 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 20.0),
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(
              'assets/images/statistic.png',
            ),
          ),
          const ListTile(
            title: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text('Gráficos estadisticos', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
              )
            ),
            subtitle: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
                child: Text(
                  'Revisa el progreso de tus pacientes por medio de cuadros estadísticos. En cada cuadro encontraras información importante.', 
                  textAlign: TextAlign.center
                )
              )
            )
          ),          
          SizedBox(height: 10.0),
          Container(
            height: 40.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              )
            ),
          )
        ],
      ),
    );
  }

  Widget _createExportInfoCard(){
    return Card(
      margin: EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0 ,bottom: 20.0),
      color: Color.fromRGBO(233, 239, 253, 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 20.0),
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(
              'assets/images/excel.jpg',
            ),
          ),
          const ListTile(
            title: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text('Exporta tus datos', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
              )
            ),
            subtitle: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
                child: Text(
                  'Es importante compartir los datos de tu aplciación a otros sistemas. Si vez el icono superior presionalo para compartir tus datos.', 
                  textAlign: TextAlign.center
                )
              )
            )
          ),          
          SizedBox(height: 10.0),
          Container(
            height: 40.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              )
            ),
          )
        ],
      ),
    );
  }
}