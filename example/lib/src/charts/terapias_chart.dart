import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial_example/src/models/charts/terapia_series.dart';

class TerapiaChart extends StatelessWidget {
  final List<TerapiaSeries> data;

  TerapiaChart({@required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<TerapiaSeries, String>> series = [
      charts.Series(
          id: "Terapias",
          data: data,
          domainFn: (TerapiaSeries series, _) => series.mes,
          measureFn: (TerapiaSeries series, _) => series.completadas,
          colorFn: (TerapiaSeries series, _) => series.barColor)
    ];

    return Container(
      height: 400,
      padding: EdgeInsets.all(20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(
                "Terapias completadas por mes",
                style: Theme.of(context).textTheme.body2,
              ),
              Expanded(
                child: charts.BarChart(series, animate: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}