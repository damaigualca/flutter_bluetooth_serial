import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_bluetooth_serial_example/src/charts/terapias_chart.dart';
import 'package:flutter_bluetooth_serial_example/src/models/charts/terapia_series.dart';

class StatPage extends StatefulWidget {

  StatPage({Key key}) : super(key: key);

  @override
  _StatPageState createState() => _StatPageState();
}

class _StatPageState extends State<StatPage> {
final List<TerapiaSeries> data = [
    TerapiaSeries(
      mes: "Enero",
      completadas: 10,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    TerapiaSeries(
      mes: "Febrero",
      completadas: 15,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    TerapiaSeries(
      mes: "Marzo",
      completadas: 20,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    TerapiaSeries(
      mes: "Abril",
      completadas: 32,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
  ];
  @override
  initState() {
    super.initState();
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
                _createChartExample()
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
          'Estadisticas', 
          style: TextStyle(color: Colors.black, fontSize: 20.0),
        ),
      ),
    );
  }

  Widget _createChartExample(){
    return Container(
      child: TerapiaChart(data: data,),
    );
  }
}