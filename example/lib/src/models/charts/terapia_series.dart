import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class TerapiaSeries {
  final String mes;
  final int completadas;
  final charts.Color barColor;

  TerapiaSeries(
      {@required this.mes,
      @required this.completadas,
      @required this.barColor});
}